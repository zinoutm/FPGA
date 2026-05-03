-- =============================================================================
-- Instruction_FIFO.vhd  — WITH KILL FLUSH
-- =============================================================================
-- NEW FEATURE: KILL FLUSH
--   Added kill_acknowledged input from Step_Generator
--   When kill_acknowledged = '1', FIFO immediately flushes all queued instructions
--   This prevents the CNC from continuing execution after emergency stop
--
-- Previous fixes still included:
-- - Bug 7: Registered output to prevent race conditions
-- - Bug 8: 2-stage CDC synchronizer for faster response
-- =============================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_FIFO is
    port (
        clk                : in  std_logic;
        packet_in          : in  std_logic_vector(143 downto 0);
        packet_ready       : in  std_logic;
        move_finished      : in  std_logic;
        kill_acknowledged  : in  std_logic;  -- NEW: from Step_Generator
        fifo_out           : out std_logic_vector(143 downto 0);
        fifo_count_out     : out integer range 0 to 8
    );
end entity Instruction_FIFO;

architecture Behavioral of Instruction_FIFO is

    type ram_type is array (0 to 7) of std_logic_vector(143 downto 0);
    signal fifo_mem   : ram_type := (others => (others => '0'));
    signal write_ptr  : integer range 0 to 7 := 0;
    signal read_ptr   : integer range 0 to 7 := 0;
    signal fifo_count : integer range 0 to 8 := 0;

    -- Registered output register
    signal out_reg    : std_logic_vector(143 downto 0) := (others => '0');

    -- GAO probes
    signal gao_slot0  : std_logic_vector(143 downto 0);
    signal gao_slot1  : std_logic_vector(143 downto 0);
    attribute keep : boolean;
    attribute keep of gao_slot0  : signal is true;
    attribute keep of gao_slot1  : signal is true;
    attribute keep of fifo_count : signal is true;

    -- 2-stage CDC synchronizer
    signal sync_chain    : std_logic_vector(1 downto 0) := "00";
    signal safe_push     : std_logic;

    signal move_done_prev : std_logic := '0';

begin

    ---------------------------------------------------------------------------
    -- 1. CDC SYNCHRONIZER (2-stage, edge on bits [1:0])
    ---------------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            sync_chain <= sync_chain(0) & packet_ready;
        end if;
    end process;

    safe_push <= '1' when sync_chain = "01" else '0';

    ---------------------------------------------------------------------------
    -- 2. FIFO CORE LOGIC WITH KILL FLUSH
    ---------------------------------------------------------------------------
    process(clk)
        variable do_push      : boolean;
        variable do_pop       : boolean;
        variable next_rd_ptr  : integer range 0 to 7;
    begin
        if rising_edge(clk) then
            
            -----------------------------------------------------------------------
            -- NEW: KILL FLUSH (highest priority)
            -----------------------------------------------------------------------
            if kill_acknowledged = '1' then
                -- Emergency stop - flush all queued instructions
                write_ptr  <= 0;
                read_ptr   <= 0;
                fifo_count <= 0;
                out_reg    <= (others => '0');
                -- Note: We DON'T clear fifo_mem contents (not necessary)
                -- Just reset pointers so nothing is visible to consumer
                
            else
                -- NORMAL OPERATION
                do_push := (safe_push = '1' and fifo_count < 8);
                do_pop  := (move_finished = '1' and move_done_prev = '0'
                            and fifo_count > 0);

                if do_push and do_pop then
                    -- Simultaneous push + pop
                    fifo_mem(write_ptr) <= packet_in;
                    write_ptr  <= (write_ptr + 1) mod 8;
                    next_rd_ptr := (read_ptr + 1) mod 8;
                    read_ptr   <= next_rd_ptr;
                    -- fifo_count unchanged
                    out_reg    <= fifo_mem(next_rd_ptr);

                elsif do_push then
                    fifo_mem(write_ptr) <= packet_in;
                    write_ptr  <= (write_ptr + 1) mod 8;
                    fifo_count <= fifo_count + 1;
                    -- If FIFO was empty, immediately load the output register
                    if fifo_count = 0 then
                        out_reg <= packet_in;
                    end if;

                elsif do_pop then
                    next_rd_ptr := (read_ptr + 1) mod 8;
                    read_ptr   <= next_rd_ptr;
                    fifo_count <= fifo_count - 1;
                    out_reg    <= fifo_mem(next_rd_ptr);
                end if;
            end if;

            move_done_prev <= move_finished;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- 3. GAO DEBUG PROCESS
    ---------------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            gao_slot0 <= fifo_mem(0);
            gao_slot1 <= fifo_mem(1);
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- 4. OUTPUTS
    ---------------------------------------------------------------------------
    fifo_out       <= out_reg;
    fifo_count_out <= fifo_count;

end architecture Behavioral;

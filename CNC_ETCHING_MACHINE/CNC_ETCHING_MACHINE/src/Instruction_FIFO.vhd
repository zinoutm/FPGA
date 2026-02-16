library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_FIFO is
    port (
        clk            : in  std_logic;
        packet_in      : in  std_logic_vector(143 downto 0);
        packet_ready   : in  std_logic;
        move_finished  : in  std_logic;
        fifo_out       : out std_logic_vector(143 downto 0);
        fifo_count_out : out integer range 0 to 8
    );
end entity Instruction_FIFO;

architecture Behavioral of Instruction_FIFO is
    type ram_type is array (0 to 7) of std_logic_vector(143 downto 0);
    signal fifo_mem       : ram_type := (others => (others => '0'));
    signal write_ptr      : integer range 0 to 7 := 0;
    signal read_ptr       : integer range 0 to 7 := 0;
    signal fifo_count     : integer range 0 to 8 := 0;

-- 1. ADD THESE FLATTENED SIGNALS
    signal gao_slot0 : std_logic_vector(143 downto 0);
    signal gao_slot1 : std_logic_vector(143 downto 0);
    
    -- 2. ADD THESE ATTRIBUTES (Crucial for GAO)
    attribute keep : boolean;
    attribute keep of gao_slot0 : signal is true;
    attribute keep of gao_slot1 : signal is true;
    attribute keep of fifo_count : signal is true;

    -- CDC Synchronizer (packet_ready: SCLK → CLK domain)
    signal sync_chain     : std_logic_vector(2 downto 0) := "000";
    signal safe_push      : std_logic;

    -- Edge detection signals (MUST be signals not variables!)
    signal move_done_prev : std_logic := '0';

begin
    ---------------------------------------------------------------------------
    -- 1. CDC SYNCHRONIZER
    -- Bridges packet_ready from SPI (sclk) to System Clock (clk)
    ---------------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            sync_chain <= sync_chain(1 downto 0) & packet_ready;
        end if;
    end process;

    -- 1-cycle pulse on rising edge of synced signal
    safe_push <= '1' when sync_chain(2 downto 1) = "01" else '0';

    ---------------------------------------------------------------------------
    -- 2. FIFO CORE LOGIC
    ---------------------------------------------------------------------------
    process(clk)
        variable do_push : boolean;
        variable do_pop  : boolean;
    begin
        if rising_edge(clk) then

            do_push := (safe_push = '1' and fifo_count < 8);
            do_pop  := (move_finished = '1' and move_done_prev = '0'
                        and fifo_count > 0);

            -- Simultaneous push and pop
            if do_push and do_pop then
                fifo_mem(write_ptr) <= packet_in;
                write_ptr <= (write_ptr + 1) mod 8;
                read_ptr  <= (read_ptr  + 1) mod 8;
                -- fifo_count unchanged (one in, one out)

            -- Push only
            elsif do_push then
                fifo_mem(write_ptr) <= packet_in;
                write_ptr  <= (write_ptr + 1) mod 8;
                fifo_count <= fifo_count + 1;

            -- Pop only
            elsif do_pop then
                read_ptr   <= (read_ptr + 1) mod 8;
                fifo_count <= fifo_count - 1;
            end if;

            -- Update edge detection (signal persists across cycles)
            move_done_prev <= move_finished;

        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            gao_slot0 <= fifo_mem(0);
            gao_slot1 <= fifo_mem(1);
        end if;
    end process;
    ---------------------------------------------------------------------------
    -- 3. OUTPUTS
    ---------------------------------------------------------------------------
    fifo_out       <= fifo_mem(read_ptr);
    fifo_count_out <= fifo_count;

end architecture Behavioral;

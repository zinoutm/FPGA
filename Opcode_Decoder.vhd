-- =============================================================================
-- Opcode_Decoder.vhd  — CORRECTED RELEASE
-- =============================================================================
-- PROBLEM IDENTIFIED IN PREVIOUS "FIXED RELEASE":
--
-- Bug 6 fix was WRONG in combination with the Bug 7 (FIFO registered output).
--
-- Bug 7 fix made fifo_out a REGISTERED output (out_reg), meaning:
--   • At cycle P (move_finished fires): fifo_out = old instruction (Instr_A)
--   • At cycle P+1:                     fifo_out = next instruction (Instr_B)
--
-- Bug 6 fix made exec_target_x/y/z only latch when ready_condition fires.
-- ready_condition fires at cycle P (same cycle as move_finished).
-- At cycle P, fifo_out is still Instr_A (stale).
-- So exec_target_z gets Instr_A's Z — the instruction that just FINISHED.
-- Step_Generator then reads that stale Z target at cycle P+2 in CALC_DELTA.
-- Result: every move after the first executes the PREVIOUS instruction's
-- targets, causing wrong Z depth (and in general all axes are wrong).
--
-- THE FIX:
--   Revert Bug 6. Restore exec_target_x/y/z to update on EVERY clock cycle,
--   exactly like the original decoder. By cycle P+2 when Step_Generator
--   reaches CALC_DELTA, fifo_out has already settled on Instr_B (since P+1),
--   and exec_target_z has been tracking it — correct value guaranteed.
--
--   This works with BOTH the original FIFO (combinatorial output) and the
--   fixed FIFO (registered output, Bug 7), because the target tracking always
--   catches up within one cycle.
--
-- PRESERVED FROM PREVIOUS RELEASE:
--   Bug 5 fix  — broadened ready_condition (data_available_d1, move_finished_prev)
--   spindle_speed port — latches raw_feed on M3, cleared on M5/stop/kill
--
-- =============================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Opcode_Decoder is
    port (
        clk                 : in  std_logic;
        raw_opcode          : in  std_logic_vector(7 downto 0);
        raw_target_x        : in  std_logic_vector(31 downto 0);
        raw_target_y        : in  std_logic_vector(31 downto 0);
        raw_target_z        : in  std_logic_vector(31 downto 0);
        raw_feed            : in  std_logic_vector(15 downto 0);
        current_x           : in  std_logic_vector(31 downto 0);
        current_y           : in  std_logic_vector(31 downto 0);
        current_z           : in  std_logic_vector(31 downto 0);
        exec_target_x       : out std_logic_vector(31 downto 0);
        exec_target_y       : out std_logic_vector(31 downto 0);
        exec_target_z       : out std_logic_vector(31 downto 0);
        exec_feed           : out std_logic_vector(15 downto 0);
        data_available      : in  std_logic;
        move_finished_in    : in  std_logic;
        pause_flag          : out std_logic := '0';
        progress_stop       : out std_logic := '0';
        is_motion           : out std_logic := '0';
        kill_flag           : out std_logic := '0';
        spindle_on          : out std_logic := '0';
        spindle_speed       : out std_logic_vector(15 downto 0) := (others => '0');
        instruction_ready   : out std_logic := '0';
        homing_reset        : out std_logic := '0'
    );
end entity Opcode_Decoder;

architecture Behavioral of Opcode_Decoder is

    -- Bug 5 fix signals (kept)
    signal data_available_prev : std_logic := '0';
    signal data_available_d1   : std_logic := '0';
    signal move_finished_prev  : std_logic := '0';

    -- Spindle speed register (kept)
    signal spindle_speed_reg : std_logic_vector(15 downto 0) := (others => '0');

    -- ready_condition (Bug 5 fix — kept, drives instruction_ready)
    signal ready_condition : std_logic;

begin

    -- =========================================================================
    -- Bug 5 fix: broadened ready_condition
    -- =========================================================================
    ready_condition <=
        '1' when (
            (data_available = '1' and data_available_prev = '0') or
            ((move_finished_in = '1' or move_finished_prev = '1') and
             (data_available = '1' or data_available_d1 = '1'))
        ) and raw_opcode /= x"18"
        else '0';

    process(clk)
    begin
        if rising_edge(clk) then

            -- Edge detection shift registers (Bug 5 fix — kept)
            data_available_prev <= data_available;
            data_available_d1   <= data_available_prev;
            move_finished_prev  <= move_finished_in;

            -- instruction_ready is the registered ready_condition
            instruction_ready <= ready_condition;

            -- ---------------------------------------------------------------
            -- Kill flag
            -- ---------------------------------------------------------------
            if raw_opcode = x"18" then
                kill_flag         <= '1';
                spindle_on        <= '0';
                spindle_speed_reg <= (others => '0');
                homing_reset      <= '0';
            else
                kill_flag <= '0';

                -- Homing
                if raw_opcode = x"E1" and data_available = '1' then
                    homing_reset <= '1';
                elsif move_finished_in = '1' then
                    homing_reset <= '0';
                end if;

                -- Pause / Resume
                if raw_opcode = x"24" or raw_opcode = x"44" then
                    pause_flag <= '1';
                elsif raw_opcode = x"28" or raw_opcode = x"48" then
                    pause_flag <= '0';
                end if;

                -- Motion detection
                if (raw_opcode(0) = '1' or raw_opcode(1) = '1' or
                    raw_opcode = x"30" or raw_opcode = x"E1") then
                    is_motion <= '1';
                else
                    is_motion <= '0';
                end if;

                -- Spindle control + speed latch
                if raw_opcode(2) = '1' then
                    spindle_on        <= '1';
                    spindle_speed_reg <= raw_feed;   -- M3: latch S-word speed
                elsif raw_opcode(3) = '1' then
                    spindle_on        <= '0';
                    spindle_speed_reg <= (others => '0');  -- M5: clear
                end if;

                -- Program stop
                if raw_opcode(4) = '1' then
                    progress_stop     <= '1';
                    spindle_on        <= '0';
                    spindle_speed_reg <= (others => '0');
                else
                    progress_stop <= '0';
                end if;

            end if;

            -- ---------------------------------------------------------------
            -- Axis target routing — updated EVERY clock (Bug 6 reverted)
            --
            -- exec_target_x/y/z track fifo_out continuously. By the time
            -- Step_Generator reaches CALC_DELTA (cycle P+2), fifo_out has
            -- already settled on the correct next instruction (since P+1),
            -- and these registers have caught up. This is safe with both
            -- the original (combinatorial) FIFO output and the Bug-7-fixed
            -- (registered) FIFO output.
            -- ---------------------------------------------------------------
            if raw_opcode(5) = '1' then
                exec_target_x <= raw_target_x;
            else
                exec_target_x <= current_x;
            end if;

            if raw_opcode(6) = '1' then
                exec_target_y <= raw_target_y;
            else
                exec_target_y <= current_y;
            end if;

            if raw_opcode(7) = '1' then
                exec_target_z <= raw_target_z;
            else
                exec_target_z <= current_z;
            end if;

            -- Feedrate (unchanged)
            if raw_opcode(1) = '1' then
                exec_feed <= x"FFFE";
            elsif raw_opcode(0) = '1' then
                exec_feed <= raw_feed;
            else
                exec_feed <= x"0000";
            end if;

        end if;
    end process;

    -- Spindle speed output
    spindle_speed <= spindle_speed_reg;

end architecture Behavioral;

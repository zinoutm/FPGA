-- =============================================================================
-- CNC_ETCHING_MACHINE.vhd  — WITH KILL FLUSH CAPABILITY
-- =============================================================================
-- NEW FEATURE: KILL FLUSH
--   Added kill_acknowledged signal connection between Step_Generator and FIFO
--   When emergency stop (0x18) is pressed:
--     1. Step_Generator stops immediately and sets kill_acknowledged='1'
--     2. FIFO receives signal and flushes all queued instructions
--     3. CNC stops at current position (no homing)
--     4. Ready to accept new G-code immediately
--
-- Previous features maintained:
--   - PWM spindle control
--   - Homing with limit switches
--   - Pause/resume functionality
-- =============================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CNC_ETCHING_MACHINE is
    port (
        clk         : in  std_logic;
        sclk        : in  std_logic;
        mosi        : in  std_logic;
        miso        : out std_logic;
        cs_n        : in  std_logic;
        ready_pin   : out std_logic;
        step_x      : out std_logic := '0';
        step_y      : out std_logic := '0';
        step_z      : out std_logic := '0';
        dir_x       : buffer std_logic := '0';
        dir_y       : buffer std_logic := '0';
        dir_z       : buffer std_logic := '0';
        spindle_pwm : out std_logic := '0';
        limit_x     : in  std_logic;
        limit_y     : in  std_logic;
        limit_z     : in  std_logic
    );
end entity CNC_ETCHING_MACHINE;

architecture structural of CNC_ETCHING_MACHINE is

    signal inst_index        : std_logic_vector(15 downto 0);
    signal raw_opcode        : std_logic_vector(7 downto 0);
    signal raw_target_x      : std_logic_vector(31 downto 0);
    signal raw_target_y      : std_logic_vector(31 downto 0);
    signal raw_target_z      : std_logic_vector(31 downto 0);
    signal raw_feed          : std_logic_vector(15 downto 0);
    signal checksum          : std_logic_vector(7 downto 0);
    signal target_x          : std_logic_vector(31 downto 0);
    signal target_y          : std_logic_vector(31 downto 0);
    signal target_z          : std_logic_vector(31 downto 0);
    signal feed_rate         : std_logic_vector(15 downto 0);
    signal current_x         : std_logic_vector(31 downto 0) := (others => '0');
    signal current_y         : std_logic_vector(31 downto 0) := (others => '0');
    signal current_z         : std_logic_vector(31 downto 0) := (others => '0');
    signal shift_rx          : std_logic_vector(143 downto 0);
    signal act_instr         : std_logic_vector(143 downto 0);
    signal packet_done       : std_logic;
    signal fifo_count        : integer range 0 to 8;
    signal move_finished     : std_logic := '0';
    signal data_available    : std_logic := '0';
    signal is_motion         : std_logic;
    signal instruction_ready : std_logic;
    signal pause_flag        : std_logic := '0';
    signal kill_flag         : std_logic;
    signal homing_reset      : std_logic;

    -- NEW: Kill acknowledgment signal from Step_Generator to FIFO
    signal kill_acknowledged : std_logic;

    -- Spindle control signals
    signal spindle_on_sig    : std_logic;
    signal spindle_speed_sig : std_logic_vector(15 downto 0);

begin

    -- =========================================================================
    -- SPI Interface
    -- =========================================================================
    SPI_Unit : entity work.SPI_Interface
        port map (
            sclk         => sclk,
            mosi         => mosi,
            miso         => miso,
            cs_n         => cs_n,
            current_x    => current_x,
            current_y    => current_y,
            current_z    => current_z,
            inst_index   => inst_index,
            packet_out   => shift_rx,
            packet_valid => packet_done
        );

    -- =========================================================================
    -- Instruction FIFO (WITH KILL FLUSH)
    -- =========================================================================
    FIFO_Unit : entity work.Instruction_FIFO
        port map (
            clk               => clk,
            packet_in         => shift_rx,
            packet_ready      => packet_done,
            move_finished     => move_finished,
            kill_acknowledged => kill_acknowledged,  -- NEW: receives flush signal
            fifo_out          => act_instr,
            fifo_count_out    => fifo_count
        );

    -- =========================================================================
    -- Opcode Decoder
    -- =========================================================================
    The_Decoder : entity work.Opcode_Decoder
        port map (
            clk               => clk,
            raw_opcode        => raw_opcode,
            raw_target_x      => raw_target_x,
            raw_target_y      => raw_target_y,
            raw_target_z      => raw_target_z,
            raw_feed          => raw_feed,
            current_x         => current_x,
            current_y         => current_y,
            current_z         => current_z,
            exec_target_x     => target_x,
            exec_target_y     => target_y,
            exec_target_z     => target_z,
            exec_feed         => feed_rate,
            data_available    => data_available,
            move_finished_in  => move_finished,
            pause_flag        => pause_flag,
            homing_reset      => homing_reset,
            is_motion         => is_motion,
            kill_flag         => kill_flag,
            spindle_on        => spindle_on_sig,
            spindle_speed     => spindle_speed_sig,
            instruction_ready => instruction_ready
        );

    -- =========================================================================
    -- Step Generator (WITH KILL ACKNOWLEDGMENT OUTPUT)
    -- =========================================================================
    Motor_Driver : entity work.Step_Generator
        port map (
            clk               => clk,
            current_x_out     => current_x,
            current_y_out     => current_y,
            current_z_out     => current_z,
            target_x          => target_x,
            target_y          => target_y,
            target_z          => target_z,
            feed_rate         => feed_rate,
            instruction_ready => instruction_ready,
            is_motion         => is_motion,
            kill_flag         => kill_flag,
            pause_flag        => pause_flag,
            homing_reset      => homing_reset,
            move_finished     => move_finished,
            kill_acknowledged => kill_acknowledged,  -- NEW: outputs flush signal
            limit_x           => limit_x,
            limit_y           => limit_y,
            limit_z           => limit_z,
            step_x            => step_x,
            dir_x             => dir_x,
            step_y            => step_y,
            dir_y             => dir_y,
            step_z            => step_z,
            dir_z             => dir_z
        );

    -- =========================================================================
    -- Spindle PWM Controller
    -- =========================================================================
    Spindle_Driver : entity work.Spindle_PWM
        port map (
            clk     => clk,
            enable  => spindle_on_sig,
            kill    => kill_flag,
            speed   => spindle_speed_sig,
            pwm_out => spindle_pwm
        );

    ---------------------------------------------------------------------------
    -- Status & handshake
    ---------------------------------------------------------------------------
    ready_pin      <= '1' when (fifo_count < 8) else '0';
    data_available <= '1' when (fifo_count > 0)  else '0';

    ---------------------------------------------------------------------------
    -- Mapping logic
    ---------------------------------------------------------------------------
    process(fifo_count, act_instr, current_x, current_y, current_z)
        variable p : std_logic_vector(143 downto 0);
    begin
        p := act_instr;

        if fifo_count > 0 then
            inst_index   <= p(135 downto 128) & p(143 downto 136);
            raw_opcode   <= p(127 downto 120);
            raw_target_x <= p(95  downto 88)  & p(103 downto 96)  &
                            p(111 downto 104) & p(119 downto 112);
            raw_target_y <= p(63  downto 56)  & p(71  downto 64)  &
                            p(79  downto 72)  & p(87  downto 80);
            raw_target_z <= p(31  downto 24)  & p(39  downto 32)  &
                            p(47  downto 40)  & p(55  downto 48);
            raw_feed     <= p(15  downto 8)   & p(23  downto 16);
            checksum     <= p(7   downto 0);
        else
            inst_index   <= (others => '0');
            raw_opcode   <= (others => '0');
            raw_target_x <= current_x;
            raw_target_y <= current_y;
            raw_target_z <= current_z;
            raw_feed     <= (others => '0');
            checksum     <= (others => '0');
        end if;
    end process;

end architecture structural;

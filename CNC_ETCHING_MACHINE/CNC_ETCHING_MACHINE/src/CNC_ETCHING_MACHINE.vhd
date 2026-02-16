library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CNC_ETCHING_MACHINE is
    port (
        clk        : in  std_logic;
        sclk       : in  std_logic;
        mosi       : in  std_logic;
        miso       : out std_logic;
        cs_n       : in  std_logic;
        ready_pin  : out std_logic;
        step_x     : out std_logic := '0';
        step_y     : out std_logic := '0';
        step_z     : out std_logic := '0';
        dir_x      : buffer std_logic := '0';
        dir_y      : buffer std_logic := '0';
        dir_z      : buffer std_logic := '0';
        spindle_on : out std_logic := '0'
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
    signal pause_flag        : std_logic;
    signal kill_flag         : std_logic;
    signal homing_reset      : std_logic;

begin

    -- SPI
    SPI_Unit : entity work.SPI_Interface
        port map (
            sclk         => sclk,
            mosi         => mosi,
            miso         => miso,
            cs_n         => cs_n,
            current_x    => current_x,
            current_y    => current_y,
            current_z    => current_z,
            packet_out   => shift_rx,
            packet_valid => packet_done
        );

    -- FIFO
    FIFO_Unit : entity work.Instruction_FIFO
        port map (
            clk            => clk,
            packet_in      => shift_rx,
            packet_ready   => packet_done,
            move_finished  => move_finished,
            fifo_out       => act_instr,
            fifo_count_out => fifo_count
        );

    -- Decoder
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
            pause_flag        => pause_flag,
            homing_reset      => homing_reset,
            is_motion         => is_motion,
            kill_flag         => kill_flag,
            spindle_on        => spindle_on,
            instruction_ready => instruction_ready
        );

    -- Step Generator
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
            step_x            => step_x,
            dir_x             => dir_x,
            step_y            => step_y,
            dir_y             => dir_y,
            step_z            => step_z,
            dir_z             => dir_z
        );

    ---------------------------------------------------------------------------
    -- STATUS & HANDSHAKE
    ---------------------------------------------------------------------------
    ready_pin      <= '1' when (fifo_count < 7) else '0';
    data_available <= '1' when (fifo_count > 0) else '0';

    ---------------------------------------------------------------------------
    -- MAPPING LOGIC
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
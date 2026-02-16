library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Step_Generator is
    port (
        clk                : in  std_logic;
        current_x_out      : out std_logic_vector(31 downto 0);
        current_y_out      : out std_logic_vector(31 downto 0);
        current_z_out      : out std_logic_vector(31 downto 0);
        target_x           : in  std_logic_vector(31 downto 0);
        target_y           : in  std_logic_vector(31 downto 0);
        target_z           : in  std_logic_vector(31 downto 0);
        feed_rate          : in  std_logic_vector(15 downto 0);
        instruction_ready  : in  std_logic;
        is_motion          : in  std_logic;
        kill_flag          : in  std_logic;
        pause_flag         : in  std_logic;
        homing_reset       : in  std_logic;
        move_finished      : out std_logic := '0';
        step_x             : out std_logic := '0';
        step_y             : out std_logic := '0';
        step_z             : out std_logic := '0';
        dir_x              : buffer std_logic := '0';
        dir_y              : buffer std_logic := '0';
        dir_z              : buffer std_logic := '0'
    );
end entity Step_Generator;

architecture Behavioral of Step_Generator is

    type state_type is (IDLE, CALC_DELTA, CALC_MASTER, MOVE, FINISH);
    signal current_state : state_type := IDLE;

    signal current_x  : unsigned(31 downto 0) := (others => '0');
    signal current_y  : unsigned(31 downto 0) := (others => '0');
    signal current_z  : unsigned(31 downto 0) := (others => '0');
    signal delta_x    : unsigned(31 downto 0) := (others => '0');
    signal delta_y    : unsigned(31 downto 0) := (others => '0');
    signal delta_z    : unsigned(31 downto 0) := (others => '0');
    signal master_steps : unsigned(31 downto 0) := (others => '0');
    signal step_count   : unsigned(31 downto 0) := (others => '0');
    signal acc_x        : unsigned(31 downto 0) := (others => '0');
    signal acc_y        : unsigned(31 downto 0) := (others => '0');
    signal acc_z        : unsigned(31 downto 0) := (others => '0');

    -- tick_count needs enough bits for max delay value
    -- max ticks = 0xFFFF = 65535 → needs 17 bits
    signal tick_count : unsigned(16 downto 0) := (others => '0');

    -- Prescaler: counts 0 to 810 → needs 10 bits
    signal prescaler  : integer range 0 to 1023 := 0;

    -- step_hold: counts 0 to 270 @ 27MHz = 10µs pulse
    signal step_hold  : integer range 0 to 270 := 0;

    -- Debug signals
    signal step_x_total : unsigned(31 downto 0) := (others => '0');
    signal step_x_latch : std_logic := '0';

    attribute keep : boolean;
    attribute keep of step_x_total : signal is true;
    attribute keep of step_x_latch : signal is true;

    ---------------------------------------------------------------------------
    -- TIMING CONSTANTS (verified for 27MHz clock)
    ---------------------------------------------------------------------------
    -- Prescaler: 27MHz / 811 = 33,292 Hz base frequency
    constant PRESCALER_MAX  : integer := 810;

    -- Step pulse width: 270 cycles @ 27MHz = 10µs
    -- Safe for A4988, DRV8825, TMC2208/2209
    constant STEP_HOLD_MAX  : integer := 270;

begin

    current_x_out <= std_logic_vector(current_x);
    current_y_out <= std_logic_vector(current_y);
    current_z_out <= std_logic_vector(current_z);

    process(clk)
    begin
        if rising_edge(clk) then

            -- GLOBAL KILL
            if kill_flag = '1' then
                current_state <= IDLE;
                step_x        <= '0';
                step_y        <= '0';
                step_z        <= '0';
                step_hold     <= 0;

            else
                case current_state is

                    -- -------------------------------------------------------
                    when IDLE =>
                    -- -------------------------------------------------------
                        move_finished <= '0';
                        step_x        <= '0';
                        step_y        <= '0';
                        step_z        <= '0';

                        if instruction_ready = '1' then
                            if homing_reset = '1' then
                                current_x     <= (others => '0');
                                current_y     <= (others => '0');
                                current_z     <= (others => '0');
                                current_state <= FINISH;
                            else
                                current_state <= CALC_DELTA;
                            end if;
                        end if;

                    -- -------------------------------------------------------
                    when CALC_DELTA =>
                    -- -------------------------------------------------------
                        -- X axis
                        if unsigned(target_x) > current_x then
                            delta_x <= unsigned(target_x) - current_x;
                            dir_x   <= '1';
                        elsif unsigned(target_x) < current_x then
                            delta_x <= current_x - unsigned(target_x);
                            dir_x   <= '0';
                        else
                            delta_x <= (others => '0');
                        end if;

                        -- Y axis
                        if unsigned(target_y) > current_y then
                            delta_y <= unsigned(target_y) - current_y;
                            dir_y   <= '1';
                        elsif unsigned(target_y) < current_y then
                            delta_y <= current_y - unsigned(target_y);
                            dir_y   <= '0';
                        else
                            delta_y <= (others => '0');
                        end if;

                        -- Z axis
                        if unsigned(target_z) > current_z then
                            delta_z <= unsigned(target_z) - current_z;
                            dir_z   <= '1';
                        elsif unsigned(target_z) < current_z then
                            delta_z <= current_z - unsigned(target_z);
                            dir_z   <= '0';
                        else
                            delta_z <= (others => '0');
                        end if;

                        current_state <= CALC_MASTER;

                    -- -------------------------------------------------------
                    when CALC_MASTER =>
                    -- -------------------------------------------------------
                        -- Find longest axis (master)
                        if (delta_x >= delta_y) and (delta_x >= delta_z) then
                            master_steps <= delta_x;
                        elsif (delta_y >= delta_x) and (delta_y >= delta_z) then
                            master_steps <= delta_y;
                        else
                            master_steps <= delta_z;
                        end if;

                        -- Reset all counters
                        acc_x      <= (others => '0');
                        acc_y      <= (others => '0');
                        acc_z      <= (others => '0');
                        step_count <= (others => '0');
                        tick_count <= (others => '0');
                        prescaler  <= 0;
                        step_hold  <= 0;

                        -- Skip MOVE if no motion needed
                        if is_motion = '0' or
                           (unsigned(target_x) = current_x and
                            unsigned(target_y) = current_y and
                            unsigned(target_z) = current_z) then
                            current_state <= FINISH;
                        else
                            current_state <= MOVE;
                        end if;

                    -- -------------------------------------------------------
                    when MOVE =>
                    -- -------------------------------------------------------
                        if pause_flag = '0' then

                            ---------------------------------------------------
                            -- STEP PULSE TIMER
                            -- Runs at full 27MHz
                            -- 270 cycles = 10µs pulse width
                            ---------------------------------------------------
                            if step_hold = 0 then
                                step_x <= '0';
                                step_y <= '0';
                                step_z <= '0';
                            else
                                step_hold <= step_hold - 1;
                            end if;

                            ---------------------------------------------------
                            -- PRESCALER
                            -- 27MHz / 811 = 33,292 Hz
                            ---------------------------------------------------
                            if prescaler < PRESCALER_MAX then
                                prescaler <= prescaler + 1;
                            else
                                prescaler <= 0;

                                -----------------------------------------------
                                -- FEED RATE DELAY
                                -- Controls steps per second
                                --
                                -- For FULL STEP 200 RPM:
                                --   feed_rate = 0xFFCF
                                --   delay = 48 prescaler ticks
                                --   = 48 × 30µs = 1.44ms/step
                                --   = 694 steps/sec = 208 RPM
                                -----------------------------------------------
                                if tick_count < (x"FFFF" - unsigned(feed_rate)) then
                                    tick_count <= tick_count + 1;
                                else
                                    tick_count <= (others => '0');

                                    -------------------------------------------
                                    -- DDA ALGORITHM
                                    -- Bresenham line algorithm for
                                    -- coordinated multi-axis motion
                                    -------------------------------------------

                                    -- X Axis
                                    if (acc_x + delta_x) >= master_steps then
                                        acc_x        <= (acc_x + delta_x) - master_steps;
                                        step_x       <= '1';
                                        step_x_latch <= '1';
                                        step_x_total <= step_x_total + 1;
                                        step_hold    <= STEP_HOLD_MAX;
                                        if dir_x = '1' then
                                            current_x <= current_x + 1;
                                        else
                                            current_x <= current_x - 1;
                                        end if;
                                    else
                                        acc_x <= acc_x + delta_x;
                                    end if;

                                    -- Y Axis
                                    if (acc_y + delta_y) >= master_steps then
                                        acc_y <= (acc_y + delta_y) - master_steps;
                                        step_y <= '1';
                                        if step_hold < STEP_HOLD_MAX then
                                            step_hold <= STEP_HOLD_MAX;
                                        end if;
                                        if dir_y = '1' then
                                            current_y <= current_y + 1;
                                        else
                                            current_y <= current_y - 1;
                                        end if;
                                    else
                                        acc_y <= acc_y + delta_y;
                                    end if;

                                    -- Z Axis
                                    if (acc_z + delta_z) >= master_steps then
                                        acc_z <= (acc_z + delta_z) - master_steps;
                                        step_z <= '1';
                                        if step_hold < STEP_HOLD_MAX then
                                            step_hold <= STEP_HOLD_MAX;
                                        end if;
                                        if dir_z = '1' then
                                            current_z <= current_z + 1;
                                        else
                                            current_z <= current_z - 1;
                                        end if;
                                    else
                                        acc_z <= acc_z + delta_z;
                                    end if;

                                    -- Completion check
                                    if step_count < master_steps - 1 then
                                        step_count <= step_count + 1;
                                    else
                                        current_state <= FINISH;
                                    end if;

                                end if; -- tick_count
                            end if; -- prescaler
                        end if; -- pause_flag

                    -- -------------------------------------------------------
                    when FINISH =>
                    -- -------------------------------------------------------
                        move_finished <= '1';
                        current_state <= IDLE;

                end case;
            end if;
        end if;
    end process;

end architecture Behavioral;
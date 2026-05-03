-- PROFESSIONAL CNC Step Generator  — CIRCLE FIX
-- Base: Step_Generator_FIXED.vhd
-- Three changes only — everything else identical.
--
-- ROOT CAUSE of rectangular circles:
--   Circle segments are 5-15 steps long → execute in ~3ms → FIFO drains.
--   Without LATCH_TARGET, CALC_DELTA reads exec_target 1 cycle early
--   (Decoder hasn't latched new fifo_out yet) → delta_x=0, delta_y=0,
--   master_steps=0.  CALC_MASTER skip-check uses LIVE target port (which
--   the Decoder just updated) → sees target≠current → enters MOVE.
--   In MOVE with master_steps=0:
--     (acc+0)>=0 = always TRUE → steps fire every DDA tick
--     step_count < (0-1)=0xFFFFFFFF → runs 4 billion ticks
--   Machine steps forever in last dir_x/dir_y → straight sides → rectangle.
--
-- FIX 1: LATCH_TARGET state — freeze exec_target before planning.
-- FIX 2: CALC_MASTER uses delta values (not live ports) for skip decision.
-- FIX 3: Completion: step_count+1>=master_steps (no underflow).

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
        limit_x            : in  std_logic;
        limit_y            : in  std_logic;
        limit_z            : in  std_logic;
        move_finished      : out std_logic := '0';
        kill_acknowledged  : out std_logic := '0';
        step_x             : out std_logic := '0';
        step_y             : out std_logic := '0';
        step_z             : out std_logic := '0';
        dir_x              : buffer std_logic := '0';
        dir_y              : buffer std_logic := '0';
        dir_z              : buffer std_logic := '0'
    );
end entity Step_Generator;

architecture Behavioral of Step_Generator is

    type state_type is (IDLE, LATCH_TARGET, CALC_DELTA, CALC_MASTER, MOVE, FINISH);
    signal current_state : state_type := IDLE;

    signal current_x    : unsigned(31 downto 0) := (others => '0');
    signal current_y    : unsigned(31 downto 0) := (others => '0');
    signal current_z    : unsigned(31 downto 0) := (others => '0');
    signal delta_x      : unsigned(31 downto 0) := (others => '0');
    signal delta_y      : unsigned(31 downto 0) := (others => '0');
    signal delta_z      : unsigned(31 downto 0) := (others => '0');
    signal master_steps : unsigned(31 downto 0) := (others => '0');
    signal step_count   : unsigned(31 downto 0) := (others => '0');
    signal acc_x        : unsigned(31 downto 0) := (others => '0');
    signal acc_y        : unsigned(31 downto 0) := (others => '0');
    signal acc_z        : unsigned(31 downto 0) := (others => '0');
    signal tick_count   : unsigned(15 downto 0) := (others => '0');
    signal prescaler    : integer range 0 to 1023 := 0;
    signal step_hold    : integer range 0 to 270  := 0;

    signal latch_x      : unsigned(31 downto 0) := (others => '0');
    signal latch_y      : unsigned(31 downto 0) := (others => '0');
    signal latch_z      : unsigned(31 downto 0) := (others => '0');
    signal latch_motion : std_logic := '0';

    signal is_homing    : std_logic := '0';
    signal x_is_home    : std_logic := '0';
    signal y_is_home    : std_logic := '0';
    signal z_is_home    : std_logic := '0';
    signal pause_prev   : std_logic := '0';
    signal in_kill_mode : std_logic := '0';
    signal step_x_total : unsigned(31 downto 0) := (others => '0');

    attribute keep : boolean;
    attribute keep of is_homing    : signal is true;
    attribute keep of x_is_home    : signal is true;
    attribute keep of in_kill_mode : signal is true;

    constant PRESCALER_MAX : integer := 810;
    constant FEED_TICKS    : integer := 48;
    constant STEP_HOLD_MAX : integer := 270;

begin

    current_x_out <= std_logic_vector(current_x);
    current_y_out <= std_logic_vector(current_y);
    current_z_out <= std_logic_vector(current_z);

    process(clk)
    begin
        if rising_edge(clk) then

            if kill_flag = '1' then
                in_kill_mode      <= '1';
                kill_acknowledged <= '1';
                current_state     <= IDLE;
                is_homing         <= '0';
                step_x <= '0'; step_y <= '0'; step_z <= '0';
                step_hold    <= 0;
                delta_x      <= (others => '0');
                delta_y      <= (others => '0');
                delta_z      <= (others => '0');
                master_steps <= (others => '0');
                step_count   <= (others => '0');
                acc_x        <= (others => '0');
                acc_y        <= (others => '0');
                acc_z        <= (others => '0');
                prescaler    <= 0;
                tick_count   <= (others => '0');

            elsif in_kill_mode = '1' then
                if kill_flag = '0' then
                    in_kill_mode      <= '0';
                    kill_acknowledged <= '0';
                end if;

            else
                pause_prev <= pause_flag;
                if pause_flag = '1' and pause_prev = '0' then
                    prescaler <= 0; tick_count <= (others => '0');
                elsif pause_flag = '0' and pause_prev = '1' then
                    prescaler <= 0; tick_count <= (others => '0');
                end if;

                case current_state is

                    when IDLE =>
                        move_finished <= '0';
                        is_homing     <= '0';
                        step_x <= '0'; step_y <= '0'; step_z <= '0';

                        if instruction_ready = '1' then
                            if homing_reset = '1' then
                                is_homing  <= '1';
                                x_is_home  <= '0'; y_is_home <= '0'; z_is_home <= '0';
                                prescaler  <= 0;
                                tick_count <= (others => '0');
                                step_hold  <= 0;
                                current_state <= MOVE;
                            else
                                is_homing     <= '0';
                                current_state <= LATCH_TARGET;  -- FIX 1
                            end if;
                        end if;

                    when LATCH_TARGET =>                        -- FIX 1
                        latch_x       <= unsigned(target_x);
                        latch_y       <= unsigned(target_y);
                        latch_z       <= unsigned(target_z);
                        latch_motion  <= is_motion;
                        current_state <= CALC_DELTA;

                    when CALC_DELTA =>
                        if latch_x > current_x then
                            delta_x <= latch_x - current_x; dir_x <= '1';
                        elsif latch_x < current_x then
                            delta_x <= current_x - latch_x; dir_x <= '0';
                        else
                            delta_x <= (others => '0');      dir_x <= '1';
                        end if;

                        if latch_y > current_y then
                            delta_y <= latch_y - current_y; dir_y <= '1';
                        elsif latch_y < current_y then
                            delta_y <= current_y - latch_y; dir_y <= '0';
                        else
                            delta_y <= (others => '0');      dir_y <= '1';
                        end if;

                        if latch_z > current_z then
                            delta_z <= latch_z - current_z; dir_z <= '1';
                        elsif latch_z < current_z then
                            delta_z <= current_z - latch_z; dir_z <= '0';
                        else
                            delta_z <= (others => '0');      dir_z <= '1';
                        end if;

                        current_state <= CALC_MASTER;

                    when CALC_MASTER =>
                        if (delta_x >= delta_y) and (delta_x >= delta_z) then
                            master_steps <= delta_x;
                        elsif (delta_y >= delta_x) and (delta_y >= delta_z) then
                            master_steps <= delta_y;
                        else
                            master_steps <= delta_z;
                        end if;

                        acc_x <= (others => '0'); acc_y <= (others => '0');
                        acc_z <= (others => '0'); step_count <= (others => '0');
                        tick_count <= (others => '0'); prescaler <= 0; step_hold <= 0;

                        -- FIX 2: delta-based — always consistent, no live-port race
                        if latch_motion = '0' or
                           (delta_x = 0 and delta_y = 0 and delta_z = 0) then
                            current_state <= FINISH;
                        else
                            current_state <= MOVE;
                        end if;

                    when MOVE =>
                        if pause_flag = '1' then
                            step_x <= '0'; step_y <= '0'; step_z <= '0';
                            step_hold <= 0;
                        else
                            if step_hold = 0 then
                                step_x <= '0'; step_y <= '0'; step_z <= '0';
                            else
                                step_hold <= step_hold - 1;
                            end if;

                            if prescaler < PRESCALER_MAX then
                                prescaler <= prescaler + 1;
                            else
                                prescaler <= 0;
                                if tick_count < FEED_TICKS - 1 then
                                    tick_count <= tick_count + 1;
                                else
                                    tick_count <= (others => '0');

                                    if is_homing = '1' then
                                        if x_is_home = '0' then
                                            if limit_x = '1' then x_is_home <= '1'; current_x <= (others => '0');
                                            else dir_x <= '0'; step_x <= '1'; step_hold <= STEP_HOLD_MAX; end if;
                                        end if;
                                        if y_is_home = '0' then
                                            if limit_y = '1' then y_is_home <= '1'; current_y <= (others => '0');
                                            else dir_y <= '0'; step_y <= '1'; step_hold <= STEP_HOLD_MAX; end if;
                                        end if;
                                        if z_is_home = '0' then
                                            if limit_z = '1' then z_is_home <= '1'; current_z <= (others => '0');
                                            else dir_z <= '0'; step_z <= '1'; step_hold <= STEP_HOLD_MAX; end if;
                                        end if;
                                        if x_is_home = '1' and y_is_home = '1' and z_is_home = '1' then
                                            current_state <= FINISH;
                                        end if;

                                    else
                                        if (acc_x + delta_x) >= master_steps then
                                            acc_x <= (acc_x + delta_x) - master_steps;
                                            step_x <= '1'; step_x_total <= step_x_total + 1;
                                            step_hold <= STEP_HOLD_MAX;
                                            if dir_x = '1' then current_x <= current_x + 1;
                                            else                 current_x <= current_x - 1; end if;
                                        else
                                            acc_x <= acc_x + delta_x;
                                        end if;

                                        if (acc_y + delta_y) >= master_steps then
                                            acc_y <= (acc_y + delta_y) - master_steps;
                                            step_y    <= '1';
                                            step_hold <= STEP_HOLD_MAX;  -- was conditional, now same as X
                                            if dir_y = '1' then current_y <= current_y + 1;
                                            else                 current_y <= current_y - 1; end if;
                                        else
                                            acc_y <= acc_y + delta_y;
                                        end if;

                                        if (acc_z + delta_z) >= master_steps then
                                            acc_z <= (acc_z + delta_z) - master_steps;
                                            step_z    <= '1';
                                            step_hold <= STEP_HOLD_MAX;  -- was conditional, now same as X
                                            if dir_z = '1' then current_z <= current_z + 1;
                                            else                 current_z <= current_z - 1; end if;
                                        else
                                            acc_z <= acc_z + delta_z;
                                        end if;

                                        -- FIX 3: no underflow for master_steps=0 or 1
                                        if step_count + 1 >= master_steps then
                                            current_state <= FINISH;
                                        else
                                            step_count <= step_count + 1;
                                        end if;

                                    end if;
                                end if;
                            end if;
                        end if;

                    when FINISH =>
                        move_finished <= '1';
                        is_homing     <= '0';
                        current_state <= IDLE;

                end case;
            end if;
        end if;
    end process;

end architecture Behavioral;
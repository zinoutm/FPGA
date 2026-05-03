-- =============================================================================
-- Spindle_PWM.vhd
-- =============================================================================
-- Generates a PWM signal for spindle / laser speed control.
--
-- FREQUENCY:
--   PWM_PERIOD = 27000 → 27 000 000 / 27 000 = 1 kHz
--   Compatible with most ESC and laser-driver PWM inputs.
--   Change PWM_PERIOD to adjust frequency (e.g. 270 = 100 kHz for laser TTL).
--
-- SPEED MAPPING:
--   speed = 0x0000 →   0 % duty cycle (spindle fully off)
--   speed = 0xFFFF → 100 % duty cycle (spindle full power)
--   Linear mapping: threshold = (speed * PWM_PERIOD) / 65535
--
-- SAFETY:
--   - If enable = '0'  → PWM output immediately forced LOW.
--   - If kill   = '1'  → PWM output immediately forced LOW (hard stop).
--   Both override everything else combinatorially via the output mux.
--
-- LATENCY:
--   threshold register updates 1 cycle after speed changes — negligible.
--   pwm_out reflects new threshold on the very next counter wrap.
-- =============================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Spindle_PWM is
    port (
        clk      : in  std_logic;
        enable   : in  std_logic;                       -- spindle_on from decoder
        kill     : in  std_logic;                       -- kill_flag  from decoder
        speed    : in  std_logic_vector(15 downto 0);  -- 0x0000–0xFFFF → 0–100 %
        pwm_out  : out std_logic := '0'
    );
end entity Spindle_PWM;

architecture Behavioral of Spindle_PWM is

    -- -------------------------------------------------------------------------
    -- PWM timing constant
    -- -------------------------------------------------------------------------
    constant PWM_PERIOD : integer := 27000;  -- 1 kHz at 27 MHz clock

    -- -------------------------------------------------------------------------
    -- Internal signals
    -- -------------------------------------------------------------------------
    signal pwm_counter : integer range 0 to PWM_PERIOD - 1 := 0;
    signal threshold   : integer range 0 to PWM_PERIOD     := 0;
    signal pwm_raw     : std_logic := '0';

begin

    -- =========================================================================
    -- PWM process: counter + threshold comparison
    -- =========================================================================
    process(clk)
        variable speed_int : integer range 0 to 65535;
    begin
        if rising_edge(clk) then

            -- ------------------------------------------------------------------
            -- Threshold register
            -- Compute once per clock; synthesiser resolves constant /65535 as a
            -- multiply-by-reciprocal shift chain (no divider inferred).
            -- ------------------------------------------------------------------
            speed_int := to_integer(unsigned(speed));
            threshold <= (speed_int * PWM_PERIOD) / 65536;

            -- ------------------------------------------------------------------
            -- Counter
            -- ------------------------------------------------------------------
            if pwm_counter < PWM_PERIOD - 1 then
                pwm_counter <= pwm_counter + 1;
            else
                pwm_counter <= 0;
            end if;

            -- ------------------------------------------------------------------
            -- Comparator → raw PWM
            -- ------------------------------------------------------------------
            if pwm_counter < threshold then
                pwm_raw <= '1';
            else
                pwm_raw <= '0';
            end if;

        end if;
    end process;

    -- =========================================================================
    -- Safety output mux (combinatorial — zero latency kill/enable)
    -- =========================================================================
    pwm_out <= pwm_raw when (enable = '1' and kill = '0') else '0';

end architecture Behavioral;

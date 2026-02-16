library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPI_Interface is
    port (
        sclk         : in  std_logic;
        mosi         : in  std_logic;
        miso         : out std_logic;
        cs_n         : in  std_logic;
        current_x    : in  std_logic_vector(31 downto 0);
        current_y    : in  std_logic_vector(31 downto 0);
        current_z    : in  std_logic_vector(31 downto 0);
        packet_out   : out std_logic_vector(143 downto 0);
        packet_valid : out std_logic := '0'
    );
end entity SPI_Interface;

architecture Behavioral of SPI_Interface is
    signal bit_count        : integer range 0 to 143 := 0;
    signal shift_rx         : std_logic_vector(143 downto 0) := (others => '0');
    signal shift_tx         : std_logic_vector(143 downto 0) := (others => '0');
    signal miso_reg         : std_logic := '0';
    signal valid_hold       : integer range 0 to 7 := 0;
    signal packet_done_flag : std_logic := '0';
begin

    miso <= miso_reg when cs_n = '0' else 'Z';

    process(sclk, cs_n)
    begin
        if cs_n = '1' then
            bit_count        <= 0;
            packet_valid     <= '0';
            valid_hold       <= 0;
            packet_done_flag <= '0';
            miso_reg         <= current_x(31); -- Pre-load MSB before transaction

        elsif rising_edge(sclk) then

            -- 1. RECEIVE (always)
            shift_rx <= shift_rx(142 downto 0) & mosi;

            -- 2. TRANSMIT
            if bit_count = 0 then
                -- x(31) already on wire from pre-load
                -- x(30) goes on wire now for edge 1
                -- shift_tx holds x(29:0) & y & z & padding for edges 2-143
                miso_reg <= current_x(30);
                shift_tx <= current_x(29 downto 0) &  -- 30 bits
                            current_y              &   -- 32 bits
                            current_z              &   -- 32 bits
                            x"000000000000"        &   -- 48 bits
                            "00";                      -- 2  bits
                                                       -- total = 144 bits ✅
            else
                miso_reg <= shift_tx(143);
                shift_tx <= shift_tx(142 downto 0) & '0';
            end if;

            -- 3. PACKET STATE MACHINE
            if packet_done_flag = '1' then
                if valid_hold > 0 then
                    valid_hold   <= valid_hold - 1;
                    packet_valid <= '1';
                else
                    packet_valid <= '0';
                end if;

            elsif bit_count = 143 then
                packet_out       <= shift_rx(142 downto 0) & mosi;
                packet_valid     <= '1';
                valid_hold       <= 7;
                packet_done_flag <= '1';

            else
                packet_valid <= '0';
                bit_count    <= bit_count + 1;
            end if;

        end if;
    end process;
end architecture Behavioral;
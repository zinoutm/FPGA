library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Opcode_Decoder is
    port (
        clk                 : in  std_logic; -- 27MHz --

        raw_opcode          : in  std_logic_vector (7 downto 0);
        raw_target_x        : in  std_logic_vector (31 downto 0);
        raw_target_y        : in  std_logic_vector (31 downto 0);
        raw_target_z        : in  std_logic_vector (31 downto 0);
        raw_feed            : in  std_logic_vector (15 downto 0);

        current_x           : in  std_logic_vector (31 downto 0);
        current_y           : in  std_logic_vector (31 downto 0);
        current_z           : in  std_logic_vector (31 downto 0);

        exec_target_x       : out std_logic_vector (31 downto 0);
        exec_target_y       : out std_logic_vector (31 downto 0);
        exec_target_z       : out std_logic_vector (31 downto 0);
        exec_feed           : out std_logic_vector (15 downto 0);

        data_available      : in  std_logic; -- indicates that the current instruction data is valid and can be executed --
        pause_flag          : out std_logic := '0'; -- wait a second signal , stopes the tick_counter and holds the motors in place --
        progress_stop       : out std_logic := '0'; -- job done or clean up signal , turn off spindle and reset all counters --
        is_motion           : out std_logic := '0'; -- is this a move , detects if the instruction has a move command (G0/G1) --
        kill_flag           : out std_logic := '0'; -- the panic signal , turns off everything and stops the machine immediately -- 
        spindle_on          : out std_logic := '0'; -- the spindle control signal , turns on the spindle when '1' and off when '0' --
        instruction_ready   : out std_logic := '0';  -- Valid data is present    
        homing_reset        : out std_logic := '0' -- Signal to trigger homing reset sequence --
    );
end entity Opcode_Decoder; 

architecture Behavioral of Opcode_Decoder is
begin

    process(clk)
    begin
        if rising_edge(clk) then
        
            -- 1. DATA VALIDATION & INSTRUCTION READY
            -- Added: or if the opcode is x"30" (Homing)
            if data_available = '1' and raw_opcode /= x"18" then
                instruction_ready <= '1';
            else
                instruction_ready <= '0';
            end if;

            -- 2. EMERGENCY STOP (0x18)
            if raw_opcode = x"18" then 
                kill_flag  <= '1';
                spindle_on <= '0';
                homing_reset <= '0';
            else
                kill_flag <= '0';

                ---------------------------------------------------------------
                -- NEW: HOMING / SET ZERO DETECTION (0x30)
                ---------------------------------------------------------------
                if raw_opcode = x"30" then
                    homing_reset <= '1';
                else
                    homing_reset <= '0';
                end if;

                -- 3. PAUSE / RESUME LOGIC (0x24/0x44 and 0x28/0x48)
                if raw_opcode = x"24" or raw_opcode = x"44" then
                    pause_flag <= '1';
                elsif raw_opcode = x"28" or raw_opcode = x"48" then
                    pause_flag <= '0';
                end if;

                -- 4. MOTION DETECTION (G0/G1)
                -- Added x"30" exclusion: Homing is not a physical DDA move
                if (raw_opcode(0) = '1' or raw_opcode(1) = '1') and raw_opcode /= x"30" then
                    is_motion <= '1';
                else
                    is_motion <= '0';
                end if;

                -- 5. SPINDLE CONTROL (Bit 2: M3 / Bit 3: M5)
                if raw_opcode(2) = '1' then
                    spindle_on <= '1';
                elsif raw_opcode(3) = '1' then
                    spindle_on <= '0';
                end if;

                -- 6. PROGRAM STOP (Bit 4: M2/M30)
                if raw_opcode(4) = '1' then 
                    progress_stop <= '1';
                    spindle_on    <= '0'; 
                else 
                    progress_stop <= '0';
                end if;
            end if;

            -- 7. AXIS ROUTING (Bits 5, 6, 7)
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

            -- 8. FEEDRATE SELECTION
            if raw_opcode(1) = '1' then
                exec_feed <= x"FFF0"; -- Rapid move
            elsif raw_opcode(0) = '1' then
                exec_feed <= raw_feed; -- Linear move
            else
                exec_feed <= x"0000"; 
            end if;
            
        end if;
    end process;

end architecture Behavioral;
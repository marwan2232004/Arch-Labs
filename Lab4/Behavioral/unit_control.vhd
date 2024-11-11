LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY unit_control IS
    GENERIC (
        floor_num : INTEGER := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        current_floor : IN INTEGER;
        next_floor : IN INTEGER;
        dir : IN INTEGER;
        new_state : OUT INTEGER;
        new_current_floor : OUT INTEGER;
        new_dir : OUT INTEGER
    );
END ENTITY;

ARCHITECTURE behavioral OF unit_control IS
    SIGNAL stop_counter : INTEGER := 1;
    SIGNAL moving_counter : INTEGER := -1;
    SIGNAL stop_array : STD_LOGIC_VECTOR(0 TO floor_num - 1) := (OTHERS => '0');
BEGIN
    PROCESS (clk, rst)
        VARIABLE new_current_floor_temp : INTEGER := 0;
        VARIABLE new_state_temp : INTEGER := 0;
    BEGIN
        IF rst = '1' THEN
            new_current_floor <= 0;
            new_state <= 0;
        ELSIF rising_edge(clk) THEN

            IF current_floor > next_floor THEN
                stop_array(current_floor) <= '0';
                new_current_floor_temp := current_floor - 1;
                new_state_temp := 1;
            ELSIF current_floor < next_floor THEN
                stop_array(current_floor) <= '0';
                new_current_floor_temp := current_floor + 1;
                new_state_temp := 2;
            ELSE
                new_current_floor_temp := current_floor;
                new_state_temp := 0;
            END IF;

            IF stop_counter < 1 THEN
                new_current_floor <= current_floor;
                new_state <= 0;
                new_dir <= dir;
                moving_counter <= - 1;
                stop_counter <= 1;
            ELSIF current_floor /= next_floor THEN
                IF moving_counter < 1 THEN
                    new_state <= new_state_temp;
                    new_dir <= new_state_temp;
                    new_current_floor <= current_floor;
                    moving_counter <= moving_counter + 1;
                ELSE

                    moving_counter <= 0;
                    new_current_floor <= new_current_floor_temp;
                    -- Trigger the stop counter when the elevator reaches the requested floor
                    IF new_current_floor_temp = next_floor THEN
                        new_dir <= dir; -- keep the direction
                        new_state <= 0; -- stopped
                        IF dir > 0 AND stop_array(new_current_floor_temp) = '0' THEN
                            stop_counter <= 0;
                            stop_array(new_current_floor_temp) <= '1';
                        END IF;
                    END IF;

                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
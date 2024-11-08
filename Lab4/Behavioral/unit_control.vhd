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
    BEGIN
        IF rst = '1' THEN
            new_current_floor <= 0;
            new_state <= 0;
        ELSIF rising_edge(clk) THEN
            IF stop_array(current_floor) = '1' AND current_floor = next_floor THEN
                stop_counter <= 1;
                moving_counter <= - 1;
            ELSIF stop_counter < 1 THEN
                new_current_floor <= current_floor;
                new_state <= 0;
                new_dir <= dir;
                moving_counter <= - 1;
                stop_counter <= 1;
            ELSIF moving_counter < 1 THEN
                new_current_floor <= current_floor;
                new_state <= dir;
                new_dir <= dir;
                moving_counter <= moving_counter + 1;
            ELSE
                moving_counter <= 0;
                stop_array(current_floor) <= '0';
                IF current_floor > next_floor THEN
                    new_current_floor_temp := current_floor - 1;
                    new_state <= 1;
                    new_dir <= 1;
                ELSIF current_floor < next_floor THEN
                    new_current_floor_temp := current_floor + 1;
                    new_state <= 2;
                    new_dir <= 2;
                END IF;

                new_current_floor <= new_current_floor_temp;

                IF new_current_floor_temp = next_floor THEN
                    new_dir <= dir;
                    new_state <= 0;
                    IF dir > 0 AND stop_array(current_floor) = '0' THEN
                        stop_counter <= 0;
                        stop_array(current_floor) <= '1';
                    END IF;
                END IF;

            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
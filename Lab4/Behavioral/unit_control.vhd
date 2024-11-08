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
    SIGNAL stop_counter : INTEGER := 2;
    SIGNAL moving_counter : INTEGER := 1;
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            new_current_floor <= 0;
            new_state <= 0;
        ELSIF rising_edge(clk) THEN
            IF current_floor = next_floor THEN
                new_dir <= dir;
                new_state <= 0;
                stop_counter <= 0;
            ELSIF moving_counter < 1 THEN
                new_current_floor <= current_floor;
                new_state <= dir;
                new_dir <= dir;
                moving_counter <= 1;
            ELSIF stop_counter < 2 THEN
                new_current_floor <= current_floor;
                new_state <= 0;
                new_dir <= dir;
                stop_counter <= stop_counter + 1;
            ELSE
                moving_counter <= 0;
                IF current_floor > next_floor THEN
                    new_current_floor <= current_floor - 1;
                    new_state <= 1;
                    new_dir <= 1;
                ELSE
                    new_current_floor <= current_floor + 1;
                    new_state <= 2;
                    new_dir <= 2;
                END IF;
            END IF;

        END IF;
    END PROCESS;
END ARCHITECTURE;
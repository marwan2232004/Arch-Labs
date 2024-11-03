LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY request_resolver IS
    GENERIC (
        floor_num : INTEGER := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        requests : IN STD_LOGIC_VECTOR(floor_num - 1 DOWNTO 0);
        request : OUT INTEGER;
        current_floor : IN INTEGER;
        prev_dir : IN INTEGER;
        state : IN INTEGER
    );
END ENTITY;

ARCHITECTURE behavioral OF request_resolver IS
    SIGNAL stop_counter : INTEGER := 0;
BEGIN
    PROCESS (clk, rst)
        VARIABLE request_set : INTEGER := 0;
    BEGIN
        IF rst = '1' THEN
            request <= 0;
        ELSIF rising_edge(clk) THEN
            IF prev_dir = 0 THEN
                FOR i IN current_floor TO floor_num - 1 LOOP
                    IF requests(i) = '1' THEN
                        request <= i;
                        stop_counter <= 0;
                        request_set := 1;
                        break;
                    END IF;
                END LOOP;
            ELSE
                IF state = 0 AND stop_counter < 2 THEN
                    request <= current_floor;
                    stop_counter <= stop_counter + 1;
                ELSIF prev_dir = 1 THEN
                    FOR i IN current_floor DOWNTO 0 LOOP
                        IF requests(i) = '1' THEN
                            request <= i;
                            stop_counter <= 0;
                            request_set := 1;
                            break;
                        END IF;
                    END LOOP;
                    FOR i IN current_floor TO floor_num - 1 LOOP
                        IF requests(i) = '1' AND request_set = 0 THEN
                            request <= i;
                            stop_counter <= 0;
                            break;
                        END IF;
                    END LOOP;
                ELSE
                    FOR i IN current_floor TO floor_num - 1 LOOP
                        IF requests(i) = '1' THEN
                            request <= i;
                            stop_counter <= 0;
                            request_set := 1;
                            break;
                        END IF;
                    END LOOP;
                    FOR i IN current_floor DOWNTO 0 LOOP
                        IF requests(i) = '1' AND request_set = 0 THEN
                            request <= i;
                            stop_counter <= 0;
                            break;
                        END IF;
                    END LOOP;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
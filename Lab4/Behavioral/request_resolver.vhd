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
        requests : IN STD_LOGIC_VECTOR(0 TO floor_num - 1);
        current_floor : IN INTEGER;
        prev_request : IN INTEGER;
        prev_dir : IN INTEGER;
        state : IN INTEGER;
        request : OUT INTEGER
    );
END ENTITY;

-- prev_dir = 0: first time, 1: down, 2: up

ARCHITECTURE behavioral OF request_resolver IS
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
                        request_set := 1;
                    END IF;
                    EXIT WHEN request_set = 1;
                END LOOP;
            ELSE
                request_set := 0;
                IF state = 0 AND requests(prev_request) = '1' THEN
                    request <= prev_request;
                ELSIF current_floor = prev_request THEN
                    IF prev_dir = 1 THEN
                        FOR i IN current_floor DOWNTO 0 LOOP
                            IF requests(i) = '1' THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END LOOP;
                        FOR i IN current_floor TO floor_num - 1 LOOP
                            IF requests(i) = '1' AND request_set = 0 THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END LOOP;
                    ELSE
                        FOR i IN current_floor TO floor_num - 1 LOOP
                            IF requests(i) = '1' THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END LOOP;
                        FOR i IN current_floor DOWNTO 0 LOOP
                            IF requests(i) = '1' AND request_set = 0 THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END LOOP;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
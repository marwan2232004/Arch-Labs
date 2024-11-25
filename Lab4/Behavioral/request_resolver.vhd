LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY request_resolver IS
    GENERIC (
        floor_num : INTEGER := 10
    );
    PORT (
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
    PROCESS (requests, rst)
        VARIABLE request_set : INTEGER := 0;
    BEGIN
        IF rst = '1' THEN
            request <= 0;
        ELSE
            IF prev_dir = 0 THEN
                FOR i IN 0 TO floor_num - 1 LOOP
                    IF i >= current_floor THEN
                        IF requests(i) = '1' THEN
                            request <= i;
                            request_set := 1;
                        END IF;
                        EXIT WHEN request_set = 1;
                    END IF;
                END LOOP;
            ELSE
                -- current_floor + 1 becuase the elevator is already moving from the current floor
                request_set := 0;
                IF state = 0 AND requests(prev_request) = '1' THEN
                    request <= prev_request;
                ELSIF prev_dir = 1 THEN

                    FOR i IN floor_num - 1 DOWNTO 0 LOOP
                        IF i <= current_floor + 1 THEN
                            IF requests(i) = '1' THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END IF;
                    END LOOP;

                    FOR i IN 0 TO floor_num - 1 LOOP
                        IF i >= current_floor + 1 THEN
                            IF requests(i) = '1' AND request_set = 0 THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END IF;
                    END LOOP;

                ELSE
                    FOR i IN 0 TO floor_num - 1 LOOP
                        IF i >= current_floor + 1 THEN
                            IF requests(i) = '1' THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END IF;
                    END LOOP;

                    FOR i IN floor_num - 1 DOWNTO 0 LOOP
                        IF i <= current_floor + 1 THEN
                            IF requests(i) = '1' AND request_set = 0 THEN
                                request <= i;
                                request_set := 1;
                            END IF;
                            EXIT WHEN request_set = 1;
                        END IF;
                    END LOOP;

                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
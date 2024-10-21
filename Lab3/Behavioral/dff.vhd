LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY dff IS
    GENERIC (n : INTEGER := 8);
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));

END ENTITY;

ARCHITECTURE behavioral_dff OF dff
    IS
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            q <= (OTHERS => '0');
        ELSIF rising_edge(clk)THEN
            q <= d;
        END IF;
    END PROCESS;
END ARCHITECTURE;
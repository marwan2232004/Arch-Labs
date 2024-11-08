LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY clk_divider IS
    PORT (
        clk_in : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC
    );
END clk_divider;

ARCHITECTURE Behavioral OF clk_divider IS
    SIGNAL counter : INTEGER := 0;
    SIGNAL clk_reg : STD_LOGIC := '0';
    CONSTANT CLKFREQ : INTEGER := 50000000;
    CONSTANT DIVISOR : INTEGER := CLKFREQ / 2;

BEGIN
    PROCESS (clk_in, reset)
    BEGIN
        IF reset = '1' THEN
            counter <= 0;
            clk_reg <= '0';
        ELSIF rising_edge(clk_in) THEN
            IF counter = DIVISOR - 1 THEN
                counter <= 0;
                clk_reg <= NOT clk_reg;
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;

    clk_out <= clk_reg;
END Behavioral;
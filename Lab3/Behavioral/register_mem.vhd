LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ARCHITECTURE behavioral_register_mem OF registers
    IS
    TYPE reg_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL registers : reg_array := (OTHERS => (OTHERS => '0'));
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            registers <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk) THEN
            IF we = '1' THEN
                registers(to_integer(unsigned(write_addr))) <= write_data;
            END IF;
        END IF;
    END PROCESS;
    read_data1 <= registers(to_integer(unsigned(read_addr1)));
    read_data2 <= registers(to_integer(unsigned(read_addr2)));
END ARCHITECTURE;
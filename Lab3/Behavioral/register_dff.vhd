LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ARCHITECTURE behavioral_register_dff OF registers
    IS
    TYPE reg_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL registers : reg_array := (OTHERS => (OTHERS => '0'));
    SIGNAL reg_en : STD_LOGIC_VECTOR(0 TO 7) := (OTHERS => '0');
BEGIN
    PROCESS (clk, rst)
    BEGIN            
        reg_en <= (OTHERS => '0');
        reg_en(to_integer(unsigned(write_addr))) <= we;
    END PROCESS;

    gen_dffs : FOR i IN 0 TO 7 GENERATE
        iDff : ENTITY work.dff(rtl)
            GENERIC MAP(n => 8)
            PORT MAP(
                clk => clk,
                rst => rst,
                we => reg_en(i),
                d => write_data,
                q => registers(i)
            );
    END GENERATE;
    read_data1 <= registers(to_integer(unsigned(read_addr1)));
    read_data2 <= registers(to_integer(unsigned(read_addr2)));
END ARCHITECTURE;
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ARCHITECTURE behavioral_register_dff OF registers
    IS
    SIGNAL we_int : INTEGER;
    SIGNAL re1_int : INTEGER;
    SIGNAL re2_int : INTEGER;
BEGIN
    we_int <= to_integer(unsigned(write_addr));
    re1_int <= to_integer(unsigned(read_addr1));
    re2_int <= to_integer(unsigned(read_addr2));
    
    gen_dffs : FOR i IN 0 TO 7 GENERATE
        iDff : ENTITY work.dff_wrapper(behavioral)
            GENERIC MAP(n => 8)
            PORT MAP(
                idx => i,
                we => we_int,
                re1 => re1_int,
                re2 => re2_int,
                clk => clk,
                rst => rst,
                d => write_data,
                q1 => read_data1,
                q2 => read_data2
            );
    END GENERATE;
END ARCHITECTURE;
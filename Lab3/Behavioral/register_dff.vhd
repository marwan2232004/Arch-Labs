LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ARCHITECTURE behavioral_register_dff OF registers
    IS
BEGIN
    PROCESS (clk, rst)
    BEGIN
        FOR i IN 0 TO 7 GENERATE

            iDff : ENTITY work.dff_wrapper(behavioral)
                GENERIC MAP(n => 8)
                PORT MAP(
                    idx => i,
                    we => to_integer(unsigned(write_addr)),
                    re1 => to_integer(unsigned(read_addr1)),
                    re2 => to_integer(unsigned(read_addr2)),
                    clk => clk,
                    rst => rst,
                    d => write_data,
                    q1 => read_data1,
                    q2 => read_data2
                );

        END GENERATE;
    END PROCESS;
END ARCHITECTURE;
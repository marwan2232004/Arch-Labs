library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clk_divider is
    Port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           );
end clk_divider;

architecture Behavioral of clk_divider is
    
begin
    process(clk_in, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clk_reg <= '0';
        elsif rising_edge(clk_in) then
            if counter = DIVISOR - 1 then
                counter <= 0;
                clk_reg <= not clk_reg;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= clk_reg;
end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clk_divider is
end tb_clk_divider;

architecture Behavioral of tb_clk_divider is
    signal clk_in : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal clk_out : STD_LOGIC;

    component clk_divider
        Port ( clk_in : in STD_LOGIC;
               reset : in STD_LOGIC;
               clk_out : out STD_LOGIC);
    end component;

begin
    uut: clk_divider
        Port map (
            clk_in => clk_in,
            reset => reset,
            clk_out => clk_out
        );

    clk_process : process
    begin
        clk_in <= '0';
        wait for 10 ns;
        clk_in <= '1';
        wait for 10 ns;
    end process;

    reset_process : process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        wait for 2 sec; 
        wait;
    end process;

end Behavioral;

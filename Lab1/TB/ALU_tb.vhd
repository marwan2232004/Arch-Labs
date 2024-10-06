library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end entity;

architecture sim_alu of ALU_tb is

	signal A : std_logic_vector(7 downto 0) := x"F0";
	signal B : std_logic_vector(7 downto 0) := x"B0";
	signal sel : std_logic_vector(3 downto 0) := "0100";
	signal cin : std_logic := '0'; 
	
	signal output : std_logic_vector(7 downto 0) := (others => 'U');
	signal cout : std_logic := 'U'; 
	
begin
	
	ialu : entity work.Part(behavioral_alu)
	generic map(
        selection_size => 4
    ) 
	port map(
		A,
		B,
		sel,
		cin,
		output,
		cout
	);	
	
process is
begin

	A <= X"F0";
	B <= X"B0";
	cin <= '0';
	sel <= "0100";
	wait for 20 ns;

	B <= X"0B";
	sel <= "0101";
	wait for 20 ns;

	B <= X"B0";
	sel <= "0110";
	wait for 20 ns;

	sel <= "0111";
	wait for 20 ns;

	sel <= "1000";
	wait for 20 ns;

	sel <= "1001";
	wait for 20 ns;

    cin <= '0';
	sel <= "1010";
	wait for 20 ns;

	sel <= "1011";
	wait for 20 ns;

	sel <= "1100";
	wait for 20 ns;

	sel <= "1101";
	wait for 20 ns;

    cin <= '0';
	sel <= "1110";
	wait for 20 ns;

	sel <= "1111";
	wait for 20 ns;

    cin <= '1';
	sel <= "1010";
	wait for 20 ns;

    cin <= '1';
	sel <= "1110";
	wait;
		
end process;


end architecture;
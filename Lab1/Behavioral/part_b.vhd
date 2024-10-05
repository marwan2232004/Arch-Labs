library ieee;
use ieee.std_logic_1164.all;

architecture behavioral_b of Part is
	signal A_xor_B : std_logic_vector(7 downto 0);
	signal A_nand_B : std_logic_vector(7 downto 0);
	signal A_or_B : std_logic_vector(7 downto 0);
	signal not_A : std_logic_vector(7 downto 0);
begin

	A_xor_B <= A XOR B;
	A_nand_B <= A NAND B;
	A_or_B <= A OR B;
	not_A <= NOT A;
	cout <= "0";
	
	iMux2 : entity work.Mux2(rtl) 
	generic map(
        size => 8
    )
	port map(
		A_xor_B,
		A_nand_B,
		A_or_B,
		not_A,
		sel,
		output
	);	


end architecture;
library ieee;
use ieee.std_logic_1164.all;

architecture rtl_c of Part is
	signal left_shift : std_logic_vector(7 downto 0);
	signal left_rotate : std_logic_vector(7 downto 0);
	signal left_rotate_carry : std_logic_vector(7 downto 0);
begin

	left_shift <= A(6 downto 0) & '0';
	left_rotate <= A(6 downto 0) & A(7);
	left_rotate_carry <= A(6 downto 0) & cin;
	cout <= '0' when sel = "11" else A(7);
	
	iMux2 : entity work.Mux2(rtl) port map(
		left_shift,
		left_rotate,
		left_rotate_carry,
		x"00",
		sel,
		output
	);	


end architecture;
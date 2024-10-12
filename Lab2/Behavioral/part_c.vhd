library ieee;
use ieee.std_logic_1164.all;

architecture behavioral_c of Part is
	-- * Signals for saving the result of each operation and pass it to the mux.
	signal left_shift : std_logic_vector(7 downto 0);
	signal left_rotate : std_logic_vector(7 downto 0);
	signal left_rotate_carry : std_logic_vector(7 downto 0);
begin

	left_shift <= A(6 downto 0) & '0'; -- ? carry A(7)
	left_rotate <= A(6 downto 0) & A(7); -- ? carry A(7)
	left_rotate_carry <= A(6 downto 0) & cin; -- ? carry A(7)
	cout <= '0' when sel = "11" else A(7);
	
	-- * Instantiate the mux.
	iMux2 : entity work.Mux2(rtl) 
	generic map(
        size => 8
    )
	port map(
		left_shift,
		left_rotate,
		left_rotate_carry,
		x"00",
		sel,
		output
	);	


end architecture;
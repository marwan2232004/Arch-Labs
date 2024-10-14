library ieee;
use ieee.std_logic_1164.all;

architecture behavioral_c of part is
	-- * Signals for saving the result of each operation and pass it to the mux.
	signal left_shift : std_logic_vector(input_size - 1 downto 0);
	signal left_rotate : std_logic_vector(input_size - 1 downto 0);
	signal left_rotate_carry : std_logic_vector(input_size - 1 downto 0);
begin

	left_shift <= A(input_size - 2 downto 0) & '0'; -- ? carry A(7)
	left_rotate <= A(input_size - 2 downto 0) & A(input_size - 1); -- ? carry A(7)
	left_rotate_carry <= A(input_size - 2 downto 0) & cin; -- ? carry A(7)
	cout <= '0' when sel = "11" else A(input_size - 1);
	
	-- * Instantiate the mux.
	iMux2 : entity work.Mux2(rtl) 
	generic map(
        size => input_size 
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
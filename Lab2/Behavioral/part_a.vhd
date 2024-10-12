library ieee;
use ieee.std_logic_1164.all;

architecture behavioral_a of Part is
	-- * Signals for saving the result of each operation and pass it to the mux.
	signal sel_xnor : std_logic;
	signal modified_B : std_logic_vector(7 downto 0); 
	signal all_equal : std_logic;
	signal all_positive : std_logic;
	signal temp_output : std_logic_vector(7 downto 0);
	signal temp_cout : std_logic;
begin
	-- * Perform the operations.

	sel_xnor <= sel(0) XNOR sel(1);
	all_equal <= '1' when (sel(0) = cin and sel(1) = cin) else '0';
	all_positive <= cin and all_equal;
	modified_B <= (others => '0') when sel_xnor = '1' else B;

	-- * Instantiate the full adder.
	ifullAdder : entity work.nBitFullAdder(behavioral) 
	generic map(
        size => 8
    )
	port map(
		A,
		modified_B,
		cin,
		sel(1),
		temp_output,
		temp_cout
	);	

	cout <= '0' when all_equal = '1' else temp_cout;
	output <= B when all_positive = '1' else temp_output;

end architecture;
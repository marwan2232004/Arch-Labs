library ieee;
use ieee.std_logic_1164.all;

architecture behavioral_b of part is
	-- * Signals for saving the result of each operation and pass it to the mux.
	signal A_xor_B : std_logic_vector(input_size - 1 downto 0); --* A XOR B
	signal A_nand_B : std_logic_vector(input_size - 1 downto 0); --* A NAND B
	signal A_or_B : std_logic_vector(input_size - 1 downto 0); --* A OR B
	signal not_A : std_logic_vector(input_size - 1 downto 0); --* NOT A
begin
	-- * Perform the operations.
	A_xor_B <= A XOR B;
	A_nand_B <= A NAND B;
	A_or_B <= A OR B;
	not_A <= NOT A;
	cout <= '0';
	
	-- * Instantiate the mux.
	iMux2 : entity work.Mux2(rtl) 
	generic map(
        size => input_size
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
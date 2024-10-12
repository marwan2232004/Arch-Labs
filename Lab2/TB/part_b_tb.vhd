library ieee;
use ieee.std_logic_1164.all;

entity part_b_tb is
end entity;

architecture sim_b of part_b_tb is

	-- * Signals for testing Part_B with initial values.
	signal A : std_logic_vector(7 downto 0) := x"F0"; -- * First input.
	signal B : std_logic_vector(7 downto 0) := x"B0"; -- * Second input.
	signal sel : std_logic_vector(1 downto 0) := "00"; -- * Selection bits.
	signal cin : std_logic := '0'; -- * Carry in.
	
	signal output : std_logic_vector(7 downto 0) := (others => 'U');-- * Output.
	signal cout : std_logic := 'U'; -- * Carry out.
	
begin
	
	-- * Instantiate Part_B architecture.
	iPart_b : entity work.Part(behavioral_b) 
	generic map(
        selection_size => 2
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

	-- * ----------------------------------- Part B --------------------------------------------
		-- ? Output = A xor B , Cout = 0
		A <= X"F0";
		B <= X"B0";
		cin <= '0';
		sel <= "00";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = A nand B , Cout = 0
		B <= X"0B";
		sel <= "01";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = A or B , Cout = 0
		B <= X"B0";
		sel <= "10";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Not A , Cout = 0
		sel <= "11";
		wait;
		-- * ---------------------------------------------------		
	-- * ---------------------------------------------------------------------------------------
		
	end process;


end architecture;
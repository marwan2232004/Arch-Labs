library ieee;
use ieee.std_logic_1164.all;

entity part_a_tb is
end entity;

architecture sim_b of part_a_tb is

	-- * Signals for testing Part_A with initial values.
	signal A : std_logic_vector(7 downto 0) := x"F0"; -- * First input.
	signal B : std_logic_vector(7 downto 0) := x"B0"; -- * Second input.
	signal sel : std_logic_vector(1 downto 0) := "00"; -- * Selection bits.
	signal cin : std_logic := '0'; -- * Carry in.
	
	signal output : std_logic_vector(7 downto 0) := (others => 'U');-- * Output.
	signal cout : std_logic := 'U'; -- * Carry out.
	
begin
	
	-- * Instantiate Part_A architecture.
	iPart_a : entity work.part(behavioral_a) 
	generic map(
        selection_size => 2,
		input_size => 8
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

	-- * ----------------------------------- Part A --------------------------------------------
		A <= X"F0";
		B <= X"B0";
		cin <= '0';
		sel <= "00";
		wait for 20 ns;
		-- * ---------------------------------------------------
		sel <= "01";
		wait for 20 ns;
		-- * ---------------------------------------------------
		sel <= "10";
		wait for 20 ns;
		-- * ---------------------------------------------------
		sel <= "11";
		wait for 20 ns;

        cin <= '1';
        sel <= "00";
		wait for 20 ns;
		-- * ---------------------------------------------------
		sel <= "01";
		wait for 20 ns;
		-- * ---------------------------------------------------
		sel <= "10";
		wait for 20 ns;
		-- * ---------------------------------------------------
		sel <= "11";
		wait;

		-- * ---------------------------------------------------		
	-- * ---------------------------------------------------------------------------------------
		
	end process;


end architecture;
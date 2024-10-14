library ieee;
use ieee.std_logic_1164.all;

entity part_d_tb is
end entity;

architecture sim_d of part_d_tb is
	-- * Signals for testing Part_D with initial values.
	signal A : std_logic_vector(7 downto 0) := x"F0"; -- * First input.
	signal B : std_logic_vector(7 downto 0) := x"00"; -- * Second input.
	signal sel : std_logic_vector(1 downto 0) := "00";-- * Selection bits.
	signal cin : std_logic := '0'; -- * Carry in.
	
	signal output : std_logic_vector(7 downto 0) := (others => 'U');-- * Output.
	signal cout : std_logic := 'U'; -- * Carry out.
	
begin
	
	iPart_d : entity work.part(behavioral_d)
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
	
	-- * ----------------------------------- Part D --------------------------------------------
		-- ? Output = Logic shift right A , Cout = shifted bit
		sel <= "00";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Rotate right A , Cout = rotated bit
		sel <= "01";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Rotate right A with carry in , Cout = rotated bit , cin = 0
		cin <= '0';
		sel <= "10";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Arithmetic shift right A
		sel <= "11";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Rotate right A with carry in , Cout = rotated bit , cin = 1
		cin <= '1';
		sel <= "10";
		wait;
		-- * ---------------------------------------------------
	-- * ---------------------------------------------------------------------------------------
		
	end process;


end architecture;
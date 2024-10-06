library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end entity;

architecture sim_alu of ALU_tb is

	-- * Signals for testing ALU with initial values.	
	signal A : std_logic_vector(7 downto 0) := x"F0"; -- * First input.
	signal B : std_logic_vector(7 downto 0) := x"B0"; -- * Second input.
	signal sel : std_logic_vector(3 downto 0) := "0100"; -- * Selection bits.
	signal cin : std_logic := '0';  -- * Carry in.
	
	signal output : std_logic_vector(7 downto 0) := (others => 'U'); -- * Output.
	signal cout : std_logic := 'U';  -- * Carry out.
	
begin
	
	-- * Instantiate ALU architecture.
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
	-- * ----------------------------------- Part B --------------------------------------------
		-- ? Output = A xor B , Cout = 0
		A <= X"F0";
		B <= X"B0";
		cin <= '0';
		sel <= "0100";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = A nand B , Cout = 0
		B <= X"0B";
		sel <= "0101";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = A or B , Cout = 0
		B <= X"B0";
		sel <= "0110";
		wait for 20 ns;
		-- * --------------------------------------------------
		-- ? Output = Not A , Cout = 0
		sel <= "0111";
		wait for 20 ns;
		-- * ---------------------------------------------------		
	-- * ---------------------------------------------------------------------------------------
	-- * ----------------------------------- Part C --------------------------------------------
		-- ? Output = Logic shift left A , Cout = shifted bit
		sel <= "1000";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Rotate left A , Cout = rotated bit
		sel <= "1001";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Rotate left A with carry in , Cout = rotated bit , cin = 0
		cin <= '0';
		sel <= "1010";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = x"00" , Cout = 0
		sel <= "1011";
		wait for 20 ns;
		-- * ---------------------------------------------------
	-- * ---------------------------------------------------------------------------------------
	-- * ----------------------------------- Part D --------------------------------------------
		-- ? Output = Logic shift right A , Cout = shifted bit
		sel <= "1100";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Rotate right A , Cout = rotated bit
		sel <= "1101";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Rotate right A with carry in , Cout = rotated bit , cin = 0
		cin <= '0';
		sel <= "1110";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Output = Arithmetic shift right A
		sel <= "1111";
		wait for 20 ns;
		-- * ---------------------------------------------------
	-- * ---------------------------------------------------------------------------------------
	-- * ----------------------------------- Additional Cases ----------------------------------
		-- ? Part C : Output = Rotate left A with carry in , Cout = rotated bit , cin = 1
		cin <= '1';
		sel <= "1010";
		wait for 20 ns;
		-- * ---------------------------------------------------
		-- ? Part D : Output = Rotate right A with carry in , Cout = rotated bit , cin = 1
		cin <= '1';
		sel <= "1110";
		wait;
		-- * ---------------------------------------------------
	-- * ---------------------------------------------------------------------------------------	
		
end process;


end architecture;
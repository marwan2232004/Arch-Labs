library ieee;
use ieee.std_logic_1164.all;

entity part_d_tb is
end entity;

architecture sim_d of part_d_tb is

	signal A : std_logic_vector(7 downto 0) := x"F0";
	signal B : std_logic_vector(7 downto 0) := x"00";
	signal sel : std_logic_vector(1 downto 0) := "00";
	signal cin : std_logic := '0'; 
	
	signal output : std_logic_vector(7 downto 0) := (others => 'U');
	signal cout : std_logic_vector(0 downto 0) := (others => 'U'); 
	
begin
	
	iPart_d : entity work.Part(behavioral_d) port map(
		A,
		B,
		sel,
		cin,
		output,
		cout
	);	
	
	process is
	begin
	
		wait for 30 ns;
		sel <= "01";
		wait for 30 ns;
		sel <= "10";
		wait for 30 ns;
		sel <= "11";
		wait for 30 ns;
		sel <= "10";
		cin <= '1';
		wait;
		
	end process;


end architecture;
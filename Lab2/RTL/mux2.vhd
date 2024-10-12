library ieee;
use ieee.std_logic_1164.all;

-- * Mux entity with generic size for input and output.

entity Mux2 is
generic(
	size : integer
);
port(
	in1 : in std_logic_vector(size - 1 downto 0);
	in2 : in std_logic_vector(size - 1 downto 0);
	in3 : in std_logic_vector(size - 1 downto 0);
	in4 : in std_logic_vector(size - 1 downto 0);
	sel : in std_logic_vector(1 downto 0);
	output : out std_logic_vector(size - 1 downto 0)
);

end entity;

-- * Mux architecture with 4 inputs and 1 output.
architecture rtl of Mux2 is
begin

	process(in1, in2, in3, in4, sel) is
	begin
	
		case sel is
			when "00" =>
				output <= in1;
			when "01" =>
				output <= in2;
			when "10" =>
				output <= in3;
			when "11" =>
				output <= in4;
			when others =>
				output <= (others => 'X');
		end case;
		
	end process;

end architecture;
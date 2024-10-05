library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
port(
	in1 : in std_logic_vector(7 downto 0);
	in2 : in std_logic_vector(7 downto 0);
	in3 : in std_logic_vector(7 downto 0);
	in4 : in std_logic_vector(7 downto 0);
	sel : in std_logic_vector(1 downto 0);
	output : out std_logic_vector(7 downto 0)
);

end entity;

architecture rtl of mux2 is
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
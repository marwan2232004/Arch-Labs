library ieee;
use ieee.std_logic_1164.all;

entity Part is
	port(
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		sel : in std_logic_vector(1 downto 0);
		cin : in std_logic;
		output : out std_logic_vector(7 downto 0);
		cout : out std_logic
	);

end entity;

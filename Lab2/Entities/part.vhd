library ieee;
use ieee.std_logic_1164.all;

-- * Entity for single part of the ALU.
-- ! The ALU is also considered a part with a selection size of 4.
-- ! The first 2 bits of the selection vector are used to select the part.
-- ! The last 2 bits are used to select the operation of each part.
entity part is
	generic(
		selection_size : integer := 4;  -- Default value is 4
		input_size : integer := 8
	);
	port(
		A : in std_logic_vector(input_size - 1  downto 0);
		B : in std_logic_vector(input_size - 1 downto 0);
		sel : in std_logic_vector(selection_size - 1 downto 0);
		cin : in std_logic;
		output : out std_logic_vector(input_size - 1 downto 0);
		cout : out std_logic
	);

end entity;

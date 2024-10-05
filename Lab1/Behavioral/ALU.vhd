library ieee;
use ieee.std_logic_1164.all;
    
architecture behavioral of ALU is

	signal part_b_out : std_logic_vector(7 downto 0);
	signal part_c_out : std_logic_vector(7 downto 0);
	signal part_d_out : std_logic_vector(7 downto 0);

    signal cout_vector_b : std_logic_vector(0 downto 0);
	signal cout_vector_c : std_logic_vector(0 downto 0);
	signal cout_vector_d : std_logic_vector(0 downto 0);

begin

	iPart_b : entity work.Part(behavioral_b) port map(
		A,
		B,
		sel(1 downto 0),
		cin,
		part_b_out,
		cout_vector_b
	);	
    iPart_c : entity work.Part(behavioral_c) port map(
		A,
		B,
		sel(1 downto 0),
		cin,
		part_c_out,
		cout_vector_c
	);
    iPart_d : entity work.Part(behavioral_d) port map(
		A,
		B,
		sel(1 downto 0),
		cin,
		part_d_out,
		cout_vector_d
	);
    ipart_output : entity work.Mux2(rtl) 
    generic map(
        size => 8
    )
    port map(
        x"00",
        part_b_out,
        part_c_out,
        part_d_out,
        sel(3 downto 2),
        output
    );
    ic_output : entity work.Mux2(rtl) 
    generic map(
        size => 1
    )
    port map(
        "0",
        cout_vector_b,
        cout_vector_c,
        cout_vector_d,
        sel(3 downto 2),
        cout
    );


end architecture;
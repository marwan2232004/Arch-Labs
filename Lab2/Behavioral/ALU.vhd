library ieee;
use ieee.std_logic_1164.all;
    
architecture behavioral_alu of Part is

    -- * Signals for the output of each part. bit 8 is the carry out and the rest are the output.
    signal part_a_out : std_logic_vector(8 downto 0); 
	signal part_b_out : std_logic_vector(8 downto 0);
	signal part_c_out : std_logic_vector(8 downto 0);
	signal part_d_out : std_logic_vector(8 downto 0);
    -- * Output signal after muxing.
    signal temp_output : std_logic_vector(8 downto 0);

begin

    -- * Instantiate each part of the ALU.

    iPart_a : entity work.Part(behavioral_a)
    generic map(
        selection_size => 2
    )
    port map(
		A,
		B,
		sel(1 downto 0),
		cin,
		part_a_out(7 downto 0),
		part_a_out(8)
	);	

    -- *---------------------------------------------------------------------

	iPart_b : entity work.Part(behavioral_b)
    generic map(
        selection_size => 2
    )
    port map(
		A,
		B,
		sel(1 downto 0),
		cin,
		part_b_out(7 downto 0),
		part_b_out(8)
	);	

    -- *---------------------------------------------------------------------

    iPart_c : entity work.Part(behavioral_c)
    generic map(
        selection_size => 2
    )
    port map(
		A,
		B,
		sel(1 downto 0),
		cin,
		part_c_out(7 downto 0),
		part_c_out(8)
	);

    -- *---------------------------------------------------------------------

    iPart_d : entity work.Part(behavioral_d)
    generic map(
        selection_size => 2
    )
    port map(
		A,
		B,
		sel(1 downto 0),
		cin,
		part_d_out(7 downto 0),
		part_d_out(8)
	);

    -- *---------------------------------------------------------------------

    -- * Mux the outputs of the parts to get the final output.
    ipart_output : entity work.Mux2(rtl) 
    generic map(
        size => 9
    )
    port map(
        part_a_out,
        part_b_out,
        part_c_out,
        part_d_out,
        sel(3 downto 2),
        temp_output
    );

    -- *---------------------------------------------------------------------

    -- * Assign the output and cout of the ALU to the output of the mux.
    output <= temp_output(7 downto 0);
    cout <= temp_output(8);


end architecture;
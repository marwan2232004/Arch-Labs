library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


architecture behavioral_d of part is
    -- * Signals for saving the result of each operation and pass it to the mux.
    signal right_shift : std_logic_vector(input_size - 1 downto 0);
    signal right_rotate : std_logic_vector(input_size - 1 downto 0);
    signal right_rotate_carry : std_logic_vector(input_size - 1 downto 0); 
    signal arithmetic_shift_right : std_logic_vector(input_size - 1 downto 0);
    
begin
    right_shift <= '0' & A(input_size - 1 downto 1);  -- ? carry A(0)
    right_rotate <= A(0) & A(input_size - 1 downto 1); -- ?  carry A(0)
    right_rotate_carry <= cin & A(input_size - 1 downto 1); -- ? carry A(0)
    arithmetic_shift_right <= A(input_size - 1) & A(input_size - 1 downto 1); -- ? no carry 
    cout <= '0' when sel = "11" else A(0); 

    -- * Instantiate the mux.
    iMux2 : entity work.Mux2(rtl) 
    generic map(
        size => input_size
    )
    port map(
        right_shift,
        right_rotate,
        right_rotate_carry,
        arithmetic_shift_right,
        sel,
        output
    );
    

end architecture;


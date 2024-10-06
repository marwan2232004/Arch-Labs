library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


architecture behavioral_d of Part is
    signal right_shift : std_logic_vector(7 downto 0);
    signal right_rotate : std_logic_vector(7 downto 0);
    signal right_rotate_carry : std_logic_vector(7 downto 0); 
    signal arithmetic_shift_right : std_logic_vector(7 downto 0);
    
begin
    right_shift <= '0' & A(7 downto 1);  -- ? carry A(0)
    right_rotate <= A(0) & A(7 downto 1); -- ?  carry A(0)
    right_rotate_carry <= cin & A(7 downto 1); -- ? carry A(0)
    arithmetic_shift_right <= A(7) & A(7 downto 1); -- ? no carry 
    cout <= '0' when sel = "11" else A(0); 

    iMux2 : entity work.Mux2(rtl) 
    generic map(
        size => 8
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


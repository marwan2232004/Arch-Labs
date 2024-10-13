library ieee;
use ieee.std_logic_1164.all;

--One bit full adder

entity FullAdder is
port(
        A     : in std_logic; 
        B     : in std_logic;  
        cin   : in  std_logic;  
        F   : out std_logic;  
        cout  : out std_logic
    );
end entity;

architecture rtl of FullAdder is
begin
    process(A, B, Cin)
    begin
        F  <= A XOR B XOR cin;            
        cout <= (A AND B) OR (cin AND (A XOR B));
    end process;
end architecture;

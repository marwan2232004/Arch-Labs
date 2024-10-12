library ieee;
use ieee.std_logic_1164.all;

entity nBitFullAdder is
    generic(
        size : integer
    );
    port(
        A     : in std_logic_vector(size - 1 downto 0); 
        B     : in std_logic_vector(size - 1 downto 0);  
        cin   : in  std_logic;  
        op    : in  std_logic; 
        sum   : out std_logic_vector(size - 1 downto 0);  
        cout  : out std_logic
    );
end entity;

architecture behavioral of nBitFullAdder is
    signal cin_modified : std_logic_vector(size downto 0);
    signal B_modified : std_logic_vector(size - 1 downto 0);

begin
    cin_modified(0) <= cin;  

    B_modified <= (not B) when op = '1' else B;

    gen_full_adders: for i in 0 to size - 1 generate
        ifulladder: entity work.FullAdder(rtl)
            port map(
                A(i),
                B_modified(i),
                cin_modified(i),
                sum(i),
                cin_modified(i + 1)
            );
    end generate;

    cout <= cin_modified(size); 


end architecture;

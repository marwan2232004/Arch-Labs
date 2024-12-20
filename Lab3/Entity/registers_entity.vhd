library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY registers IS

    GENERIC (
        data_size : INTEGER := 8;
        address_size : INTEGER := 3
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        we : IN STD_LOGIC;
        read_addr1 : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
        read_addr2 : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
        write_addr : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
        write_data : IN STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
        read_data1 : OUT STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
        read_data2 : OUT STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0)
    );

END ENTITY;
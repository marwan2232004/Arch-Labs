LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY register_mem IS
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

ARCHITECTURE behavioral_register OF register_mem
    IS
    TYPE reg_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL registers : reg_array := (OTHERS => (OTHERS => '0'));
    SIGNAL read_data1_res : STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
    SIGNAL read_data2_res : STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
BEGIN
    read_data1_res <= write_data WHEN (write_addr = read_addr1 AND we = '1') ELSE
        registers(to_integer(unsigned(read_addr1)));

    read_data2_res <= write_data WHEN (write_addr = read_addr2 AND we = '1') ELSE
        registers(to_integer(unsigned(read_addr2)));

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            registers <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk) THEN
            IF we = '1' THEN
                registers(to_integer(unsigned(write_addr))) <= write_data;
            END IF;
        END IF;
    END PROCESS;
    read_data1 <= registers(to_integer(unsigned(read_addr1)));
    read_data2 <= registers(to_integer(unsigned(read_addr2)));
END ARCHITECTURE;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register_mem_tb IS
END ENTITY;

ARCHITECTURE sim OF register_mem_tb IS
    SIGNAL clk : STD_LOGIC;
    SIGNAL rst : STD_LOGIC;
    SIGNAL we : STD_LOGIC;
    SIGNAL read_addr1 : STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
    SIGNAL read_addr2 : STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
    SIGNAL write_addr : STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
    SIGNAL write_data : STD_LOGIC_VECTOR(8 - 1 DOWNTO 0);
    SIGNAL read_data1 : STD_LOGIC_VECTOR(8 - 1 DOWNTO 0);
    SIGNAL read_data2 : STD_LOGIC_VECTOR(8 - 1 DOWNTO 0);
BEGIN

    iRegister : ENTITY work.registers(behavioral_register_mem)
        GENERIC MAP(
            data_size => 8,
            address_size => 3
        )
        PORT MAP(
            clk,
            rst,
            we,
            read_addr1,
            read_addr2,
            write_addr,
            write_data,
            read_data1,
            read_data2
        );

    PROCESS IS
    BEGIN

        rst <= '1';
        clk <= '0';
        we <= '0';
        write_addr <= "000";
        write_data <= x"00";
        read_addr1 <= "000";
        read_addr2 <= "000";
        WAIT FOR 10 ns;

        rst <= '0';

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '1';
        write_addr <= "000";
        write_data <= x"FF";
        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '1';
        write_addr <= "001";
        write_data <= x"11";
        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '1';
        write_addr <= "111";
        write_data <= x"90";
        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '1';
        write_addr <= "011";
        write_data <= x"08";
        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '1';
        write_addr <= "100";
        write_data <= x"03";
        read_addr1 <= "001";
        read_addr2 <= "111";
        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '0';
        read_addr1 <= "010";
        read_addr2 <= "011";
        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '0';
        read_addr1 <= "100";
        read_addr2 <= "101";
        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;

        clk <= '0';
        we <= '1';
        write_addr <= "000";
        write_data <= x"01";
        read_addr1 <= "110";
        read_addr2 <= "000";
        WAIT FOR 10 ns;

        clk <= '1';
        WAIT;

    END PROCESS;
END ARCHITECTURE;
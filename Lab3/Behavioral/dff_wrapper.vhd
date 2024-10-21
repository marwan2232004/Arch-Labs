LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY dff_wrapper IS
    GENERIC (n : INTEGER := 8);
    PORT (
        idx : IN INTEGER;
        we : IN INTEGER;
        re1 : IN INTEGER;
        re2 : IN INTEGER;
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q1 : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q2 : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));

END ENTITY;

ARCHITECTURE behavioral OF dff_wrapper
    IS
    SIGNAL modified_q : STD_LOGIC_VECTOR(n - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL write_en : STD_LOGIC;
BEGIN
    write_en = '1' WHEN (we = idx) ELSE
    '0';

    iDff : ENTITY work.dff(rtl)
        GENERIC MAP(n => n)
        PORT MAP(
            clk => clk,
            rst => rst,
            we => we,
            d => d,
            q => modified_q
        );

    IF (re1 = idx) THEN
        q1 <= modified_q;
    ELSIF (re2 = idx) THEN
        q2 <= modified_q;
    END IF;

END ARCHITECTURE;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY elevator_tb IS
END ENTITY elevator_tb;

ARCHITECTURE behavior OF elevator_tb IS
    -- Signals for the testbench
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL requests : STD_LOGIC_VECTOR(0 TO 9) := (OTHERS => '0');
    SIGNAL clk_out : STD_LOGIC;
    SIGNAL current_floor : INTEGER;
    SIGNAL next_floor : INTEGER;
    SIGNAL state : INTEGER;

    -- Clock period definition
    CONSTANT clk_period : TIME := 20 ns;

BEGIN

    iElevator : ENTITY work.elevator_controller(behavioral)
        GENERIC MAP(
            floor_num => 10
        )
        PORT MAP(
            clk,
            rst,
            requests,
            clk_out,
            current_floor,
            next_floor,
            state
        );

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- hold reset state for 20 ns.
        rst <= '1';
        WAIT FOR CLK_PERIOD;
        rst <= '0';

        -- wait for 10 ns
        requests(7) <= '1';
        WAIT FOR 1 SEC;
        requests(7) <= '0';
        requests(3) <= '1';
        WAIT FOR 1 SEC;
        requests(3) <= '0';
        requests(1) <= '1';
        WAIT FOR 1 SEC;
        requests(1) <= '0';
        WAIT FOR 35 SEC;

        requests(5) <= '1';
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
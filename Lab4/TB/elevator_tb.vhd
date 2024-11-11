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
        WAIT FOR 200 ms;
        rst <= '0';
        WAIT FOR 800 ms;
        requests(7) <= '1';
        WAIT FOR 10 ms;
        requests(7) <= '0';
        WAIT FOR 1 sec;
        requests(3) <= '1';
        WAIT FOR 10 ms;
        requests(3) <= '0';
        WAIT FOR 2 sec;

        requests(1) <= '1';
        WAIT FOR 10 ms;
        requests(1) <= '0';
        WAIT FOR 1 sec;

        -- Wait for door to close
        WAIT FOR 1 sec;

        -- Wait for elevator to reach the 7th floor
        WAIT FOR 5 sec;

        -- Wait for door to close
        WAIT FOR 2 sec;

        WAIT FOR 1 sec;

        -- Wait for elevator to reach the 1st floor
        WAIT FOR 6 sec;

        -- Wait for door to close
        WAIT FOR 2 sec;

        WAIT FOR 1 sec;
        -- End simulation
        WAIT FOR 6 sec;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
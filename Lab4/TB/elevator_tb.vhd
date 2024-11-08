library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elevator_tb is
end entity elevator_tb;

architecture behavior of elevator_tb is


    -- Signals for the testbench
    signal clk         : std_logic := '0';
    signal rst       : std_logic := '0';
    signal requests   : std_logic_vector(0 to 9) := (others => '0');
    signal clk_out    : std_logic;
    signal current_floor : integer;
    signal next_floor : integer;
    signal state : integer;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

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
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 20 ns.
        rst <= '1';
        wait for 20 ns;  
        rst <= '0';
        
        -- wait for 10 ns
        wait for 10 ns;
        requests <= "0000010000";
        wait for 900 ns;
        requests <= "1000000010";

        wait;
    end process;

end architecture behavior;
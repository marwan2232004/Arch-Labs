LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY elevator_controller IS
    GENERIC (
        floor_num : INTEGER := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC;
        current_floor : OUT INTEGER;
        next_floor : OUT INTEGER;
        rst : IN STD_LOGIC;
        requests : IN STD_LOGIC_VECTOR(0 TO floor_num - 1);
        state : OUT INTEGER
    );

END ENTITY;

ARCHITECTURE behavioral OF elevator_controller IS
BEGIN
    SIGNAL current_floor_reg : INTEGER := 0;
    SIGNAL state_reg : INTEGER := 0;
    SIGNAL prev_dir : INTEGER := 0;
    SIGNAL counter : INTEGER := 0;
    SIGNAL clk_reg : STD_LOGIC := '0';
    CONSTANT CLKFREQ : INTEGER := 50000000;
    CONSTANT DIVISOR : INTEGER := CLKFREQ / 2;

    PROCESS (clk_in, reset)
    BEGIN
        IF reset = '1' THEN
            counter <= 0;
            clk_reg <= '0';
        ELSIF rising_edge(clk_in) THEN
            IF counter = DIVISOR - 1 THEN
                counter <= 0;
                clk_reg <= NOT clk_reg;
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (state_reg)
    BEGIN
        IF state_reg = 1 THEN
            prev_dir <= 0;
        ELSIF state_reg = 2 THEN
            prev_dir <= 2;
        END IF;
    END PROCESS;

    i_req_res : ENTITY work.request_resolver(behavioral)
        GENERIC MAP(
            floor_num => floor_num
        )
        PORT MAP(
            clk => clk_reg,
            rst => rst,
            requests => requests,
            request => next_floor,
            current_floor => current_floor,
            prev_dir => prev_dir,
            state => state_reg,
        );

    i_unit_control : ENTITY work.unit_control(behavioral)
        GENERIC MAP(
            floor_num => floor_num
        )
        PORT MAP(
            clk => clk_reg,
            rst => rst,
            current_floor => current_floor_reg,
            new_current_floor => current_floor,
            next_floor => next_floor,
            new_state => state_reg,
        );
    state <= state_reg;
    clk_out <= clk_reg;
END ARCHITECTURE;
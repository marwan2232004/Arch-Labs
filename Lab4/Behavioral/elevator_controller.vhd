LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY elevator_controller IS
    GENERIC (
        floor_num : INTEGER := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        requests : IN STD_LOGIC_VECTOR(0 TO floor_num - 1);
        clk_out : OUT STD_LOGIC;
        current_floor : OUT INTEGER;
        next_floor : OUT INTEGER;
        state : OUT INTEGER;
        seg_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        move_up : OUT STD_LOGIC;
        move_down : OUT STD_LOGIC;
        door_open : OUT STD_LOGIC
    );

END ENTITY;

-- state = 0: idle, 1: moving down, 2: moving up

ARCHITECTURE behavioral OF elevator_controller IS
    SIGNAL requests_reg : STD_LOGIC_VECTOR(0 TO floor_num - 1) := (OTHERS => '0');
    SIGNAL current_floor_reg : INTEGER := 0;
    SIGNAL current_floor_intermediate : INTEGER := 0;
    SIGNAL next_floor_reg : INTEGER := 0;
    SIGNAL next_floor_intermediate : INTEGER := 0;
    SIGNAL state_reg : INTEGER := 0;
    SIGNAL prev_dir : INTEGER := 0;
    SIGNAL prev_dir_intermediate : INTEGER := 0;
    SIGNAL counter : INTEGER := 0;
    SIGNAL clk_reg : STD_LOGIC := '0';
    CONSTANT CLKFREQ : INTEGER := 50000000;
    CONSTANT DIVISOR : INTEGER := CLKFREQ / 2;
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            counter <= 0;
            clk_reg <= '0';
        ELSIF rising_edge(clk) THEN
            IF counter = DIVISOR - 1 THEN
                counter <= 0;
                clk_reg <= NOT clk_reg;
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;

    i_req_res : ENTITY work.request_resolver(behavioral)
        GENERIC MAP(
            floor_num => floor_num
        )
        PORT MAP(
            rst => rst,
            requests => requests_reg,
            prev_request => next_floor_intermediate,
            current_floor => current_floor_reg,
            prev_dir => prev_dir,
            state => state_reg,
            request => next_floor_reg
        );

    next_floor_intermediate <= next_floor_reg;

    i_unit_control : ENTITY work.unit_control(behavioral)
        GENERIC MAP(
            floor_num => floor_num
        )
        PORT MAP(
            clk => clk_reg,
            rst => rst,
            current_floor => current_floor_reg,
            next_floor => next_floor_reg,
            dir => prev_dir,
            new_current_floor => current_floor_intermediate,
            new_state => state_reg,
            new_dir => prev_dir_intermediate
        );
    -- To update the direction with the new direction
    PROCESS (prev_dir_intermediate)
    BEGIN
        IF prev_dir_intermediate < 0 OR prev_dir_intermediate > 2 THEN
            prev_dir <= 0;
        ELSE
            prev_dir <= prev_dir_intermediate;
        END IF;
    END PROCESS;

    PROCESS (current_floor_intermediate)
    BEGIN
        IF (current_floor_intermediate < 0 OR current_floor_intermediate > floor_num - 1) THEN
            current_floor_reg <= 0;
        ELSE
            current_floor_reg <= current_floor_intermediate;
        END IF;
    END PROCESS;

    PROCESS (current_floor_reg, requests, requests_reg, next_floor_reg)
        VARIABLE temp_requests : STD_LOGIC_VECTOR(0 TO floor_num - 1) := (OTHERS => '0');
        VARIABLE mask : STD_LOGIC_VECTOR(0 TO floor_num - 1) := (OTHERS => '1');
    BEGIN
        mask := (OTHERS => '1');
        IF (next_floor_reg = current_floor_reg AND prev_dir > 0) THEN
            mask(current_floor_reg) := '0';
            temp_requests := requests_reg AND mask;
            requests_reg <= temp_requests OR requests;
        ELSE
            requests_reg <= requests_reg OR requests;
        END IF;

    END PROCESS;

    PROCESS (current_floor_reg)
    BEGIN
        CASE current_floor_reg IS
            WHEN 0 => seg_out <= "1000000";
            WHEN 1 => seg_out <= "1111001";
            WHEN 2 => seg_out <= "0100100";
            WHEN 3 => seg_out <= "0110000";
            WHEN 4 => seg_out <= "0011001";
            WHEN 5 => seg_out <= "0010010";
            WHEN 6 => seg_out <= "0000010";
            WHEN 7 => seg_out <= "1111000";
            WHEN 8 => seg_out <= "0000000";
            WHEN 9 => seg_out <= "0010000";
            WHEN OTHERS => seg_out <= "1111111"; -- All segments off for invalid input
        END CASE;
    END PROCESS;

    PROCESS (state_reg)
    BEGIN
        CASE state_reg IS
            WHEN 0 =>
                door_open <= '1';
                move_up <= '0';
                move_down <= '0';
            WHEN 1 =>
                door_open <= '0';
                move_up <= '0';
                move_down <= '1';
            WHEN 2 =>
                door_open <= '0';
                move_up <= '1';
                move_down <= '0';
            WHEN OTHERS =>
                door_open <= '0';
                move_up <= '0';
                move_down <= '0';
        END CASE;
    END PROCESS;

    current_floor <= current_floor_reg;
    next_floor <= next_floor_reg;
    state <= state_reg;
    clk_out <= clk_reg;
END ARCHITECTURE;
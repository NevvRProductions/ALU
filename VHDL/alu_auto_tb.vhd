library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_combinations is
end tb_combinations;

architecture behavior of tb_combinations is
    signal X_tb, Y_tb : std_logic_vector(3 downto 0);
    signal CBi_tb, CBo, OV, Z, P, GE, BE : std_logic;
    signal OP_tb : std_logic_vector(2 downto 0);
    signal R : std_logic_vector(3 downto 0);  -- Result of the operation

    -- Expected output signals
    signal expected_R : std_logic_vector(3 downto 0);
    signal expected_CBo, expected_OV, expected_Z, expected_P, expected_GE, expected_BE : std_logic;

    -- Component declaration for the Unit Under Test (UUT)
    component alu
        Port ( X, Y : in STD_LOGIC_VECTOR(3 downto 0);
               CBi : in STD_LOGIC;
               OP : in STD_LOGIC_VECTOR(2 downto 0);
               CBo, OV, Z, P, GE, BE : out STD_LOGIC;
               R : out std_logic_vector(3 downto 0));
    end component;

    -- Function to compute parity
    function compute_parity(vec : std_logic_vector) return std_logic is
        variable parity : std_logic := '0';
    begin
        for i in vec'range loop
            parity := parity xor vec(i);
        end loop;
        return parity;
    end function;

    -- Custom function to convert std_logic_vector to hexadecimal string
    function to_hstring(slv : std_logic_vector) return string is
        variable hex : string(1 to slv'length/4);
        variable nibble : std_logic_vector(3 downto 0);
    begin
        for i in hex'range loop
            nibble := slv((i*4)-1 downto (i-1)*4);
            case nibble is
                when "0000" => hex(i) := '0';
                when "0001" => hex(i) := '1';
                when "0010" => hex(i) := '2';
                when "0011" => hex(i) := '3';
                when "0100" => hex(i) := '4';
                when "0101" => hex(i) := '5';
                when "0110" => hex(i) := '6';
                when "0111" => hex(i) := '7';
                when "1000" => hex(i) := '8';
                when "1001" => hex(i) := '9';
                when "1010" => hex(i) := 'A';
                when "1011" => hex(i) := 'B';
                when "1100" => hex(i) := 'C';
                when "1101" => hex(i) := 'D';
                when "1110" => hex(i) := 'E';
                when "1111" => hex(i) := 'F';
                when others => hex(i) := 'X';
            end case;
        end loop;
        return hex;
    end function;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: alu port map (
        X => X_tb,
        Y => Y_tb,
        CBi => CBi_tb,
        OP => OP_tb,
        CBo => CBo,
        OV => OV,
        Z => Z,
        P => P,
        GE => GE,
        BE => BE,
        R => R
    );

    test_process : process
        variable x_int, y_int : integer;
        variable result_int : integer;
        variable iOV, iCB, CY : std_logic;
    begin
        -- Initialize inputs
        X_tb <= (others => '0');
        Y_tb <= (others => '0');
        CBi_tb <= '0';
        OP_tb <= (others => '0');

        wait for 10 ns;

        for op_value in 0 to 7 loop
            for x_int in 0 to 15 loop
                for y_int in 0 to 15 loop
                    for cbi in 0 to 1 loop
                        -- Assign inputs
                        X_tb <= std_logic_vector(to_unsigned(x_int, 4));
                        Y_tb <= std_logic_vector(to_unsigned(y_int, 4));
                        if cbi = 0 then
                            CBi_tb <= '0';
                        else
                            CBi_tb <= '1';
                        end if;
                        OP_tb <= std_logic_vector(to_unsigned(op_value, 3));

                        wait for 10 ns;

                        -- Compute expected result and flags
                        case op_value is
                            when 0 => -- X + CBi
                                result_int := x_int + cbi;
                                if result_int > 15 then
                                    iCB := '1';
                                else
                                    iCB := '0';
                                end if;
                                if (x_int < 8 and result_int > 7) or (x_int > 7 and result_int < 8) then
                                    iOV := '1';
                                else
                                    iOV := '0';
                                end if;
                            when 1 => -- X - CBi
                                result_int := x_int - cbi;
                                if result_int < 0 then
                                    iCB := '1';
                                else
                                    iCB := '0';
                                end if;
                                if (x_int < 8 and result_int > 7) or (x_int > 7 and result_int < 8) then
                                    iOV := '1';
                                else
                                    iOV := '0';
                                end if;
                            when 2 => -- X + Y + CBi
                                result_int := x_int + y_int + cbi;
                                if result_int > 15 then
                                    iCB := '1';
                                else
                                    iCB := '0';
                                end if;
                                if ((x_int < 8 and y_int < 8 and result_int > 7) or (x_int > 7 and y_int > 7 and result_int < 8)) then
                                    iOV := '1';
                                else
                                    iOV := '0';
                                end if;
                            when 3 => -- X - Y - CBi
                                result_int := x_int - y_int - cbi;
                                if result_int < 0 then
                                    iCB := '1';
                                else
                                    iCB := '0';
                                end if;
                                if ((x_int < 8 and y_int > 7 and result_int > 7) or (x_int > 7 and y_int < 8 and result_int < 8)) then
                                    iOV := '1';
                                else
                                    iOV := '0';
                                end if;
                            when 4 => -- X >>> 1
                                result_int := x_int / 2;
                                iCB := X_tb(0);
                                iOV := '0';
                            when 5 => -- X >> 1
                                result_int := x_int / 2;
                                iCB := X_tb(0);
                                iOV := '0';
                            when 6 => -- X <<< 1
                                result_int := (x_int * 2) mod 16;
                                iCB := X_tb(3);
                                iOV := X_tb(3) xor X_tb(2);
                            when 7 => -- X NAND Y
                                result_int := to_integer(unsigned(X_tb nand Y_tb));
                                iCB := '0';
                                iOV := '0';
                            when others =>
                                result_int := 0;
                                iCB := '0';
                                iOV := '0';
                        end case;

                        if op_value = 6 or op_value = 4 or op_value = 5 then
                            CY := '1';
                        else
                            CY := '0';
                        end if;
                        
                        -- Assign expected outputs
                        expected_R <= std_logic_vector(to_unsigned(result_int mod 16, 4));
                        if OP_tb(0) = '1' then
                            expected_CBo <= CY;
                        else
                            expected_CBo <= iCB;
                        end if;
                        expected_OV <= iOV;
                        
                        if result_int mod 16 = 0 then
                            expected_Z <= '1';
                        else
                            expected_Z <= '0';
                        end if;
                        
                        expected_P <= compute_parity(std_logic_vector(to_unsigned(result_int mod 16, 4)));
                        
                        -- Compute GE (Greater than or Equal)
                        if to_integer(signed(X_tb)) >= (to_integer(signed(Y_tb)) + cbi) then
                            expected_GE <= '1';
                        else
                            expected_GE <= '0';
                        end if;

                        -- Compute BE (Below or Equal)
                        if to_integer(unsigned(X_tb)) <= (to_integer(unsigned(Y_tb)) + cbi) then
                            expected_BE <= '1';
                        else
                            expected_BE <= '0';
                        end if;

                        -- Add a small wait time to allow ALU to compute
                        wait for 5 ns;
                        
                        -- Check result
                        assert (R = expected_R) 
                            report "R mismatch. Expected " & to_hstring(expected_R) & 
                                   " but got " & to_hstring(R)
                            severity failure;

                        -- Check flags
                        assert (Z = expected_Z) report "Z flag mismatch" severity failure;
                        assert (GE = expected_GE) report "GE flag mismatch" severity failure;
                        assert (BE = expected_BE) report "BE flag mismatch" severity failure;
                        assert (P = expected_P) report "P flag mismatch" severity failure;
                        assert (OV = expected_OV) report "OV flag mismatch" severity failure;
                        assert (CBo = expected_CBo) report "CBo flag mismatch" severity failure;

                        -- Print current test case information
                        report "Test case: OP = " & integer'image(op_value) &
                               ", X = " & integer'image(x_int) &
                               ", Y = " & integer'image(y_int) &
                               ", CBi = " & integer'image(cbi) &
                               ", R = " & to_hstring(R);

                    end loop;
                end loop;
            end loop;
        end loop;

        -- If we reach here, all tests passed
        report "All tests passed successfully!";
        wait;
    end process;
end behavior;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_combinations is
-- No ports for a test bench
end tb_combinations;

architecture behavior of tb_combinations is

    component ALU
        port (  X,Y : in std_logic_vector(3 downto 0);
                    OP : in std_logic_vector(2 downto 0);
                    CBi : in std_logic;
                    R : out std_logic_vector(3 downto 0);
                    CBo : out std_logic;
                    OV : out std_logic;
                    Z : out std_logic;
                    P : out std_logic;
                    GE : out std_logic;
                    BE : out std_logic
             );
    end component;
    -- Declare the signals for the test bench
    signal X_tb : std_logic_vector(3 downto 0);
    signal Y_tb : std_logic_vector(3 downto 0);
    signal CBi_tb : std_logic;
    signal OP_tb : std_logic_vector(2 downto 0);

    signal R_uut_tb : std_logic_vector(3 downto 0);
    signal CBo_uut_tb : std_logic;
    signal OV_uut_tb : std_logic;
    signal Z_uut_tb : std_logic;
    signal P_uut_tb : std_logic;
    signal GE_uut_tb : std_logic;
    signal BE_uut_tb : std_logic;
    
begin
    UUT : ALU port map (
                        X => X_tb,
                        Y => Y_tb,
                        OP => OP_tb,
                        CBi => CBi_tb,
                        R => R_uut_tb,
                        CBo => CBo_uut_tb,
                        OV => OV_uut_tb,
                        Z => Z_uut_tb,
                        P => P_uut_tb,
                        GE => GE_uut_tb,
                        BE => BE_uut_tb
                    );
    -- Test process
    test_process : process
        variable i, j : integer; -- For loop variables for X_tb and Y_tb
        variable cbi : integer; -- For loop variable for CBi_tb
        variable op_value : integer; -- For loop variable for OP_tb
    begin
        -- Iterate over all combinations of OP_tb (3-bit binary)
        for op_value in 0 to 7 loop
            -- Iterate over all combinations of X_tb and Y_tb (4-bit binary)
            for i in 0 to 15 loop
                for j in 0 to 15 loop
                    -- Iterate over all combinations of CBi_tb
                    for cbi in 0 to 1 loop
                        -- Assign values
                        X_tb <= std_logic_vector(to_unsigned(i, 4));
                        Y_tb <= std_logic_vector(to_unsigned(j, 4));
                        
                        -- Assign CBi_tb
                        if cbi = 0 then
                            CBi_tb <= '0';
                        else
                            CBi_tb <= '1';
                        end if;

                        -- Assign OP_tb in sequential order
                        OP_tb <= std_logic_vector(to_unsigned(op_value, 3));

                        -- Wait for 10 ns for each combination
                        wait for 10 ns;
                    end loop;
                end loop;
            end loop;
        end loop;
        
        -- Stop the simulation
        wait;
    end process;
end behavior;

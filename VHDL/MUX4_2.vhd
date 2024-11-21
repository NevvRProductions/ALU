library ieee;
use ieee.std_logic_1164.all;

entity MUX4_2 is
	port(
		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		C : in std_logic_vector (3 downto 0);
		D : in std_logic_vector (3 downto 0);
		S0 : in std_logic;
		S1 : in std_logic;
		R : out std_logic_vector (3 downto 0)
		);
end MUX4_2;

architecture MUX4_2_arq of MUX4_2 is
component MUX4 is
port (
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	Op : in std_logic;
	R : out std_logic_vector (3 downto 0)
	);
end component;

signal muxCarry1, muxCarry2 : std_logic_vector (3 downto 0);

begin 

U1 : MUX4 port map (A => A, B => B, Op => S0, R => muxCarry1);
U2 : MUX4 port map (A => C, B => D, Op => S0, R => muxCarry2);
U3 : MUX4 port map (A => muxCarry1, B => muxCarry2, Op => S1, R => R);

end MUX4_2_arq;
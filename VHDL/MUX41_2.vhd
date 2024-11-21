library ieee;
use ieee.std_logic_1164.all;

entity MUX41_2 is
	port(
		A : in std_logic;
		B : in std_logic;
		C : in std_logic;
		D : in std_logic;
		S0 : IN STD_LOGIC;
		S1 : IN STD_LOGIC;
		R : out std_logic
		);
end MUX41_2;

architecture MUX41_2_arq of MUX41_2 is
component MUX41 is
port (
	A : in std_logic;
	B : in std_logic;
	Op : in std_logic;
	R : out std_logic
	);
end component;

signal muxCarry : std_logic_vector (1 downto 0);

begin 

U1 : MUX41 port map (A => A, B => B, Op => S0, R => muxCarry(0));
U2 : MUX41 port map (A => C, B => D, Op => S0, R => muxCarry(1));
U3 : MUX41 port map (A => muxCarry(0), B => muxCarry(1), Op => S1, R => R);

end MUX41_2_arq;
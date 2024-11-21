library ieee;
use ieee.std_logic_1164.all;

entity LOGM is
	port(
		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		OPD : in std_logic;
		OPE : in std_logic;
		CY : out std_logic;
		R : out std_logic_vector (3 downto 0)
		);
end LOGM;

architecture LOGM_arq of LOGM is
component LSL4 is
port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	
	R : out std_logic_vector (3 downto 0);
	CY : out std_logic
	);
end component;

component LSR4 is
port(
		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		
		R : out std_logic_vector (3 downto 0);
		CY : out std_logic
		);
end component;

component ASR4 is
port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	
	R : out std_logic_vector (3 downto 0);
	CY : out std_logic
	);
end component;

component NAND_4 is
port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	
	R : out std_logic_vector (3 downto 0)
	);
end component;

component MUX4_2 is
port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	C : in std_logic_vector (3 downto 0);
	D : in std_logic_vector (3 downto 0);
	S0 : in std_logic;
	S1 : in std_logic;
	R : out std_logic_vector (3 downto 0)
	);
end component;

component MUX41_2 is
port(
		A : in std_logic;
		B : in std_logic;
		C : in std_logic;
		D : in std_logic;
		S0 : IN STD_LOGIC;
		S1 : IN STD_LOGIC;
		R : out std_logic
		);
end component;

signal logCarry1, logCarry2, logCarry3, logCarry4 : std_logic_vector (3 downto 0);
signal CYtoMux : std_logic_vector (2 downto 0);

begin

U1 : LSL4 port map (A => A, B => B, R => logCarry1, CY => CYtoMux(1));
U2 : LSR4 port map (A => A, B => B, R => logCarry2, CY => CYtoMux(0));
U3 : ASR4 port map (A => A, B => B, R => logCarry3, CY => CYtoMux(2));
U4 : NAND_4 port map (A => A, B => B, R => logCarry4);
U5 : MUX4_2 port map (A => logCarry2, B => logCarry1, C => logCarry3, D => logCarry4, S0 => OPD, S1 => OPE, R => R);
U6 : MUX41_2 port map (A => CYtoMux(0), B => CYtoMux(1), C => CYtoMux(2), D => '0', S0 => OpD, S1 => OPE, R => CY);

end LOGM_arq;

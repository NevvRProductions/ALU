library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port (
		X : in std_logic_vector (3 downto 0);
		Y : in std_logic_vector (3 downto 0);
		CBi : in std_logic;
		OP : in std_logic_vector (2 downto 0);
		BE : out std_logic;
		GE : out std_logic;
		P : out std_logic;
		Z : out std_logic;
		OV : out std_logic;
		CBo : out std_logic;
		R : out std_logic_vector (3 downto 0)
		);
end ALU;

architecture ALU_arq of ALU is
component AU is
port (
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	CBi : in std_logic;
	OPau : in std_logic;
	R : out std_logic_vector (3 downto 0);
	OV : out std_logic;
	CBo : out std_logic
	);
end component;


component Decoder is
port (
	OP0, OP1, OP2 : in std_logic;
	OPA, OPB, OPC, OPD, OPE, OPF : out std_logic
	);
end component;

component Flags2 is
port (
	iOV : in std_logic;
	iCB : in std_logic;
	OP : in std_logic;
	R : in std_logic_vector (3 downto 0);
	CY : in std_logic;
	BE : out std_logic;
	GE : out std_logic;
	P : out std_logic;
	Z : out std_logic;
	OVo : out std_logic;
	CBo : out std_logic
	);
end component;

component LOGM is
port(
		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		OPD : in std_logic;
		OPE : in std_logic;
		CY : out std_logic;
		R : out std_logic_vector (3 downto 0)
		);
end component;

component MUX4 is
port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	Op : in std_logic;
	R : out std_logic_vector (3 downto 0)
	);
end component;

component YorO is
port (
		Y : in std_logic_vector (3 downto 0);
		OPA : in std_logic;
		B : out std_logic_vector (3 downto 0)
		);
end component;

signal carryCY : std_logic;
signal YorOcarry : std_logic_vector (3 downto 0);
signal opCarry : std_logic_vector (5 downto 0);
signal ovFlags : std_logic;
signal cbFlags : std_logic;
signal rMux1, rMux2 : std_logic_vector (3 downto 0);
signal rFlags : std_logic_vector (3 downto 0);

begin
 
U1 : Decoder port map(OP0 => OP(0), OP1 => OP(1), OP2 => OP(2), OPA => opCarry(0), OPB => opCarry(1), OPC => opCarry(2), OPD => opCarry(3), OPE => opCarry(4), OPF => opCarry(5));
U2 : AU port map (A => X, B => YorOcarry, CBi => CBi, OPau => opCarry(1), OV => ovFlags, CBo => cbFlags, R => rMux1);
U3 : Flags2 port map (CY => carryCY, iOV => ovFlags, iCB => cbFlags, R => rFlags, OP => opCarry(5), P => P, Z => Z, BE => BE, GE => GE, CBo => CBo, OVo => OV);
U4 : MUX4 port map (A => rMux1, B => rMux2, Op => opCarry(2), R => rFlags);
U5 : LOGM port map (A => X, B => Y, OPD => opCarry(3), OPE => opCarry(4), R => rMux2, CY => carryCY);
U6 : YorO port map (Y => Y, OPA => opCarry(0),B(0) => YorOcarry(0), B(1) => YorOcarry(1), B(2) => YorOcarry(2), B(3) => YorOcarry(3));

R <= rFlags;

end ALU_arq;
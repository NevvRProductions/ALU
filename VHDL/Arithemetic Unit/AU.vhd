library ieee;
use ieee.std_logic_1164.all;

entity AU is
	port (
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	CBi : in std_logic;
	OPau : in std_logic;
	R : out std_logic_vector (3 downto 0);
	OV : out std_logic;
	CBo : out std_logic
	);
end AU;

architecture AU_arq of AU is
component Add_Sub is
port (
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	Bm : out std_logic;
	Ci : in std_logic;
	OPau : in std_logic;
	S : out std_logic_vector (3 downto 0);
	Co : out std_logic
	);
end component;

component Flags is
port
	(
	A : in std_logic;
	B : in std_logic;
	iCBO : in std_logic;
	R : in std_logic;
	OV : out std_logic;
	CBO : out std_logic
	);
end component;

signal CBOin : std_logic;
signal RInt : std_logic;
signal BMInt : std_logic;

begin

U1 : Add_Sub port map (A(0) => A(0), A(1) => A(1), A(2) => A(2), A(3) => A(3), B(0) => B(0), B(1) => B(1), B(2) => B(2), B(3) => B(3), Bm => BMInt, Ci => CBi, OPau => OPau, S(0) => R(0), S(1) => R(1), S(2) => R(2), S(3) => RInt, Co => CBOin);
U2 : Flags port map (A => A(3), B => BMInt, iCBO => CBOin, R => RInt, OV => OV, CBO => CBo);

R(3) <= RInt;

end AU_arq;


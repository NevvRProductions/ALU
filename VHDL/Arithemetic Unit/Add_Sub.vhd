library ieee;
use ieee.std_logic_1164.all;

entity Add_Sub is
	port (
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	Bm : out std_logic;
	Ci : in std_logic;
	OPau : in std_logic;
	S : out std_logic_vector (3 downto 0);
	Co : out std_logic
	);
end Add_Sub;

architecture structural of Add_Sub is
component Adder is
port
	(
	A : in std_logic_vector(3 downto 0);
	B : in std_logic_vector(3 downto 0);
	Ci : in std_logic;
	S : out std_logic_vector(3 downto 0);
	Co : out std_logic
	);
end component;

signal BInt : std_logic_vector (3 downto 0);
signal OPCi : std_logic;
signal iCBO : std_logic;

begin

BInt(0) <= B(0) xor OPau;
BInt(1) <= B(1) xor OPau;
BInt(2) <= B(2) xor OPau;
BInt(3) <= B(3) xor OPau;

OPCi <= Ci xor OPau;

U1 : Adder port map (
							A(0) => A(0),
							A(1) => A(1),
							A(2) => A(2),
							A(3) => A(3),	
							B(0) => BInt(0),
							B(1) => BInt(1),
							B(2) => BInt(2),
							B(3) => BInt(3),
							Co => iCBO, 
							Ci => OPCi, 
							S(0) => S(0),
							S(1) => S(1),
							S(2) => S(2),
							S(3) => S(3)
							);
							
Bm <= BInt(3);

Co <= iCBO xor OPau;

end structural;


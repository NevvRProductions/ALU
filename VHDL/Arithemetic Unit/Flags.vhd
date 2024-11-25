library ieee;
use ieee.std_logic_1164.all;

entity Flags is
	port
	(
	A : in std_logic;
	B : in std_logic;
	iCBO : in std_logic;
	R : in std_logic;
	OV : out std_logic;
	CBO : out std_logic
	);
end Flags;

architecture Flags_arq of Flags is
begin

CBO <= iCBO;
OV <= (A and B and not R) or (not A and not B and R);

end Flags_arq;
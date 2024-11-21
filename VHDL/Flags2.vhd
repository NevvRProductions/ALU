library ieee;
use ieee.std_logic_1164.all;

entity Flags2 is
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
end Flags2;

architecture Flags2_arq of Flags2 is

signal Zero : std_logic;

begin

Zero <= not (R(0) or R(1) or R(2) or R(3));
GE <= (not R(3) and not iOV) or (R(3) and iOV);
BE <= iCB or Zero;
P <= R(0) XOR R(1) XOR R(2) XOR R(3);
Z <= Zero;
OVo <= iOV;
CBo <= (OP and CY) or (not OP and iCB);

end Flags2_arq;
library ieee;
use ieee.std_logic_1164.all;

entity HA is
	port (
	A : in std_logic;
	B : in std_logic;
	S : out std_logic;
	Co : out std_logic
	);
end HA;

architecture HA_arq of HA is
begin

S <= A xor B;
Co <= A and B;

end HA_arq;
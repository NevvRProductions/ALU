library ieee;
use ieee.std_logic_1164.all;

entity MUX4 is
	port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	Op : in std_logic;
	R : out std_logic_vector (3 downto 0)
	);
end MUX4;

architecture MUX4_arq of MUX4 is
begin

R(0) <= (not Op and A(0)) or (Op and B(0));
R(1) <= (not Op and A(1)) or (Op and B(1));
R(2) <= (not Op and A(2)) or (Op and B(2));
R(3) <= (not Op and A(3)) or (Op and B(3));

end MUX4_arq;
library ieee;
use ieee.std_logic_1164.all;

entity MUX41 is
	port(
	A : in std_logic;
	B : in std_logic;
	Op : in std_logic;
	R : out std_logic
	);
end MUX41;

architecture MUX41_arq of MUX41 is
begin

R <= (not Op and A) or (Op and B);

end MUX41_arq;
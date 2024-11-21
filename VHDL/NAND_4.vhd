library ieee;
use ieee.std_logic_1164.all;

entity NAND_4 is
	port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	
	R : out std_logic_vector (3 downto 0)
	);
end NAND_4;

architecture NAND_4_arq of NAND_4 is
begin
R <= not (A and B);
end NAND_4_arq;
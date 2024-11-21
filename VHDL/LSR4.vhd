library ieee;
use ieee.std_logic_1164.all;

entity LSR4 is
	port(
		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		R : out std_logic_vector (3 downto 0);
		CY : out std_logic
		);
end LSR4;


architecture LSR4_arq of LSR4 is	
begin
R <= '0' & A(3 downto 1);
CY <= A(0);
end LSR4_arq;
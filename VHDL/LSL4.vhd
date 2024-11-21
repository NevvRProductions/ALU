library ieee;
use ieee.std_logic_1164.all;

entity LSL4 is
	port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	
	R : out std_logic_vector (3 downto 0);
	CY : out std_logic
	);
end LSL4;

architecture LSL4_arq of LSL4 is
begin
R <= A(2 downto 0) & '0';
CY <= A(3);
end LSL4_arq;
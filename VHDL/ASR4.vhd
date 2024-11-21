library ieee;
use ieee.std_logic_1164.all;

entity ASR4 is
	port(
	A : in std_logic_vector (3 downto 0);
	B : in std_logic_vector (3 downto 0);
	R : out std_logic_vector (3 downto 0);
	CY : out std_logic
	);
end ASR4;

architecture ASR4_arq of ASR4 is
begin
R <= A(3) & A(3 downto 1);
CY <= A(0);
end ASR4_arq;
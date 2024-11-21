library ieee;
use ieee.std_logic_1164.all;

entity YorO is
port (
		Y : in std_logic_vector (3 downto 0);
		OPA : in std_logic;
		B : out std_logic_vector (3 downto 0)
		);
end YorO;

architecture YorO_arq of YorO is
begin

B(0) <= Y(0) and OPA;
B(1) <= Y(1) and OPA;
B(2) <= Y(2) and OPA;
B(3) <= Y(3) and OPA;

end YorO_arq;
library ieee;
use ieee.std_logic_1164.all;

entity Decoder is
	port (
		OP0, OP1, OP2 : in std_logic;
		OPA, OPB, OPC, OPD, OPE, OPF : out std_logic
		);
end Decoder;

architecture Decoder_arq of Decoder is
begin

OPA <= OP1;
OPB <= OP0;
OPC <= OP2;
OPD <= OP1;
OPE <= OP0;
OPF <= OP2;

end Decoder_arq;
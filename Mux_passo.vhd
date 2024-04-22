library ieee;
use ieee.std_logic_1164.all;

entity Mux_passo is
    port (clr: in  std_logic; -- clr > vai funcionar como uma key 
	Qpasso : in std_logic_vector(3 downto 0); -- > valor registrado
        Valor_passo : out std_logic_vector(3 downto 0)); -- > valor do passo 
end entity Mux_passo;


architecture log of Mux_passo is
begin

Valor_passo(3) <= (Qpasso(3) and clr) or ('0' and not clr);
Valor_passo(2) <= (Qpasso(2) and clr) or ('0' and not clr);
Valor_passo(1) <= (Qpasso(1) and clr) or ('0' and not clr);
Valor_passo(0) <= (Qpasso(0) and clr) or ('1' and not clr);

end architecture log;
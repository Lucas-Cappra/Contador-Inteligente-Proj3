library ieee;
use ieee.std_logic_1164.all;

entity Mux_mx is
    port (clr: in  std_logic; -- clr > vai funcionar como uma key 
	Qmx: in std_logic_vector(11 downto 0); -- > valor registrado
        Valor_mx : out std_logic_vector(11 downto 0)); -- > valor maximo ;
end entity Mux_mx;


architecture log of Mux_mx is
begin

Valor_mx(11) <= (Qmx(11) and clr) or ('1' and not clr);
Valor_mx(10) <= (Qmx(10) and clr) or ('0' and not clr);
Valor_mx(9) <= (Qmx(9) and clr) or ('0' and not clr);
Valor_mx(8) <= (Qmx(8) and clr) or ('1' and not clr);

Valor_mx(7) <= (Qmx(7) and clr) or ('1' and not clr);
Valor_mx(6) <= (Qmx(6) and clr) or ('0' and not clr);
Valor_mx(5) <= (Qmx(5) and clr) or ('0' and not clr);
Valor_mx(4) <= (Qmx(4) and clr) or ('1' and not clr);

Valor_mx(3) <= (Qmx(3) and clr) or ('1' and not clr);
Valor_mx(2) <= (Qmx(2) and clr) or ('0' and not clr);
Valor_mx(1) <= (Qmx(1) and clr) or ('0' and not clr);
Valor_mx(0) <= (Qmx(0) and clr) or ('1' and not clr);

end architecture log;

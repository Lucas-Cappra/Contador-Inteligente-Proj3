library ieee;
use ieee.std_logic_1164.all;

entity Reg_passo is
    port (step, load, clr: in  std_logic; --step> selecionar passo, load > carregar valores, clr > limpar 
	A0 : in std_logic_vector(3 downto 0); -- > valor
        Qpasso : out std_logic_vector(3 downto 0)); -- > valor registrado 
end entity Reg_passo;

architecture log of Reg_passo is
signal Q : std_logic_vector(3 downto 0) := (others => '0');
begin

Qpasso(3) <= not((not clr) or (not(((Q(3))or(((A0(3)) and ((load)and( step))))))));
Qpasso(2) <= not((not clr) or (not(((Q(2))or(((A0(2)) and ((load)and( step))))))));
Qpasso(1) <= not((not clr) or (not(((Q(1))or(((A0(1)) and ((load)and( step))))))));
Qpasso(0) <= not((not clr) or (not(((Q(0))or(((A0(0)) and ((load)and( step))))))));

end architecture log;
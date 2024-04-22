library ieee;
use ieee.std_logic_1164.all;

entity Reg_mi is
    port (mx_mi, load, clr: in  std_logic; --mx_mi> selecionar maximo e minimo, load > carregar valores, clr > limpar 
	A2,A1,A0 : in std_logic_vector(3 downto 0); -- > valores 
        Qmi : out std_logic_vector(11 downto 0) -- > valor registrado ;

	);end entity Reg_mi;

architecture log of Reg_mi is
signal Q : std_logic_vector(11 downto 0) := (others => '0');
begin

Qmi(11) <= not((not clr) or (not(((Q(11))or(((A2(3)) and ((load)and(not mx_mi))))))));
Qmi(10) <= not((not clr) or (not(((Q(10))or(((A2(2)) and ((load)and(not mx_mi))))))));
Qmi(9) <= not((not clr) or (not(((Q(9))or(((A2(1)) and ((load)and(not mx_mi))))))));
Qmi(8) <= not((not clr) or (not(((Q(8))or(((A2(0)) and ((load)and(not mx_mi))))))));


Qmi(7) <= not((not clr) or (not(((Q(7))or(((A1(3)) and ((load)and(not mx_mi))))))));
Qmi(6) <= not((not clr) or (not(((Q(6))or(((A1(2)) and ((load)and(not mx_mi))))))));
Qmi(5) <= not((not clr) or (not(((Q(5))or(((A1(1)) and ((load)and(not mx_mi))))))));
Qmi(4) <= not((not clr) or (not(((Q(4))or(((A1(0)) and ((load)and(not mx_mi))))))));


Qmi(3) <= not((not clr) or (not(((Q(3))or(((A0(3)) and ((load)and(not mx_mi))))))));
Qmi(2) <= not((not clr) or (not(((Q(2))or(((A0(2)) and ((load)and(not mx_mi))))))));
Qmi(1) <= not((not clr) or (not(((Q(1))or(((A0(1)) and ((load)and(not mx_mi))))))));
Qmi(0) <= not((not clr) or (not(((Q(0))or(((A0(0)) and ((load)and(not mx_mi))))))));

end architecture log;

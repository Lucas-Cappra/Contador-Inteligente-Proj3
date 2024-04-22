library ieee;
use ieee.std_logic_1164.all;

entity Valor_Mx is
    port (mx_mi, load, clr: in  std_logic; -- mx_mi> selecionar maximo e minimo, load > carregar valores, clr > limpar
	  A2,A1,A0 : in std_logic_vector(3 downto 0); -- > valores
          Valor_Mx : out std_logic_vector(11 downto 0)); -- > valor maximo 
end Valor_Mx;

architecture log of Valor_Mx is
component Reg_mx is
    port (mx_mi, load, clr: in  std_logic; 
	  A2,A1,A0 : in std_logic_vector(3 downto 0);
          Qmx : out std_logic_vector(11 downto 0)); -- > valor registrado 
end component;

component Mux_mx is
   port (clr: in  std_logic; -- clr > vai funcionar como uma key 
	 Qmx : in std_logic_vector(11 downto 0);
	 Valor_mx : out std_logic_vector(11 downto 0)); 
end component;

signal Qmx : std_logic_vector(11 downto 0);
begin
  U1: Reg_mx port map(mx_mi, load, clr,A2,A1,A0,Qmx);
  U2: Mux_mx port map(clr,Qmx,Valor_mx);
end log;
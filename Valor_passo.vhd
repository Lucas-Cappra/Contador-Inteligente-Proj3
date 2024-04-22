library ieee;
use ieee.std_logic_1164.all;

entity Valor_passo is
    port (step, load, clr: in  std_logic; -- step> selecionar passo, load > carregar valores, clr > limpar
	  A0 : in std_logic_vector(3 downto 0); -- > valor
          Valor_passo : out std_logic_vector(3 downto 0) -- > valor do passo ;
	);
end Valor_passo;

architecture log of Valor_passo is
component Reg_passo is
    port (step, load, clr: in  std_logic; 
	A0 : in std_logic_vector(3 downto 0);
        Qpasso : out std_logic_vector(3 downto 0)); -- > valor registrado ;
end component;

component Mux_passo is
   port (clr: in  std_logic; -- clr > vai funcionar como uma key 
	Qpasso : in std_logic_vector(3 downto 0); 
       Valor_passo : out std_logic_vector(3 downto 0)); 
end component;

signal Qpasso : std_logic_vector(3 downto 0);
begin
  U1: Reg_passo port map(step, load, clr,A0,Qpasso);
  U2: Mux_passo port map(clr,Qpasso,Valor_passo);
end log;

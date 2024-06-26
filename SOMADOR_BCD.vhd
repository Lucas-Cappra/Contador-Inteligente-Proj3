LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Somador_BCD IS
    PORT(
        A, B: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        CI: IN STD_LOGIC;
        S: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        CO: OUT STD_LOGIC
    );
END Somador_BCD;

ARCHITECTURE SOMA_BCD OF Somador_BCD IS
   	COMPONENT Somador_4Bits is
   	 Port(
   	     A_S4, B_S4: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
   	     CI_S4: IN STD_LOGIC;
   	     S_S4: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
   	     CO_S4: OUT STD_LOGIC
   	 );
	END COMPONENT;

	SIGNAL S_PARCIAL, S_CORR: STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
	SIGNAL COUT_PARCIAL, COUT_INUTIL, CORR: STD_LOGIC;
	
BEGIN

SOMA: Somador_4Bits PORT MAP(A, B, CI, S_PARCIAL, COUT_PARCIAL);

CORR <= (COUT_PARCIAL OR ( S_PARCIAL(3) AND (S_PARCIAL(2) OR S_PARCIAL(1)) ));
S_CORR(1) <= CORR;
S_CORR(2) <= CORR;

CORE: Somador_4Bits PORT MAP(S_PARCIAL, S_CORR, '0', S, COUT_INUTIL);

CO <= CORR;

END SOMA_BCD;
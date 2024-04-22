LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Somador_4Bits is
    Port(
        A_S4, B_S4: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        CI_S4: IN STD_LOGIC;
        S_S4: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        CO_S4: OUT STD_LOGIC
    );
END Somador_4Bits;

ARCHITECTURE Soma_4Bits OF Somador_4Bits is
    COMPONENT Somador_Completo is
        PORT(
        A_SC, B_SC, CI_SC: IN STD_LOGIC;
        S_SC, CO_SC: OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL CO_SSC: STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

S0: Somador_Completo PORT MAP(A_S4(0), B_S4(0),  CI_S4,     S_S4(0), CO_SSC(0));
S1: Somador_Completo PORT MAP(A_S4(1), B_S4(1),  CO_SSC(0), S_S4(1), CO_SSC(1));
S2: Somador_Completo PORT MAP(A_S4(2), B_S4(2),  CO_SSC(1), S_S4(2), CO_SSC(2));
S4: Somador_Completo PORT MAP(A_S4(3), B_S4(3),  CO_SSC(2), S_S4(3), CO_S4);

END Soma_4Bits;

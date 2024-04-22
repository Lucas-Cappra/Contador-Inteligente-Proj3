library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY MUX_4X1_4BITS IS
	PORT (
        A, B : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        C    : in  STD_LOGIC;
        Y    : out STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

END MUX_4X1_4BITS;

ARCHITECTURE MUX_4X1_4BITS OF MUX_4X1_4BITS IS

COMPONENT mux_2x1 IS
    Port (
        A, B : in  STD_LOGIC;
        C    : in  STD_LOGIC;
        Y    : out STD_LOGIC
    );
END COMPONENT;

BEGIN

S3 : mux_2x1 PORT MAP (A(3), B(3), C, Y(3));
S2 : mux_2x1 PORT MAP (A(2), B(2), C, Y(2));
S1 : mux_2x1 PORT MAP (A(1), B(1), C, Y(1));
S0 : mux_2x1 PORT MAP (A(0), B(0), C, Y(0));


END ARCHITECTURE;

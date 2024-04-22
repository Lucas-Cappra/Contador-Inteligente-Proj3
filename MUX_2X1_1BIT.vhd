library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2x1 is
    Port (
        A, B : in  STD_LOGIC;
        C    : in  STD_LOGIC;
        Y    : out STD_LOGIC
    );
end mux_2x1;

architecture MUX_21 of mux_2x1 is
begin
    Y <= (not C and A) or (C and B);
end MUX_21;

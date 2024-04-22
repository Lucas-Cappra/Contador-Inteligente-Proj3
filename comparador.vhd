
library ieee;
use ieee.std_logic_1164.all;


entity comparador_magnitude is

  port (
	a3 : in std_logic;
	a2 : in std_logic;
	a1 : in std_logic;
	a0 : in std_logic;

	b3 : in std_logic;
	b2 : in std_logic;
	b1 : in std_logic;
	b0 : in std_logic;

	OAgtB : out std_logic;
	OAeqB : out std_logic;
	OAltB : out std_logic
    
    );

end comparador_magnitude;

architecture logica of comparador_magnitude is

  signal AgtbN : std_logic:= '0'; -- A greather than B (maior que)
  signal AeqbN : std_logic:= '0'; -- A equal than B (igual que)
  signal AltbN : std_logic:= '0'; -- A lower than B (menor que)

begin

  AgtbN <= (a3 and not(b3)) or
          (not(a3 xor b3) and a2 and not(b2)) or
          (not(a3 xor b3) and not(a2 xor b2) and a1 and not(b1)) or
          (not(a3 xor b3) and not(a2 xor b2) and not(a1 xor b1) and a0 and not(b0));

  	AeqbN <= not((a3 xor b3) or (a2 xor b2) or (a1 xor b1) or (a0 xor b0));
  	AltbN <= not(AgtbN or AeqbN);

	OAGTB <= AgtbN or (AeqbN and (not(AeqbN) and not(AltbN)));
  	OALTB <= AltbN or (AeqbN and (not(AeqbN) and not(AgtbN)));
  	OAEQB <= AeqbN and AeqbN;

  
end logica;

    
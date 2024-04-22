LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registradorgeral IS 
   PORT ( 
          --Entrada valores
          DU : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
          DD : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
          DC : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
          clr, ck: IN STD_LOGIC ;
          
          --Saida valores
          QU : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          QD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          QC : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

          --Saida comparadores
          COMPAgtB : OUT STD_LOGIC ;
	        COMPAeqB : OUT STD_LOGIC ;
	        COMPAltB : OUT STD_LOGIC ;

          --Saida Valor Passo
          valordopasso : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

          --Saida Registrador Mínimo
          valorregminU : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          valorregminD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          valorregminC : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

          --Saida Registrador Máximo
          valorregmaxU : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          valorregmaxD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          valorregmaxC : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)

		
        );
          
END registradorgeral;

  ARCHITECTURE flipflopdes OF registradorgeral IS
COMPONENT ffd IS
	PORT(
        ck, clr, set, d : in  std_logic;
                      q : out std_logic
		);
	END COMPONENT;	


COMPONENT ck_div IS
	port (ck_in : in  std_logic;
         ck_out: out std_logic);
	END COMPONENT;	
	
COMPONENT SOMADOR_BCD_12 IS
	PORT(
	 A_BCD_U, B_BCD_STEP: IN STD_LOGIC_VECTOR(3 DOWNTO 0); --A É O NUMEROMAX/MIN B VAI SER O STE
	 A_BCD_D, B_BCD_D: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	 A_BCD_C, B_BCD_C: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	 CI_BCD: IN STD_LOGIC;
	 CO_BCD: OUT STD_LOGIC;
	 S_BCD_U: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 S_BCD_D: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 S_BCD_C: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
	END COMPONENT;	
	
COMPONENT SUBTRATOR_COMPLETO_12Bits IS
    PORT(
        A_U, BCD_STEP: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- A É O NUMEROMAX/MIN B VAI SER O STE
        A_D: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        A_C: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	      CO_D: OUT STD_LOGIC;
        S_U: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        S_D: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        S_C: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
	END COMPONENT;


COMPONENT comparador_magnitude IS
 
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

	END COMPONENT;


COMPONENT Reg_mi IS
   port (mx_mi, load, clr: in  std_logic; --mx_mi> selecionar maximo e minimo, load > carregar valores, clr > limpar 
	A2,A1,A0 : in std_logic_vector(3 downto 0); -- > valores 
        Qmi : out std_logic_vector(11 downto 0) -- > valor registrado ;
	);
	END COMPONENT;

COMPONENT Valor_passo IS
     port (step, load, clr: in  std_logic; -- step> selecionar passo, load > carregar valores, clr > limpar
	  A0 : in std_logic_vector(3 downto 0); -- > valor
          Valor_passo : out std_logic_vector(3 downto 0) -- > valor do passo ;
	);
	END COMPONENT;

COMPONENT Reg_mx IS
    port (mx_mi, load, clr: in  std_logic; --mx_mi> selecionar maximo e minimo, load > carregar valores, clr > limpar 
	A2,A1,A0 : in std_logic_vector(3 downto 0); -- > valores 
        Qmx : out std_logic_vector(11 downto 0)-- > valor registrado 
	); 
	END COMPONENT;


-- Sinais para portmap Valor_Passo
    SIGNAL valorpasso: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others => '0'); 	

-- Sinais para portmap Reg_Minimo
    SIGNAL OQmi: STD_LOGIC_VECTOR(11 DOWNTO 0):=(others => '0'); 	

-- Sinais para portmap Reg_Maximo
    SIGNAL OQmx: STD_LOGIC_VECTOR(11 DOWNTO 0):=(others => '0'); 	

    SIGNAL mxmi, ld: STD_LOGIC := '0'; 	
    SIGNAL Ax, Ay, Az: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others => '0'); 

-- Sinais para portmap comparador
    SIGNAL CA, CB: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others => '0'); 
    SIGNAL AGTB, AEQB, ALTB: STD_LOGIC := '0';					

-- Sinais para portmap somador
    SIGNAL S_BCDU, S_BCDD, S_BCDC: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others => '0'); 

-- Sinais para portmap subtrator
    SIGNAL SUB_BCDU, SUB_BCDD, SUB_BCDC: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others => '0'); 

-- Sinais para portmap Flip Flop D
    SIGNAL A_BCDU, A_BCDD, A_BCDC: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others => '0');
    SIGNAL B_BCDSTEP, B_BCDD, B_BCDC: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others => '0');    
    SIGNAL CIBCD, COBCD, set: STD_LOGIC := '0';



BEGIN

somadorbcd: SOMADOR_BCD_12 PORT MAP( A_BCDU , B_BCDSTEP , A_BCDD , B_BCDD , A_BCDC , B_BCDC , CIBCD , COBCD , S_BCDU , S_BCDD ,S_BCDC);

subtratorbcd: SUBTRATOR_COMPLETO_12Bits PORT MAP( A_BCDU , B_BCDSTEP , A_BCDD  , A_BCDC , COBCD , SUB_BCDU , SUB_BCDD ,SUB_BCDC);

comparador: comparador_magnitude PORT MAP( CA(0), CA(1), CA(2), CA(3), CB(0), CB(1), CB(2), CB(3), AGTB, AEQB, ALTB);

regmin: Reg_mi PORT MAP( mxmi, ld, clr, Ax, Ay, Az, OQmi);

regmax: Reg_mx PORT MAP( mxmi, ld, clr, Ax, Ay, Az, OQmx);

valpasso: Valor_passo PORT MAP( Ax(0), ld, clr, Ax, valorpasso);


--Flip Flops de Somador/Subtrator

flipdU0: ffd PORT MAP(ck, clr, set, S_BCDU(0), QU(0));
flipdU1: ffd PORT MAP(ck, clr, set, S_BCDU(1), QU(1));
flipdU2: ffd PORT MAP(ck, clr, set, S_BCDU(2), QU(2)); -- Unidades
flipdU3: ffd PORT MAP(ck, clr, set, S_BCDU(3), QU(3));
  
flipdD0: ffd PORT MAP(ck, clr, set, S_BCDD(0), QD(0));
flipdD1: ffd PORT MAP(ck, clr, set, S_BCDD(1), QD(1));
flipdD2: ffd PORT MAP(ck, clr, set, S_BCDD(2), QD(2)); -- Dezenas
flipdD3: ffd PORT MAP(ck, clr, set, S_BCDD(3), QD(3));
  
flipdC0: ffd PORT MAP(ck, clr, set, S_BCDC(0), QC(0));
flipdC1: ffd PORT MAP(ck, clr, set, S_BCDC(1), QC(1));
flipdC2: ffd PORT MAP(ck, clr, set, S_BCDC(2), QC(2)); -- Centenas
flipdC3: ffd PORT MAP(ck, clr, set, S_BCDC(3), QC(3));


-- Flip Flop para Comparador
flipdAgtB: ffd PORT MAP(ck, clr, set, AGTB, COMPAgtB); -- A maior que B
flipdAeqB: ffd PORT MAP(ck, clr, set, AEQB, COMPAeqB); -- A iqual que B
flipdAltB: ffd PORT MAP(ck, clr, set, ALTB, COMPAltB); -- A menor que B


-- Flip Flop para Valor_Passo
flipdPasso0: ffd PORT MAP(ck, clr, set, valorpasso(0), valordopasso(0));
flipdPasso1: ffd PORT MAP(ck, clr, set, valorpasso(1), valordopasso(1));
flipdPasso2: ffd PORT MAP(ck, clr, set, valorpasso(2), valordopasso(2));
flipdPasso3: ffd PORT MAP(ck, clr, '1', valorpasso(3), valordopasso(3));

-- Flip Flop para Reg_Minimo
regminimo0: ffd PORT MAP(ck, clr, set, OQmi(0), valorregminU(0));
regminimo1: ffd PORT MAP(ck, clr, set, OQmi(1), valorregminU(1));
regminimo2: ffd PORT MAP(ck, clr, set, OQmi(2), valorregminU(2)); -- Unidades
regminimo3: ffd PORT MAP(ck, clr, set, OQmi(3), valorregminU(3));

regminimo4: ffd PORT MAP(ck, clr, set, OQmi(4), valorregminD(0));
regminimo5: ffd PORT MAP(ck, clr, set, OQmi(5), valorregminD(1));
regminimo6: ffd PORT MAP(ck, clr, set, OQmi(6), valorregminD(2)); -- Dezenas
regminimo7: ffd PORT MAP(ck, clr, set, OQmi(7), valorregminD(3));

regminimo8: ffd PORT MAP(ck, clr, set, OQmi(8), valorregminC(0));
regminimo9: ffd PORT MAP(ck, clr, set, OQmi(9), valorregminC(1));
regminimo10: ffd PORT MAP(ck, clr, set, OQmi(10), valorregminC(2)); -- Centenas
regminimo11: ffd PORT MAP(ck, clr, set, OQmi(11), valorregminC(3));

-- Flip Flop para Reg_Maximo
regmaximo0: ffd PORT MAP(ck, clr, set, OQmx(0), valorregmaxU(0));
regmaximo1: ffd PORT MAP(ck, clr, set, OQmx(1), valorregmaxU(1));
regmaximo2: ffd PORT MAP(ck, clr, set, OQmx(2), valorregmaxU(2)); -- Unidades
regmaximo3: ffd PORT MAP(ck, clr, set, OQmx(3), valorregmaxU(3));
  
regmaximo4: ffd PORT MAP(ck, clr, set, OQmx(4), valorregmaxD(0));
regmaximo5: ffd PORT MAP(ck, clr, set, OQmx(5), valorregmaxD(1));
regmaximo6: ffd PORT MAP(ck, clr, set, OQmx(6), valorregmaxD(2)); -- Dezenas
regmaximo7: ffd PORT MAP(ck, clr, set, OQmx(7), valorregmaxD(3));
  
regmaximo8: ffd PORT MAP(ck, clr, set, OQmx(8), valorregmaxC(0));
regmaximo9: ffd PORT MAP(ck, clr, set, OQmx(9), valorregmaxC(1));
regmaximo10: ffd PORT MAP(ck, clr, set, OQmx(10), valorregmaxC(2)); -- Centenas
regmaximo11: ffd PORT MAP(ck, clr, set, OQmx(11), valorregmaxC(3));




end architecture flipflopdes;


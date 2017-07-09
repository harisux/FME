LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.libreria.ALL;

entity filtro_v is 

PORT(A0	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A7 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B0	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  B7 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C0	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  C7 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  CLK	: IN STD_LOGIC;
	  RST : IN STD_LOGIC;
	  SEL1: IN STD_LOGIC;
	  SEL2: IN STD_LOGIC;
	  O01	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O02	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O03	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O11	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O12	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O13	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O21	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O22 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end filtro_v;
--------------------------------------------------
--O01: 1/2 A
--O02: 1/4 A
--O03: 3/4 A

--O11: 1/2 B
--O12: 1/4 B
--O13: 3/4 B

--O21: 1/4 CENTRAL
--O22: 3/4 CENTRAL
--------------------------------------------------

architecture arq of filtro_v is

begin

-------------------------------------------------------------------------------------------------------------
--Columna 1/4H
-------------------------------------------------------------------------------------------------------------
U0: fir_8 PORT MAP(A0=>A0,A1=>A1,A2=>A2,A3=>A3,A4=>A4,A5=>A5,A6=>A6,A7=>A7,CLK=>CLK,RST=>RST,EN=>SEL1,O=>O01);
--U1: fir_7 PORT MAP(A0=>A0,A1=>A1,A2=>A2,A3=>A3,A4=>A4,A5=>A5,A6=>A6,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O02);
--U2: fir_7 PORT MAP(A0=>A7,A1=>A6,A2=>A5,A3=>A4,A4=>A3,A5=>A2,A6=>A1,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O03);
U1: fir_7 PORT MAP(A0=>A7,A1=>A6,A2=>A5,A3=>A4,A4=>A3,A5=>A2,A6=>A1,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O02);
U2: fir_7 PORT MAP(A0=>A0,A1=>A1,A2=>A2,A3=>A3,A4=>A4,A5=>A5,A6=>A6,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O03);
-------------------------------------------------------------------------------------------------------------
--Colummna 3/4H
-------------------------------------------------------------------------------------------------------------
U3: fir_8 PORT MAP(A0=>B0,A1=>B1,A2=>B2,A3=>B3,A4=>B4,A5=>B5,A6=>B6,A7=>B7,CLK=>CLK,RST=>RST,EN=>SEL1,O=>O11);
--U4: fir_7 PORT MAP(A0=>B0,A1=>B1,A2=>B2,A3=>B3,A4=>B4,A5=>B5,A6=>B6,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O12);
--U5: fir_7 PORT MAP(A0=>B7,A1=>B6,A2=>B5,A3=>B4,A4=>B3,A5=>B2,A6=>B1,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O13);
U4: fir_7 PORT MAP(A0=>B7,A1=>B6,A2=>B5,A3=>B4,A4=>B3,A5=>B2,A6=>B1,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O12);
U5: fir_7 PORT MAP(A0=>B0,A1=>B1,A2=>B2,A3=>B3,A4=>B4,A5=>B5,A6=>B6,CLK=>CLK,EN=>SEL2,RST=>RST,O=>O13);

-------------------------------------------------------------------------------------------------------------
--Columna central
-------------------------------------------------------------------------------------------------------------
--U6: fir_7 PORT MAP(C0,C1,C2,C3,C4,C5,C6,CLK,SEL2,RST,O21);
--U7: fir_7 PORT MAP(C7,C6,C5,C4,C3,C2,C1,CLK,SEL2,RST,O22);
U6: fir_7 PORT MAP(C7,C6,C5,C4,C3,C2,C1,CLK,SEL2,RST,O21);
U7: fir_7 PORT MAP(C0,C1,C2,C3,C4,C5,C6,CLK,SEL2,RST,O22);

end arq;

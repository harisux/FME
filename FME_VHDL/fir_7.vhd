LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fir_7 IS
PORT(A0		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A1		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A2 		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A3 	 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A4 		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A5 		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A6 		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  CLK		: IN STD_LOGIC;
	  EN		: IN STD_LOGIC;
	  RST		: IN STD_LOGIC;
	  O		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END fir_7;

ARCHITECTURE arq of fir_7 is

SIGNAL E00: SIGNED(8 DOWNTO 0);
SIGNAL E01: STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL E02: STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL E03: SIGNED(8 DOWNTO 0);
SIGNAL E04: SIGNED(8 DOWNTO 0);
SIGNAL E05: STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL E06: SIGNED(8 DOWNTO 0);
SIGNAL E10: SIGNED(9 DOWNTO 0);
SIGNAL E11: SIGNED(12 DOWNTO 0);
SIGNAL E12: SIGNED(9 DOWNTO 0);
SIGNAL E13: SIGNED(14 DOWNTO 0);
SIGNAL E20: SIGNED(13 DOWNTO 0);
SIGNAL E21: SIGNED(15 DOWNTO 0);
SIGNAL E30: SIGNED(16 DOWNTO 0);
SIGNAL E31: SIGNED(9 DOWNTO 0);
SIGNAL R00: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL R01: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL R02: STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL R03: STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL R04: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL R05: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL R06: STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL R07: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL R10: STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL R11: STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL R12: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL R13: STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL R20: STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL R21: STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN

--PRIMERA ETAPA FILTRO

E00 <= SIGNED('0'&A1)-SIGNED('0'&A3);
E01 <= (A4&"0000");
E02 <= (A2&"000");
E03 <= SIGNED('0'&A4)-SIGNED('0'&A5);
E04 <= SIGNED('0'&A6)-SIGNED('0'&A0);
E05 <= (A3&"000000");
E06 <= SIGNED('0'&A2)+SIGNED('0'&A3);


--SEGUNDA ETAPA DEL FILTRO

E10 <= SIGNED(R00(8)&R00)-SIGNED('0'&R01);
E11 <= SIGNED('0'&R02)-SIGNED('0'&R03);
E12 <= SIGNED(R04(8)&R04)+SIGNED(R05(8)&R05);
E13 <= SIGNED('0'&R06)-SIGNED('0'&R07);

--TECERA ETAPA DEL FILTRO

E20 <= SIGNED(R10(11)&R10)+SIGNED(R11(12)&R11);
E21 <= SIGNED(R12(9)&R12)+SIGNED(R13(14)&R13);

--CUARTA ETAPA DEL FILTRO

E30 <= SIGNED(R20(13)&R20)+SIGNED(R21(15)&R21);
E31 <= E30(15 DOWNTO 6);

--REDONDEAR 
O <= (OTHERS => '1') WHEN (E31 > 255) ELSE
	 (OTHERS => '0') WHEN (E31 < 0)  ELSE
	 STD_LOGIC_VECTOR(E31(7 DOWNTO 0));

PROCESS(RST,CLK)
BEGIN
	IF(RST='0') THEN
		R00 <= (OTHERS =>'0');
		R01 <= (OTHERS =>'0');
		R02 <= (OTHERS =>'0');
		R03 <= (OTHERS =>'0');
		R04 <= (OTHERS =>'0');
		R05 <= (OTHERS =>'0');
		R06 <= (OTHERS =>'0');
		R07 <= (OTHERS =>'0');
		-----------
		R10 <= (OTHERS =>'0');
		R11 <= (OTHERS =>'0');
		R12 <= (OTHERS =>'0');
		R13 <= (OTHERS =>'0');
		-----------
		R20 <= (OTHERS =>'0');
		R21 <= (OTHERS =>'0');
	
	ELSIF(RISING_EDGE(CLK)) THEN
		IF(EN='1') THEN
		
			R00 <= STD_LOGIC_VECTOR(E00);
			R01 <= A5;
			R02 <= E01;
			R03 <= E02;
			R04 <= STD_LOGIC_VECTOR(E03);
			R05 <= STD_LOGIC_VECTOR(E04);
			R06 <= E05;
			R07 <= (STD_LOGIC_VECTOR(E06)&'0');
			-----------
			R10 <= (STD_LOGIC_VECTOR(E10)&"00");
			R11 <= STD_LOGIC_VECTOR(E11);
			R12 <= STD_LOGIC_VECTOR(E12);
			R13 <= STD_LOGIC_VECTOR(E13);
			-----------
			R20 <= STD_LOGIC_VECTOR(E20);
			R21 <= STD_LOGIC_VECTOR(E21);
		END IF;
	END IF;
	
END PROCESS;

END arq;
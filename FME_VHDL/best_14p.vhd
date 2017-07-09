LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.tipos_de_datos.all;
use work.libreria.all;
----------------------------------------------------------------------------------------------
--REUNE A LOS BLOQUES ENCARGADOS DE REALIZAR EL SAD PARA LA INTERPOLACION DE 1/4 PIXEL Y ENTREGA COMO RESPUESTA
--EL VECTOR DE MOVIMIENTO 1/4 CORRESPONDIENTE
----------------------------------------------------------------------------------------------
entity best_14p is
port(	o			:	in matriz(0 to 3, 0 to 8);
		ova		:	in matriz(0 to 2, 0 to 8);
		ovb		:	in matriz(0 to 2, 0 to 8);
		ovc		:  in matriz(0 to 1, 0 to 8);
		fila_act1:	in linea (0 to 7);
		fila_act2:	in linea	(0 to 7);
		fila_act3:  in linea (0 to 7);
		clk		:	in std_logic;
		rst		:  in std_logic;
		cont		:  in std_logic_vector(5 downto 0);
		mv_12		:  in std_logic_vector(3 downto 0);
		as_12		:	in std_logic_vector(13 downto 0);
		mv_14		:	out std_logic_vector(3 downto 0);
		as_14		:	out std_logic_vector(13 downto 0)
		);
end best_14p;

architecture arq of best_14p is

signal o_aux:	matriz(0 to 3, 0 to 8);
signal ova_aux: matriz(0 to 2, 0 to 8);
signal ovb_aux: matriz(0 to 2, 0 to 8);
signal ovc_aux: matriz(0 to 1, 0 to 8); 

signal sad141: linea(0 to 7);
signal sad142: linea(0 to 7);
signal sad143: linea(0 to 7);
signal sad144: linea(0 to 7);
signal sad145: linea(0 to 7);
signal sad146: linea(0 to 7);
signal sad147: linea(0 to 7);
signal sad148: linea(0 to 7);
signal sad149: linea(0 to 7);
signal sad1410: linea(0 to 7);

signal sad141_aux: linea(0 to 7);
signal sad142_aux: linea(0 to 7);
signal sad143_aux: linea(0 to 7);
signal sad144_aux: linea(0 to 7);
signal sad145_aux: linea(0 to 7);
signal sad146_aux: linea(0 to 7);
signal sad147_aux: linea(0 to 7);
signal sad148_aux: linea(0 to 7);
signal sad149_aux: linea(0 to 7);
signal sad1410_aux: linea(0 to 7);

signal s14o1: std_logic_vector(10 downto 0);
signal s14o2: std_logic_vector(10 downto 0);
signal s14o3: std_logic_vector(10 downto 0);
signal s14o4: std_logic_vector(10 downto 0);
signal s14o5: std_logic_vector(10 downto 0);
signal s14o6: std_logic_vector(10 downto 0);
signal s14o7: std_logic_vector(10 downto 0);
signal s14o8: std_logic_vector(10 downto 0);
signal s14o9: std_logic_vector(10 downto 0);
signal s14o10: std_logic_vector(10 downto 0);

signal as14o: linea_sad1(0 to 7);
signal ash14: linea_sad1(0 to 1);
signal as12a: std_logic_vector(13 downto 0);
signal as12b: std_logic_vector(13 downto 0);

signal s1412a: std_logic_vector(13 downto 0);
signal s1412b: std_logic_vector(13 downto 0);
signal s1414h: std_logic_vector(13 downto 0);
signal s1434h: std_logic_vector(13 downto 0);

signal ctr_sad: std_logic_vector(10 downto 0);
signal ctr_asad: std_logic_vector(4 downto 0);
signal fila_acth: linea (0 to 7);

signal mv_14aux: std_logic_vector(3 downto 0);
signal asaux: std_logic_vector(13 downto 0);

signal sel_h1: std_logic;

----------------------------------------------------------------------------------------------
--so1: -X 		-- "0011"
--so2: +X		-- "0001"
--so3: +Y		-- "1100"
--so4: -Y		-- "0100"
--so5: -X +Y	-- "1101"
--so6: +X +Y	-- "0101"
--so7: -X -Y	-- "1111"
--so8: +X -Y	-- "0111"
--------------------------------------------------
--O01: 1/2 A - ova
--O02: 1/4 A - ova
--O03: 3/4 A - ova

--O11: 1/2 B - ovb
--O12: 1/4 B - ovb
--O13: 3/4 B - ovb

--O21: 1/4 CENTRAL - ovc
--O22: 3/4 CENTRAL - ovc
--------------------------------------------------

--Nueva version de mv
--so1: -X: 	  "0011"
--so2: +X: 	  "0001"
--so3: +Y: 	  "0100"
--so4: -Y:    "1100"
--so5: -X +Y: "0111"
--so6: +X +Y: "0101"
--so7: -X -Y: "1111"
--so8: +X -Y: "1101"

begin

U0: process(clk,rst)
begin
	if(rst='0')then
	o_aux <= (OTHERS => (OTHERS => (OTHERS => '0')));
	ova_aux <= (OTHERS => (OTHERS => (OTHERS => '0')));
	ovb_aux <= (OTHERS => (OTHERS => (OTHERS => '0'))); 
	ovc_aux <= (OTHERS => (OTHERS => (OTHERS => '0')));
	sad141  <=(others=>(others=>'0'));
	sad142  <=(others=>(others=>'0'));
	sad143  <=(others=>(others=>'0'));
	sad144  <=(others=>(others=>'0'));
	sad145  <=(others=>(others=>'0'));
	sad146  <=(others=>(others=>'0'));
	sad147  <=(others=>(others=>'0'));
	sad148  <=(others=>(others=>'0'));
	sad149  <=(others=>(others=>'0'));
	sad1410  <=(others=>(others=>'0'));
	
	elsif(rising_edge(clk)) then
		o_aux<=o;
		ova_aux<=ova;
		ovb_aux<=ovb;
		ovc_aux<=ovc;
		sad141<=sad141_aux;
		sad142<=sad142_aux;
		sad143<=sad143_aux;
		sad144<=sad144_aux;
		sad145<=sad145_aux;
		sad146<=sad146_aux;
		sad147<=sad147_aux;
		sad148<=sad148_aux;
		sad149<=sad149_aux;
		sad1410<=sad1410_aux;
	end if;
end process;	

--Interpolación 1/4 pixel
J1: for i in 0 to 7 generate
	sad141_aux(i)<=ova_aux(1,i) when (mv_12(1)='1' and mv_12(0)='1')else ova_aux(1,i+1);
	end generate;
	
J2: for i in 0 to 7 generate
	sad142_aux(i)<=ova_aux(0,i) when (mv_12(1)='1' and mv_12(0)='1')else ova_aux(0,i+1);
	end generate;
	
J3: for i in 0 to 7 generate
	sad143_aux(i)<=ova_aux(2,i) when (mv_12(1)='1' and mv_12(0)='1')else ova_aux(2,i+1);
	end generate;
	
J4: for i in 0 to 7 generate
	--sad144(i)<=ovb(1,i) when ((mv_12="1101") or (mv_12="1111") or (mv_12="0011") or (mv_12="1100") or (mv_12="0100") or (mv_12="0000"))else ovb(1,i+1);
	sad144_aux(i)<=ovb_aux(1,i+1) when (mv_12(1)='0' and mv_12(0)='1')else ovb_aux(1,i);     
	end generate;
	
J5: for i in 0 to 7 generate
	sad145_aux(i)<=ovb_aux(0,i+1) when (mv_12(1)='0' and mv_12(0)='1')else ovb_aux(0,i);
	end generate;
	
J6: for i in 0 to 7 generate
	sad146_aux(i)<=ovb_aux(2,i+1) when (mv_12(1)='0' and mv_12(0)='1')else ovb_aux(2,i);
	end generate;
	
J7: for i in 0 to 7 generate
	sad147_aux(i)<=ovc_aux(0,i) when (mv_12(1)='1' and mv_12(0)='1')else ovc_aux(0,i+1);
	end generate;
	
J8: for i in 0 to 7 generate
	sad148_aux(i)<=ovc_aux(1,i) when (mv_12(1)='1' and mv_12(0)='1')else ovc_aux(1,i+1);
	end generate;
--
J9: for i in 0 to 7 generate
	sad149_aux(i)<=o_aux(1,i) when (mv_12="0011") else o_aux(1,i+1);
	end generate;

--sel_h1<= (not(mv_12(3))) and (not(mv_12(2)) and (mv_12(1)));	

J10: for i in 0 to 7 generate
	sad1410_aux(i)<=o_aux(2,i) when ((mv_12="0011") or (mv_12="0000")) else o_aux(2,i+1);
	end generate;	
	
C1: control_sad_14 port map(clk,rst,mv_12,cont,ctr_sad);
	
U1: sad_14pd port map(fila_act3,sad141,ctr_asad(4),clk,ctr_sad(0),ctr_sad(8),s14o1); 
U2: sad port map(fila_act3,sad142,ctr_asad(4),clk,ctr_sad(1),s14o2); 
U3: sad port map(fila_act3,sad143,ctr_asad(4),clk,ctr_sad(2),s14o3);
U4: sad_14pd port map(fila_act3,sad144,ctr_asad(4),clk,ctr_sad(3),ctr_sad(8),s14o4);
U5: sad port map(fila_act3,sad145,ctr_asad(4),clk,ctr_sad(4),s14o5);
U6: sad port map(fila_act3,sad146,ctr_asad(4),clk,ctr_sad(5),s14o6);
U7: sad_14pd port map(fila_act3,sad147,ctr_asad(4),clk,ctr_sad(6),ctr_sad(8),s14o7);
U8: sad port map(fila_act3,sad148,ctr_asad(4),clk,ctr_sad(7),s14o8);

fila_acth<=fila_act1 when (cont<=39) else fila_act2;

U9: sad port map(fila_acth,sad149,rst,clk,ctr_sad(9),s14o9);
U10: sad port map(fila_acth,sad1410,rst,clk,ctr_sad(10),s14o10);


C2: control_asad_14 port map(clk,rst,mv_12,cont,ctr_asad);
H1: acumulador_s port map(s14o1,ctr_asad(1),ctr_asad(4),clk,as14o(0));
--H2: acumulador_s port map(s14o2,ctr_asad(2),rst,clk,as14o(1));
H2: acumulador_s port map(s14o2,ctr_asad(2),ctr_asad(4),clk,as12a);
H3: acumulador_s port map(s14o3,ctr_asad(3),ctr_asad(4),clk,as14o(2));
H4: acumulador_s port map(s14o4,ctr_asad(1),ctr_asad(4),clk,as14o(3));
--H5: acumulador_s port map(s14o5,ctr_asad(2),rst,clk,as14o(4));
H5: acumulador_s port map(s14o5,ctr_asad(2),ctr_asad(4),clk,as12b);
H6: acumulador_s port map(s14o6,ctr_asad(3),ctr_asad(4),clk,as14o(5));
H7: acumulador_s port map(s14o7,ctr_asad(1),ctr_asad(4),clk,as14o(6));
H8: acumulador_s port map(s14o8,ctr_asad(3),ctr_asad(4),clk,as14o(7));


H9: acumulador_s port map(s14o9,ctr_asad(0),ctr_asad(4),clk,ash14(0));
H10: acumulador_s port map(s14o10,ctr_asad(0),ctr_asad(4),clk,ash14(1));

as14o(1) <= ash14(0) when ((mv_12="0011") or (mv_12="0001") or (mv_12="0000")) else as12a;
as14o(4) <= ash14(1) when ((mv_12="0011") or (mv_12="0001") or (mv_12="0000")) else as12b; 

U11: mv_1_2 port map("0011","0001","1100","0100","1101","0101","1111","0111",as14o,mv_14aux,asaux);
U12: des_1_2 port map(as_12,asaux,mv_12,mv_14aux,mv_14,as_14);

end arq;

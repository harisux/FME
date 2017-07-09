LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.tipos_de_datos.all;
use work.libreria.all;
----------------------------------------------------------------------------------------------
--REUNE A LOS BLOQUES ENCARGADOS DE REALIZAR EL SAD PARA LA INTERPOLACION DE 1/2 PIXEL Y ENTREGA COMO RESPUESTA
--EL VECTOR DE MOVIMIENTO 1/2 CORRESPONDIENTE
----------------------------------------------------------------------------------------------

entity best_12p is
port(cont		:	in std_logic_vector(5 downto 0);
		o			:	in matriz(0 to 3, 0 to 8);
		ova		:	in matriz(0 to 2, 0 to 8);
		ovb		:	in matriz(0 to 2, 0 to 8);
		clk		:	in std_logic;
		rst		:	in std_logic;
		aim		:	in std_logic_vector(13 downto 0);
		fila_act1:	in linea (0 to 7);
		fila_act2:	in linea	(0 to 7);
		fila_act3:	in linea	(0 to 7);
		fila_in	:  in linea (0 to 15);
		mv_12		:	out std_logic_vector(3 downto 0);
		as_12		: out std_logic_vector(13 downto 0));
end best_12p;

architecture arq of best_12p is

signal f_sad: linea(0 to 7);
signal ctr_sad: std_logic_vector(5 downto 0);
signal ctr_asad: std_logic_vector(4 downto 0);
signal so	: linea_sad(0 to 7);--SALIDA DE CADA BLOQUE SAD
signal aso	: linea_sad1(0 to 7);--SALIDA DE LOS BLOQUES ACUMULADORES DE SAD
signal sadh1: linea(0 to 7);
signal sadh2: linea(0 to 7);
signal sadd1: linea(0 to 7);
signal sadd2: linea(0 to 7);
signal sadv	: linea(0 to 7);
signal mv_12aux: std_logic_vector(3 downto 0);
signal asaux: std_logic_vector(13 downto 0);

begin

--SE TOMA LA DECISION ENTRE CUAL DE LOS 2 BUFFERS ENTRA A LOS PRIMEROS SADS. ESTO SE REALIZO PARA
--EVITAR PERDER CICLOS DE RELOJ.
f_sad<=fila_act1 when ((cont>=7) and (cont<=11)) else fila_act2;


C1: control_sad_12 port map(clk,rst,cont,ctr_sad);
C2: control_asad_12 port map(clk,rst,cont,ctr_asad);

U1: sad port map(f_sad,sadh1,rst,clk,ctr_sad(1),so(0));
U2: sad port map(f_sad,sadh2,rst,clk,ctr_sad(1),so(1));

U3: sad port map(fila_act3,sadv,rst,clk,ctr_sad(2),so(2));
U4: sad1 port map(fila_act3,sadv,rst,clk,ctr_sad(4),so(3));

U5: sad port map(fila_act3,sadd1,rst,clk,ctr_sad(3),so(4));
U6: sad port map(fila_act3,sadd2,rst,clk,ctr_sad(3),so(5));

U7: sad1 port map(fila_act3,sadd1,rst,clk,ctr_sad(5),so(6));
U8: sad1 port map(fila_act3,sadd2,rst,clk,ctr_sad(5),so(7));


U9: acumulador_s port map(so(0),ctr_asad(1),ctr_asad(4),clk,aso(0));
U10: acumulador_s port map(so(1),ctr_asad(1),ctr_asad(4),clk,aso(1));

U11: acumulador_s port map(so(2),ctr_asad(2),ctr_asad(4),clk,aso(2));
U12: acumulador_s port map(so(3),ctr_asad(3),ctr_asad(4),clk,aso(3));
U13: acumulador_s port map(so(4),ctr_asad(2),ctr_asad(4),clk,aso(4));
U14: acumulador_s port map(so(5),ctr_asad(2),ctr_asad(4),clk,aso(5));
U15: acumulador_s port map(so(6),ctr_asad(3),ctr_asad(4),clk,aso(6));
U16: acumulador_s port map(so(7),ctr_asad(3),ctr_asad(4),clk,aso(7));

--so1: -X 		-- "0011"
--so2: +X		-- "0001"
--so3: +Y		-- "1100"
--so4: -Y		-- "0100"
--so5: -X +Y	-- "1101"
--so6: +X +Y	-- "0101"
--so7: -X -Y	-- "1111"
--so8: +X -Y	-- "0111"

--Nueva version de mv
--so1: -X: 	  "0011"
--so2: +X: 	  "0001"
--so3: +Y: 	  "0100"
--so4: -Y:    "1100"
--so5: -X +Y: "0111"
--so6: +X +Y: "0101"
--so7: -X -Y: "1111"
--so8: +X -Y: "1101"


U17: mv_1_2 port map("0011","0001","0100","1100","0111","0101","1111","1101",aso,mv_12aux,asaux);
U18: des_1_2 port map(aim,asaux,"0000",mv_12aux,mv_12,as_12);

G1: for i in 0 to 7 generate
	sadh1(i)<=o(0,i);
	end generate;

G2: for i in 1 to 8 generate
	sadh2(i-1)<=o(0,i);
	end generate;
	
G3: for i in 0 to 7 generate
	sadd1(i)<=ovb(0,i);
	end generate;

G4: for i in 1 to 8 generate
	sadd2(i-1)<=ovb(0,i);
	end generate;

G5: for i in 1 to 8 generate
	sadv(i-1)<=ova(0,i);
	end generate;

end arq;

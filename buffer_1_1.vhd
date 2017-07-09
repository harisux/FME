LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.tipos_de_datos.all;


ENTITY buffer_1_1 IS
	PORT(
			fila_in		: 	IN  linea(0 TO 7);
			fila_out		: 	OUT linea(0 TO 7);
			wr				: 	IN STD_LOGIC;
			CLK			:	IN STD_LOGIC;
			en				:	IN STD_LOGIC;
			rst			:	IN STD_LOGIC);
			
END buffer_1_1;

architecture arq of buffer_1_1 is

SIGNAL D,Q: matriz (0 to 7, 0 to 3) ;
SIGNAL R: linea(0 TO 7);

begin

-- ARREGLO DE FF'S
U1:PROCESS(CLK,en,rst)
BEGIN	
	-- NxN FF'S
	IF rst = '0' THEN
		D <= (OTHERS => (OTHERS => (OTHERS => '0')));
	ELSIF RISING_EDGE(CLK) THEN
		IF en = '1' THEN
			D <= Q;
		END IF;
	END IF;
END PROCESS;

G1:FOR i IN 0 TO 7 GENERATE
	-- MULTIPLEXOR DE LECTURA/ESCRITURA
	-- wr ='0' ESCRIBIR NUEVOS DATOS
	-- wr ='1' CONTINUAR GUARDANDO LOS DATOS ANTERIORES
	R(i) <= fila_in(i) WHEN wr = '0' ELSE
			  D(i,3) WHEN wr = '1' ELSE
			  (OTHERS => '-');
	END GENERATE;
	
G2:FOR i IN 0 To 7 GENERATE
G3:	FOR j IN 1 TO 3 GENERATE
			Q(i,j)<=D(i,j-1);
		END GENERATE;
	END GENERATE;

G4:FOR i IN 0 TO 7 GENERATE
		Q(i,0)<=R(i);
	END GENERATE;
	
------------------------------------------------------
--ASIGNACIÓN DE SALIDAS
G5:FOR i IN 0 To 7 GENERATE
		fila_out(i)<=D(i,3);
	end GENERATE;
------------------------------------------------------

	
	
END arq;

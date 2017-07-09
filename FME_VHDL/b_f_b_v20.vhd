LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.tipos_de_datos.all;
use work.libreria.all;

entity b_f_b_v20 is
	PORT(
			fila_in		: 	IN  linea(0 TO 15);
			fila_act		: 	IN  linea(0 to 7);
			sadime		:	IN  std_logic_vector(13 downto 0);
			CLK			:	IN STD_LOGIC;
			rst			:	IN STD_LOGIC;
			cont_out		:	out std_logic_vector(5 downto 0);
			sad_out_14	:	out std_logic_vector(13 downto 0);
			nx_b			:	OUT STD_LOGIC
--			wr_arch		:	out std_logic
--			mv_14			: 	OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
end b_f_b_v20;

architecture arq of b_f_b_v20 is

signal fila_out: linea (0 to 15);--SALIDA DEL BUFFER DE PIXELES DE REFERENCIA
signal fila_filtro: linea(0 to 15);--ENTRADA AL FILTRO DE INTERPOLACIÓN Y SE SELECCIONA ENTRE LA ENTRADA DIRECTA O LOS DATOS GUARDADOS EN EL BUFFER DE REFERENCIA
signal fila_act1: linea(0 to 7);
signal fila_act2: linea(0 to 7);
signal fila_acti1: linea (0 to 7);
signal fila_acti2: linea (0 to 7);
signal fila_act3: linea(0 to 7);
signal fila_acth: linea(0 to 7);
signal o: matriz(0 to 3, 0 to 8);
signal ova: matriz(0 to 2, 0 to 8);
signal ovb: matriz(0 to 2,0 to 8);
signal ovc: matriz(0 to 1,0 to 8);

signal cont: std_logic_vector(5 downto 0);
signal ctr_inter: std_logic_vector(7 downto 0);
signal ctr_buff: std_logic_vector(8 downto 0);

signal mux_inter1: std_logic_vector(1 downto 0);
signal mux_inter2: std_logic_vector(1 downto 0);

signal mv_12: std_logic_vector(3 downto 0);--VECTOR DE MOVIMIENTO RESULTADO DE 1/2 PIXEL
signal as_12: std_logic_vector(13 downto 0);
signal mv_14: std_logic_vector(3 downto 0);

begin

cont_out<=cont;
--sad_out_14<=as_12;

fila_filtro<=fila_in when (ctr_buff(0)='0') else fila_out;

mux_inter1<=ctr_inter(5)&ctr_inter(4);
mux_inter2<=ctr_inter(7)&ctr_inter(6);

--wr_arch<='1' when cont="001100" else '0';

---------------------------------------------------------------------------------------------
--ALMACENAMIENTO
---------------------------------------------------------------------------------------------
U1: buffer_enteros port map(fila_in,fila_out,ctr_buff(1),CLK,ctr_buff(2),rst);
U2: buffer_1_1 port map(fila_act,fila_act1,ctr_buff(3),CLK,ctr_buff(4),rst);
U3: buffer_1_1 port map(fila_act,fila_act2,ctr_buff(7),CLK,ctr_buff(8),rst);
U6: buffer_actuales port map(fila_act,fila_act3,ctr_buff(5),CLK,ctr_buff(6),rst);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
--CONTROLADORES
---------------------------------------------------------------------------------------------
U7: control_buffer port map(clk,rst,cont,mv_12,ctr_buff);
U8: control_interp port map(clk,rst,mv_12,cont,ctr_inter);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
--FILTRO INTERPOLACIÓN
---------------------------------------------------------------------------------------------
U10: filtro_1_2 port map(fila_filtro,mux_inter1,mux_inter2,rst,ctr_inter(0),ctr_inter(1),ctr_inter(2),ctr_inter(3),clk,o,ova,ovb,ovc);
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
--CONTADOR
---------------------------------------------------------------------------------------------
U11: contador port map(clk,'1',rst,cont);
---------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
--INTERPOLACION DE 1/2 PIXEL
----------------------------------------------------------------------------------------------
U12: best_12p port map(cont,o,ova,ovb,clk,rst,sadime,fila_act1,fila_act2,fila_act3,fila_in,mv_12,as_12);
----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
--INTERPOLACION DE 1/4 PIXEL
----------------------------------------------------------------------------------------------
U13: best_14p port map(o,ova,ovb,ovc,fila_act1,fila_act2,fila_act3,clk,rst,cont,mv_12,as_12,mv_14,sad_out_14);--,mv_14);
----------------------------------------------------------------------------------------------
--read_b <=snls(0); para leer el siguiente bloque

nx_b <= '1' when (cont="000001") else '0';

end arq;
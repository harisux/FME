LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.tipos_de_datos.all;

package libreria is

----------------------------------------------------------------------------------
-- COMPONENTES DE ALMACENAMIENTO
----------------------------------------------------------------------------------
component buffer_enteros is
	PORT(
			fila_in		: 	IN  linea(0 TO 15);
			fila_out		: 	OUT linea(0 TO 15);
			wr				: 	IN STD_LOGIC;
			CLK			:	IN STD_LOGIC;
			en				:	IN STD_LOGIC;
			rst			:	IN STD_LOGIC);
end component;

component buffer_actuales is
	PORT(
			fila_in		: 	IN  linea(0 TO 7);
			fila_out		: 	OUT linea(0 TO 7);
			wr				: 	IN STD_LOGIC;
			CLK			:	IN STD_LOGIC;
			en				:	IN STD_LOGIC;
			rst			:	IN STD_LOGIC);
end component;

component buffer_1_1 is
	PORT(
			fila_in		: 	IN  linea(0 TO 7);
			fila_out		: 	OUT linea(0 TO 7);
			wr				: 	IN STD_LOGIC;
			CLK			:	IN STD_LOGIC;
			en				:	IN STD_LOGIC;
			rst			:	IN STD_LOGIC);
end component;
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--FILTRO
----------------------------------------------------------------------------------
component filtro_1_2 is 
port(
	  a: in linea(0 to 15);
	  cont1: in std_logic_vector(1 downto 0);
	  cont2: in std_logic_vector(1 downto 0);
	  rst: in std_logic;
	  selh1:in std_logic;
	  selh2:in std_logic;
	  selv1: in std_logic;
	  selv2: in std_logic;
	  clk: in std_logic;
	  o: inout matriz(0 to 3,0 to 8);
	  ova: out matriz(0 to 2,0 to 8);
	  ovb: out matriz(0 to 2,0 to 8);
	  ovc: out matriz(0 to 1,0 to 8));
 end component;
 
 component fir_8 is
PORT(A0	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A2 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A3 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A4 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A5 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A6 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A7 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  CLK	: IN STD_LOGIC;
	  RST : IN STD_LOGIC;
	  EN	: IN STD_LOGIC;
	  OP	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

component fir_7 is
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
end component;

component filtro_v is
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
end component;

component filtro_h is
PORT(A0	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A2 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A3 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A4 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A5 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A6 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  A7 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  CLK	: IN STD_LOGIC;
	  RST : IN STD_LOGIC;
	  SEL1: IN STD_LOGIC;
	  SEL2: IN STD_LOGIC;
	  O1	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O2	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O3	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  O4	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--SAD
----------------------------------------------------------------------------------
component sad is
port(act: in linea (0 to 7);
	  ref: in linea (0 to 7);
	  rst: in std_logic;
	  clk: in std_logic;
	  en: in std_logic;
		s_out: out std_logic_vector(10 downto 0));
end component;

component sad1 is
port(act: in linea (0 to 7);
	  ref: in linea (0 to 7);
	  rst: in std_logic;
	  clk: in std_logic;
	  en: in std_logic;
		s_out: out std_logic_vector(10 downto 0));
end component;

component acumulador_s is
port(sad_in: in std_logic_vector(10 downto 0);
		en: in std_logic;
		rst: in std_logic;
		clk: in std_logic;
		acu_sad: inout std_logic_vector(13 downto 0));
end component;

component sad_14pd is
port(act	: in linea (0 to 7);
	  ref	: in linea (0 to 7);
	  rst	: in std_logic;
	  clk	: in std_logic;
	  en	: in std_logic;
	  en_d: in std_logic;--habilitador el delay de los pixeles actuales
	 s_out: out std_logic_vector(10 downto 0));
end component;


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--CONTADOR
----------------------------------------------------------------------------------
component contador is
port(clk: in std_logic;
	   en: in std_logic;
	  rst: in std_logic;
	  cont: inout std_logic_vector(5 downto 0));
end component; 
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--CONTROLADOR (MAQ. DE ESTADOS)
----------------------------------------------------------------------------------
component control_buffer is
port(	clk: in std_logic;
		rst: in std_logic;
		cont: in std_logic_vector(5 downto 0);
		mv_12: in std_logic_vector(3 downto 0);
		ctr: out std_logic_vector(8 downto 0));
end component;

component control_sad_12 is
port(	clk: in std_logic;
		rst: in std_logic;
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(5 downto 0));
end component;

component control_asad_12 is
port(	clk: in std_logic;
		rst: in std_logic;
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(4 downto 0));
end component;

component control_interp is
port(	clk: in std_logic;
		rst: in std_logic;
		mv_12: in std_logic_vector(3 downto 0);
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(7 downto 0));
end component;

component control_sad_14 is
port(	clk: in std_logic;
		rst: in std_logic;
		mv_12: in std_logic_vector(3 downto 0);
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(10 downto 0));
end component;

component control_asad_14 is
port(	clk: in std_logic;
		rst: in std_logic;
		mv_12: in std_logic_vector(3 downto 0);
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(4 downto 0));
end component;
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--DETERMINAR VECTOR DE MOVIMIENTO 1/2 PIXEL
----------------------------------------------------------------------------------
component best_12p is
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
end component;

component mv_1_2 is
port(mv1,mv2,mv3,mv4	: in std_logic_vector(3 downto 0);
	  mv5,mv6,mv7,mv8	: in std_logic_vector(3 downto 0);
		aso				: in linea_sad1 (0 to 7);
	  mvvf_1_2: out std_logic_vector(3 downto 0);
	  asvf: out std_logic_vector(13 downto 0));
end component;

component des_1_2 is
port(a: in std_logic_vector(13 downto 0);
	  b: in std_logic_vector(13 downto 0);
	  va: in std_logic_vector(3 downto 0);
	  vb: in std_logic_vector(3 downto 0);
	  vf: out std_logic_vector(3 downto 0);
	  s_o: out std_logic_vector(13 downto 0));
end component;
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--DETERMINAR VECTOR DE MOVIMIENTO 1/4 PIXEL
----------------------------------------------------------------------------------
component best_14p is
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
end component;
end libreria;
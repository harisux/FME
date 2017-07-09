LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.libreria.all;
use work.tipos_de_datos.all;

entity filtro_1_2 is
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
end filtro_1_2;

architecture arq of filtro_1_2 is

signal r0: matriz(0 to 8, 0 to 7);
signal r1: matriz(0 to 8,0 to 7);
signal r2: matriz(0 to 8,0 to 7);

signal r0_aux: matriz(0 to 8,0 to 7);
signal r1_aux: matriz(0 to 8,0 to 7);
signal r2_aux: matriz(0 to 8,0 to 7);

begin

----------------------------------------------------
--r0:COLUMNA A
--r1:COLUMNA B
--r2:COLUMNA CENTRAL
----------------------------------------------------

U0: process(clk,rst)
begin
	if(rst='0')then
	r0 <= (OTHERS => (OTHERS => (OTHERS => '0')));
	r1 <= (OTHERS => (OTHERS => (OTHERS => '0')));
	r2 <= (OTHERS => (OTHERS => (OTHERS => '0'))); 
	elsif(rising_edge(clk)) then
		r0<=r0_aux;
		r1<=r1_aux;
		r2<=r2_aux;
	end if;
end process;	

---------------------------------------------------------------------
--selh1: interpolacion 1/2 horizontal
--selh2: interpolacion 1/4 y 3/4 horizontal

--selv1: interpolación 1/2 vertical
--selv2: interpolacion 1/4 y 3/4 horizontal
---------------------------------------------------------------------
--o(0,i): pixel 1/2 horizontal
--o(1,i): pixel 1/4 horizontal
--o(2,i): pixel 3/4 horizontal
--o(3,i): pixel entero
---------------------------------------------------------------------  
--R0: columna A
--R1: columna B
--R2: columna Central

F0: for i in 0 to 8 generate
	J0: filtro_h port map(a(i),a(i+1),a(i+2),a(i+3),a(i+4),a(i+5),a(i+6),a(i+7),clk,rst,selh1,selh2,o(0,i),o(1,i),o(2,i),o(3,i));
	end generate;

F1: for i in 0 to 8 generate
	J1: filtro_v port map(r0(i,0),r0(i,1),r0(i,2),r0(i,3),r0(i,4),r0(i,5),r0(i,6),r0(i,7),r1(i,0),r1(i,1),r1(i,2),r1(i,3),r1(i,4),r1(i,5),r1(i,6),r1(i,7),r2(i,0),r2(i,1),r2(i,2),r2(i,3),r2(i,4),r2(i,5),r2(i,6),r2(i,7),clk,rst,selv1,selv2,ova(0,i),ova(1,i),ova(2,i),ovb(0,i),ovb(1,i),ovb(2,i),ovc(0,i),ovc(1,i));
	end generate;
	
F2: for i in 0 to 8 generate
--Se selecciona entre: pixel entero o pixel 1/4
	with cont1 select
	r0_aux(i,0) <= o(3,i) when "00",
						o(1,i) when "01",
					"00000000" when others;
	
--Se selecciona entre: pixel 1/2 o pixel 3/4	
	with cont1 select
	r1_aux(i,0)	<= o(0,i) when "00",
						o(2,i) when "01",
					"00000000" when others;
					
--Se selecciona entre: pixel entero o pixel 1/2
	with cont2 select
	r2_aux(i,0) <= o(3,i) when "00",
						o(0,i) when "01",
					"00000000" when others;
	end generate;
	 
F3: for i in 0 to 8 generate
	F4: for j in 1 to 7 generate
		r0_aux(i,j)<=r0(i,j-1);
		r1_aux(i,j)<=r1(i,j-1);
		r2_aux(i,j)<=r2(i,j-1);
		end generate;
	end generate;	
end arq;
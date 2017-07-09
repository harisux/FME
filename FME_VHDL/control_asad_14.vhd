LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.tipos_de_datos.all;
use work.libreria.all;

---------------------------------------------------------------------------------------------
--SE ENCARGA DE CONTROLAR LOS BLOQUES SAD PARA LA INTERPOLACION DE 1/4 PIXEL 
---------------------------------------------------------------------------------------------
entity control_asad_14 is
port(	clk: in std_logic;
		rst: in std_logic;
		mv_12: in std_logic_vector(3 downto 0);
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(4 downto 0));
end control_asad_14;

------------------------------------------
architecture arq of control_asad_14 is

type estado is(estadoi,estado0,estado1a,estado1b,estado1c,estado2a,estado3a,estado4a,estado5);
signal est_pr,est_sg: estado;

begin
seq: process(rst,clk)
	  begin
	  if(rst='0') then
	  est_pr<=estadoi;
	  elsif (rising_edge(clk)) then
	  est_pr<=est_sg;
	  end if;
	  end process;
	  
--Nueva version de mv
--so1: -X: 	  "0011"
--so2: +X: 	  "0001"
--so3: +Y: 	  "0100"
--so4: -Y:    "1100"
--so5: -X +Y: "0111"
--so6: +X +Y: "0101"
--so7: -X -Y: "1111"
--so8: +X -Y: "1101"
	  
fsm1: process(est_pr,cont,mv_12)
	  begin
	  case est_pr is
	  when estadoi=>
		if(cont<=4)then
		est_sg<=estadoi;
		else
		est_sg<=estado0;
		end if;
	  when estado0=>
		if((mv_12="0011") or (mv_12="0001") or (mv_12="0000"))then
			if(cont<=37)then
				est_sg<=estado0;
			else
				est_sg<=estado1a;
			end if;
		elsif((mv_12="0100") or (mv_12="0111") or (mv_12="0101"))then
			if(cont<=41)then
				est_sg<=estado0;
			else
				est_sg<=estado1b;
			end if;
		else
			if(cont<=42)then
				est_sg<=estado0;
			else
				est_sg<=estado1c;
			end if;
		end if;
		when estado1a=>
			if(cont<=44)then
				est_sg<=estado1a;
			else
				est_sg<=estado2a;
			end if;
		when estado1b=>
			if(cont<=52)then
				est_sg<=estado1b;
			else
				est_sg<=estado5;
			end if;
		when estado1c=>
			if(cont<=53)then
				est_sg<=estado1c;
			else
				est_sg<=estado5;
			end if;
		when estado2a=>
			if(cont=45)then
				est_sg<=estado2a;
			else
				est_sg<=estado3a;
			end if;
		when estado3a=>
			if(cont<=52)then
				est_sg<=estado3a;
			else
				est_sg<=estado4a;
			end if;
		when estado4a=>
			if(cont=53)then
				est_sg<=estado4a;
			else
				est_sg<=estado5;
			end if;
		when estado5=>
			if((cont>=52) and (cont<=56))then
			est_sg<=estado5;
			else
			est_sg<=estadoi;
			end if;
		end case;
end process;

fsm2: process(est_pr)
		begin
		case est_pr is	
		when estadoi=>
				ctr(0)<='0';
				ctr(1)<='0';
				ctr(2)<='0';
				ctr(3)<='0';
				ctr(4)<='0';		
		when estado0=>
				ctr(0)<='0';
				ctr(1)<='0';
				ctr(2)<='0';
				ctr(3)<='0';
				ctr(4)<='1';
		when estado1a=>
				ctr(0)<='1';
				ctr(1)<='0';
				ctr(2)<='0';
				ctr(3)<='0';
				ctr(4)<='1';
		when estado1b=>
				ctr(0)<='0';
				ctr(1)<='1';
				ctr(2)<='1';
				ctr(3)<='1';
				ctr(4)<='1';
		when estado1c=>
				ctr(0)<='0';
				ctr(1)<='1';
				ctr(2)<='1';
				ctr(3)<='1';
				ctr(4)<='1';
		when estado2a=>
				ctr(0)<='1';
				ctr(1)<='0';
				ctr(2)<='0';
				ctr(3)<='1';
				ctr(4)<='1';
		when estado3a=>
				ctr(0)<='0';
				ctr(1)<='1';
				ctr(2)<='0';
				ctr(3)<='1';
				ctr(4)<='1';
		when estado4a=>
				ctr(0)<='0';
				ctr(1)<='1';
				ctr(2)<='0';
				ctr(3)<='0';
				ctr(4)<='1';
		when estado5=>
				ctr(0)<='0';
				ctr(1)<='0';
				ctr(2)<='0';
				ctr(3)<='0';
				ctr(4)<='1';
		end case;
end process;
end arq;
		
		
	
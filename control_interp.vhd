LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.tipos_de_datos.all;
use work.libreria.all;

---------------------------------------------------------------------------------------------
--SE ENCARGA DE CONTROLAR AL FILTRO DE INTERPOLACION (FILTRO_1_2) 
---------------------------------------------------------------------------------------------
entity control_interp is
port(	clk: in std_logic;
		rst: in std_logic;
		mv_12: in std_logic_vector(3 downto 0);
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(7 downto 0));
end control_interp;

------------------------------------------
--ctr(0):selh1
--ctr(1):selh2
--ctr(2):selv1
--ctr(3):selv2
--ctr(5)&ctr(4):cont1
--ctr(7)&ctr(6):cont2

---------------------------------------------------------------------
--selh1: interpolacion 1/2 horizontal
--selh2: interpolacion 1/4 y 3/4 horizontal

--selv1: interpolación 1/2 vertical
--selv2: interpolacion 1/4 y 3/4 horizontal

--cont1: "00" - pixel entero para la parte vertical A
--			"01" - pixel 1/4 para la parte vertical A

--			"00" - pixel 1/2 para la parte vertical B
--			"01" - pixel 3/4 para la parte vertical B

--cont2:	"00" - pixel entero para la parte vertical central
--			"01" - pixel 1/2 para la parte vertical central  
--------------------------------------------------------------------
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

architecture arq of control_interp is

type estado is(estado0,estado1,estado2a,estado2b,estado3);
signal est_pr,est_sg: estado;

begin
seq: process(rst,clk)
	  begin
	  if(rst='0') then
	  est_pr<=estado0;
	  elsif (rising_edge(clk)) then
	  est_pr<=est_sg;
	  end if;
	  end process;
	  
fsm1: process(cont,est_pr,mv_12)
		begin
		case est_pr is
		when estado0=>
			if(cont=0)then
				ctr<="11110000";
				est_sg<=estado0;
			else
				est_sg<=estado1;
				ctr<="11000101";
			end if;
		when estado1=>
			if(cont<=26)then
				est_sg<=estado1;
				ctr<="11000101";
			else
				if((mv_12="1100") or (mv_12="0100") or (mv_12="0000")) then
					est_sg<=estado2a;
					ctr(0)<='1';
					ctr(1)<='1';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='1';
					ctr(5)<='0';
					ctr(6)<='0';
					ctr(7)<='0';
				else
					est_sg<=estado2b;
					ctr(0)<='1';
					ctr(1)<='1';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='1';
					ctr(5)<='0';		
					ctr(6)<='1';
					ctr(7)<='0';
				end if;
			end if;
		when estado2a=>
			if(cont<=49)then
				est_sg<=estado2a;
				ctr<="00011111";
			else
				est_sg<=estado3;
				ctr<="11110000";
			end if;
		when estado2b=>
			if(cont<=49)then
				est_sg<=estado2b;
				ctr<="01011111";
			else
				est_sg<=estado3;
				ctr<="11110000";
			end if;
		when estado3=>
			if(cont<=56)then
				est_sg<=estado3;
				ctr<="11110000";
			else
				est_sg<=estado0;
				ctr<="11110000";
			end if;
		end case;
end process;
	  
--fsm1: process(cont,est_pr,mv_12)
--		begin
--		case est_pr is
--			when estado0=>
--				if(cont<0) then
--					est_sg<=estado0;
--				else
--					est_sg<=estado1;
--				end if;
--			when estado1=>
--				if(cont<=26)then--era 25
--					est_sg<=estado1;
--				else
--					if((mv_12="1100") or (mv_12="0100") or (mv_12="0000")) then
--					est_sg<=estado2a;
--					else
--					est_sg<=estado2b;
--					end if;
--				end if;
--			when estado2a=>
--				if(cont<=47)then
--					est_sg<=estado2a;
--				else
--					est_sg<=estado3;
--				end if;
--			when estado2b=>
--				if(cont<=47)then
--					est_sg<=estado2b;
--				else
--					est_sg<=estado3;
--				end if;
--			when estado3=>
--				if((cont>=48)and(cont<=56))then
--				est_sg<=estado3;
--				else
--				est_sg<=estado0;
--				end if;
--			end case;
--		end process;
--
--fsm2: process(est_pr)
--	  begin
--	  case est_pr is
--	  when estado0=>
--		ctr<="11110000";
--	  when estado1=>
--	  ctr<="11000101";
--	  when estado2a=>
--			ctr(0)<='1';
--			ctr(1)<='1';
--			ctr(2)<='1';
--			ctr(3)<='1';
--			ctr(4)<='1';
--			ctr(5)<='0';				
--			ctr(6)<='0';
--			ctr(7)<='0';
--		when estado2b=>
--			ctr(0)<='1';
--			ctr(1)<='1';
--			ctr(2)<='1';
--			ctr(3)<='1';
--			ctr(4)<='1';
--			ctr(5)<='0';		
--			ctr(6)<='1';
--			ctr(7)<='0';
--		when estado3=>
--			ctr<="11110000";
--end case;
--end process;
end arq;		

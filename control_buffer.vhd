LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.tipos_de_datos.all;
use work.libreria.all;

---------------------------------------------------------------------------------------------
-- ES EL CONTROLADOR ENCARGADO DE LOS BUFFER 
---------------------------------------------------------------------------------------------

entity control_buffer is
port(	clk: in std_logic;
		rst: in std_logic;
		cont: in std_logic_vector(5 downto 0);
		mv_12: in std_logic_vector(3 downto 0);
		ctr: out std_logic_vector(8 downto 0));
end control_buffer;

architecture arq of control_buffer is

type estado is(estado0,estado1,estado2,estado3,estado4,estado5,estado6,estado7,estado8,estado9,estado10,estado11,estado12a,estado12b,
					estado13a,estado13b,estado14a,estado14b,estado14c,estado15a,estado15b,estado15c,estado16a,estado16b,estado17);
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
	  
--ctr(0): multiplexor para entrada directa o entrada de buffer
--ctr(1): WR buffer enteros 
--ctr(2): EN buffer enteros
--ctr(3): WR buffer 1.1
--ctr(4): EN buffer 1.1
--ctr(5): WR buffer actuales 
--ctr(6): EN buffer actuales 
--ctr(7): WR buffer 1.2
--ctr(8): EN buffer 1.2
--ctr(9): WR buffer i 1.1
--ctr(10): EN buffer i 1.1
--ctr(11): WR buffer i 1.2
--ctr(12): EN buffer i 1.2	  
fsm1: process(cont,est_pr,mv_12)
		begin
		case est_pr is
			when estado0=>
				if(cont<0) then
					est_sg<=estado0;
				else
					est_sg<=estado1;
				end if;
			when estado1=>
				if(cont<=3)then
					est_sg<=estado1;
				else
					est_sg<=estado2;
				end if;
			when estado2=>
				if(cont<=6)then
					est_sg<=estado2;
				else
					est_sg<=estado3;
				end if;
			when estado3=>
				if(cont=7)then
					est_sg<=estado3;
				else
					est_sg<=estado4;
				end if;
			when estado4=>
				if(cont<=10)then
					est_sg<=estado4;
				else
					est_sg<=estado5;
				end if;
			when estado5=>
				if(cont=11)then
					est_sg<=estado5;
				else
					est_sg<=estado6;
				end if;
			when estado6=>
				if(cont<=13)then
					est_sg<=estado6;
				else
					est_sg<=estado7;
				end if;
			when estado7=>
				if(cont=14)then
					est_sg<=estado7;
				else
					est_sg<=estado8;
				end if;
			when estado8=>
				if(cont=15)then
					est_sg<=estado8;
				else
					est_sg<=estado9;
				end if;
			when estado9=>
				if(cont<=21)then
					est_sg<=estado9;
				else
					est_sg<=estado10;
				end if;
			when estado10=>
				if(cont<=25)then
					est_sg<=estado10;
				else
					est_sg<=estado11;
				end if;
			when estado11=>
				if(cont<=34)then
					est_sg<=estado11;
				else
					if((mv_12="0011") or (mv_12="0001") or (mv_12="0000"))then
					est_sg<=estado12a;
					else
					est_sg<=estado12b;
					end if;
				end if;
			when estado12a=>
				if(cont<=38)then
					est_sg<=estado12a;
				else
					est_sg<=estado13a;
				end if;
			when estado12b=>
				if(cont<=38)then
					est_sg<=estado12b;
				else
					est_sg<=estado13b;
				end if;
			when estado13a=>
				if(cont<=41)then
					est_sg<=estado13a;
				else
					est_sg<=estado14a;
				end if;
			when estado13b=>
				if(cont<=41)then
					est_sg<=estado13b;
				else
					if((mv_12="1100") or (mv_12="1111") or (mv_12="1101"))then
						est_sg<=estado14b;
					else
						est_sg<=estado14c;
					end if;
				end if;
			when estado14a=>
				if(cont=42)then
					est_sg<=estado14a;
				else
					est_sg<=estado15a;
				end if;
			when estado14b=>
				if(cont=42)then
					est_sg<=estado14b;
				else
					est_sg<=estado15b;
				end if;
			when estado14c=>
				if(cont=42)then
					est_sg<=estado14c;
				else
					est_sg<=estado15c;
				end if;
			when estado15a=>
				if(cont<=50)then
					est_sg<=estado15a;
				else
					est_sg<=estado16a;
				end if;
			when estado15b=>
				if(cont<=50)then
					est_sg<=estado15b;
				else
					est_sg<=estado16b;
				end if;
			when estado15c=>
				if(cont<=50)then
					est_sg<=estado15c;
				else
					est_sg<=estado16a;
				end if;
			when estado16a=>
				if(cont=51)then
					est_sg<=estado16a;
				else
					est_sg<=estado17;
				end if;
			when estado16b=>
				if(cont=51)then
					est_sg<=estado16b;
				else
					est_sg<=estado17;
				end if;
			when estado17=>
				if((cont>=52) and (cont<=56))then
				est_sg<=estado17;
				else
				est_sg<=estado0;
				end if;
			end case;
		end process;
		
fsm2: process(est_pr)
		begin
		case est_pr is
		when estado0=>
			ctr<="010101010";
		when estado1=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='0';
					ctr(4)<='1';
					ctr(5)<='0';
					ctr(6)<='1';
					ctr(7)<='1';
					ctr(8)<='0';
		when estado2=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='0';
					ctr(6)<='1';
					ctr(7)<='0';
					ctr(8)<='1';
			when estado3=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='1';--mover buffer 1.1
					ctr(5)<='0';
					ctr(6)<='1';
					ctr(7)<='0';
					ctr(8)<='1';
			when estado4=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='1';--mover buffer 1.1
					ctr(5)<='1';
					ctr(6)<='0';
					ctr(7)<='1';
					ctr(8)<='0';
			when estado5=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='1';
					ctr(6)<='0';
					ctr(7)<='1';
					ctr(8)<='1';
			when estado6=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='1';
					ctr(6)<='0';
					ctr(7)<='1';
					ctr(8)<='1';	
			when estado7=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='1';
					ctr(6)<='1';
					ctr(7)<='1';
					ctr(8)<='1';	
			when estado8=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='1';
					ctr(6)<='1';
					ctr(7)<='1';
					ctr(8)<='0';
			when estado9=>
					ctr(0)<='1';
					ctr(1)<='1';
					ctr(2)<='0';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='1';
					ctr(6)<='1';
					ctr(7)<='1';
					ctr(8)<='0';
			when estado10=>
					ctr(0)<='1';
					ctr(1)<='1';
					ctr(2)<='0';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='1';
					ctr(6)<='0';
					ctr(7)<='1';
					ctr(8)<='0';
			when estado11=>
					ctr(0)<='1';
					ctr(1)<='1';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='0';
					ctr(5)<='1';
					ctr(6)<='0';
					ctr(7)<='1';
					ctr(8)<='0';
			when estado12a=>
						ctr(0)<='1';
						ctr(1)<='1';
						ctr(2)<='1';
						ctr(3)<='1';
						ctr(4)<='1';
						ctr(5)<='1';
						ctr(6)<='0';
						ctr(7)<='1';
						ctr(8)<='1';
			when estado12b=>
						ctr(0)<='1';
						ctr(1)<='1';
						ctr(2)<='1';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='0';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado13a=>
						ctr(0)<='1';
						ctr(1)<='1';
						ctr(2)<='1';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='0';
						ctr(7)<='1';
						ctr(8)<='1';
			when estado13b=>
						ctr(0)<='1';
						ctr(1)<='1';
						ctr(2)<='1';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='0';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado14a=>
						ctr(0)<='1';
						ctr(1)<='1';
						ctr(2)<='1';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='1';
						ctr(7)<='1';
						ctr(8)<='1';
			when estado14b=>
						ctr(0)<='1';
						ctr(1)<='1';
						ctr(2)<='1';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='0';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado14c=>
						ctr(0)<='1';
						ctr(1)<='1';
						ctr(2)<='1';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='1';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado15a=>
						ctr(0)<='0';
						ctr(1)<='1';
						ctr(2)<='0';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='1';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado15b=>
						ctr(0)<='0';
						ctr(1)<='1';
						ctr(2)<='0';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='1';
						ctr(7)<='1';
						ctr(8)<='0';	
			when estado15c=>
						ctr(0)<='0';
						ctr(1)<='1';
						ctr(2)<='0';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='1';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado16a=>
						ctr(0)<='0';
						ctr(1)<='1';
						ctr(2)<='0';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='0';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado16b=>
						ctr(0)<='0';
						ctr(1)<='1';
						ctr(2)<='0';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='1';
						ctr(7)<='1';
						ctr(8)<='0';
			when estado17=>
						ctr(0)<='0';
						ctr(1)<='1';
						ctr(2)<='0';
						ctr(3)<='1';
						ctr(4)<='0';
						ctr(5)<='1';
						ctr(6)<='0';
						ctr(7)<='1';
						ctr(8)<='0';
			end case;
		end process;
	end arq;
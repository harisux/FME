LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.tipos_de_datos.all;
use work.libreria.all;

---------------------------------------------------------------------------------------------
-- ES EL CONTROLADOR ENCARGADO DE CONTROLAR BLOQUES ACUMULADORES SAD 1/2
---------------------------------------------------------------------------------------------

entity control_asad_12 is
port(	clk: in std_logic;
		rst: in std_logic;
		cont: in std_logic_vector(5 downto 0);
		ctr: out std_logic_vector(4 downto 0));
end control_asad_12;

architecture arq of control_asad_12 is

type estado is(estado0,estado1,estado2,estado3,estado4,estado5,estado6,estado7);
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
	  
comb: process(cont,est_pr)
		begin
		case est_pr is
			when estado0=>
				if(cont<=6)then
					est_sg<=estado0;
				else
					est_sg<=estado1;
				end if;
			when estado1=>
				if(cont<=9)then
					est_sg<=estado1;
				else
					est_sg<=estado2;
				end if;
			when estado2=>
				if(cont<=14)then
					est_sg<=estado2;
				else
					est_sg<=estado3;
				end if;
			when estado3=>
				if(cont<=16)then--antes era 15
					est_sg<=estado3;
				else
					est_sg<=estado4;
				end if;
			when estado4=>
				if(cont<=17)then
					est_sg<=estado4;
				else	
					est_sg<=estado5;
				end if;
			when estado5=>
				if(cont<=24)then
					est_sg<=estado5;
				else
					est_sg<=estado6;
				end if;
			when estado6=>
				if(cont<=25)then
					est_sg<=estado6;
				else
					est_sg<=estado7;
				end if;
			when estado7=>
				if(cont<=56)then
				est_sg<=estado7;
				else
				est_sg<=estado0;
				end if;
		end case;
		end process;
	
fsm2: process(est_pr)
		begin
		case est_pr is
		when estado0=>
			ctr<=(others=>'0');
		when estado1=>
					ctr(0)<='1';
					ctr(1)<='0';
					ctr(2)<='0';
					ctr(3)<='0';
					ctr(4)<='1';
		when estado2=>		
					ctr(0)<='1';
					ctr(1)<='1';
					ctr(2)<='0';
					ctr(3)<='0';
					ctr(4)<='1';
		when estado3=>
					ctr(0)<='0';
					ctr(1)<='1';
					ctr(2)<='0';
					ctr(3)<='0';
					ctr(4)<='1';
		when estado4=>
					ctr(0)<='0';
					ctr(1)<='1';
					ctr(2)<='1';
					ctr(3)<='0';
					ctr(4)<='1';
		when estado5=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='1';
					ctr(3)<='1';
					ctr(4)<='1';
		when estado6=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='0';
					ctr(3)<='1';
					ctr(4)<='1';
		when estado7=>
					ctr(0)<='0';
					ctr(1)<='0';
					ctr(2)<='0';
					ctr(3)<='0';
					ctr(4)<='1';
		end case;
		end process;
	end arq;
	

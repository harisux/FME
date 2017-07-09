LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.tipos_de_datos.all;
USE work.libreria.all;

entity mv_1_2 is

port(mv1,mv2,mv3,mv4	: in std_logic_vector(3 downto 0);
	  mv5,mv6,mv7,mv8	: in std_logic_vector(3 downto 0);
		aso				: in linea_sad1 (0 to 7);
	  mvvf_1_2: out std_logic_vector(3 downto 0);
	  asvf: out std_logic_vector(13 downto 0));
end mv_1_2;

architecture arq of mv_1_2 is

signal va1: std_logic_vector(3 downto 0);
signal va2: std_logic_vector(3 downto 0);
signal va3: std_logic_vector(3 downto 0);
signal va4: std_logic_vector(3 downto 0);
signal va5: std_logic_vector(3 downto 0);
signal va6: std_logic_vector(3 downto 0);

signal s1: std_logic_vector(13 downto 0);
signal s2: std_logic_vector(13 downto 0);
signal s3: std_logic_vector(13 downto 0);
signal s4: std_logic_vector(13 downto 0);
signal s5: std_logic_vector(13 downto 0);
signal s6: std_logic_vector(13 downto 0);

begin

U0: des_1_2 port map(aso(1),aso(0),mv2,mv1,va1,s1);
U1: des_1_2 port map(aso(3),aso(2),mv4,mv3,va2,s2);
U2: des_1_2 port map(aso(5),aso(4),mv6,mv5,va3,s3);
U3: des_1_2 port map(aso(7),aso(6),mv8,mv7,va4,s4);

U4: des_1_2 port map(s1,s2,va1,va2,va5,s5);
U5: des_1_2 port map(s3,s4,va3,va4,va6,s6);
U7: des_1_2 port map(s5,s6,va5,va6,mvvf_1_2,asvf);

end arq;

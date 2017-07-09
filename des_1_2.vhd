LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.tipos_de_datos.ALL;

entity des_1_2 is
port(a: in std_logic_vector(13 downto 0);
	  b: in std_logic_vector(13 downto 0);
	  va: in std_logic_vector(3 downto 0);
	  vb: in std_logic_vector(3 downto 0);
	  vf: out std_logic_vector(3 downto 0);
	  s_o: out std_logic_vector(13 downto 0));
end des_1_2;

architecture arq of des_1_2 is

begin

vf <= va when (a<=b) else vb;
s_o <= a when (a<=b) else b;

end arq;

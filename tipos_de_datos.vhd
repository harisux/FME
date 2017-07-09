LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE tipos_de_datos is

	TYPE linea  IS ARRAY(NATURAL RANGE <>) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	type linea1 IS ARRAY(NATURAL RANGE <>) OF unsigned(8 DOWNTO 0);
	type linea2 IS ARRAY(NATURAL RANGE <>) OF unsigned(9 DOWNTO 0);
	type linea3 IS ARRAY(NATURAL RANGE <>) OF signed(8 DOWNTO 0);
	type linea4 IS ARRAY(NATURAL RANGE <>) OF std_logic_vector(8 DOWNTO 0);
	type linea_sad IS ARRAY(NATURAL RANGE <>) OF std_logic_vector(10 DOWNTO 0);
	type linea_sad1 IS ARRAY(NATURAL RANGE <>) OF std_logic_vector(13 DOWNTO 0);
	type matriz is array(natural range <>,natural range <>) of std_logic_vector(7 downto 0);
	TYPE linea16b IS ARRAY(NATURAL RANGE <>) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	TYPE fila_rom IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(3 DOWNTO 0);

END tipos_de_datos;
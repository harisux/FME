LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.tipos_de_datos.ALL;

entity acumulador_s is

port(sad_in: in std_logic_vector(10 downto 0);
		en: in std_logic;
		rst: in std_logic;
		clk: in std_logic;
		acu_sad: inout std_logic_vector(13 downto 0));
end acumulador_s;

architecture arq of acumulador_s is

signal d: std_logic_vector(13 downto 0);

begin

d<=std_logic_vector(unsigned(sad_in)+unsigned(acu_sad));

process(rst,clk)
begin
	if(rst='0') then
		acu_sad<=(others=>'0');
	elsif(rising_edge(clk)) then
		if(en='1') then
		acu_sad<=d;
		end if;
	end if;
end process;

end arq;



		
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity contador is
port(clk: in std_logic;
	   en: in std_logic;
	  rst: in std_logic;
	  cont: inout std_logic_vector(5 downto 0));
end contador;

architecture arq of contador is

signal suma: std_logic_vector(5 downto 0);
signal mux: std_logic_vector(5 downto 0);
begin

suma<=cont+1;
mux<=(others=>'0') when (cont=57) else suma;

process(rst,clk,en)
begin
	if(rst='0') then
		cont<=(others=>'0');	
	elsif(rising_edge(clk)) then
		if(en='1') then
				cont<=mux;
		end if;
	end if;
end process;

end arq;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.tipos_de_datos.ALL;


entity sad is 
port(act: in linea (0 to 7);
	  ref: in linea (0 to 7);
	  rst: in std_logic;
	  clk: in std_logic;
	  en: in std_logic;
		s_out: out std_logic_vector(10 downto 0));
end sad;

architecture arq of sad is
signal d1: linea (0 to 7);
signal q1: linea (0 to 7);
signal d2: linea1(0 to 3);
signal q2: linea1(0 to 3);
signal d3: linea2(0 to 1);
signal q3: linea2(0 to 1);
signal dif: linea3(0 to 7);
signal aux: linea4(0 to 7);
signal auxn: linea4(0 to 7);


begin

f0: for i in 0 to 7 generate
		dif(i)<=signed('0'&ref(i))-signed('0'&act(i));
	 end generate;
	 
f1: for i in 0 to 7 generate
		aux(i)<=std_logic_vector(dif(i));
		auxn(i)<=std_logic_vector(0-dif(i));
		d1(i)<=aux(i)(7 downto 0) when aux(i)(8)='0' else auxn(i)(7 downto 0);
	 end generate;

f2: for i in 0 to 3 generate
		d2(i)<=unsigned('0'&q1(i*2))+unsigned('0'&q1(i*2+1));
	 end generate;
	 
f3: for i in 0 to 1 generate
		d3(i)<=unsigned('0'&std_logic_vector(q2(i*2)))+unsigned('0'&std_logic_vector(q2(i*2+1)));
	 end generate;
	 
s_out<=std_logic_vector(unsigned('0'&std_logic_vector(q3(0)))+unsigned('0'&std_logic_vector(q3(1))));

process(rst,clk)
begin
	if(rst='0') then
		q1<=(others=>(others=>'0'));
		q2<=(others=>(others=>'0'));
		q3<=(others=>(others=>'0'));
	elsif rising_edge(clk) then
		if(en='1') then
		q1<=d1;
		q2<=d2;
		q3<=d3;
		end if;
	end if;
end process;

end arq;

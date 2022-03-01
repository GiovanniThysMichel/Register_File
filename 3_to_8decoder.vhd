library ieee ;
use ieee.std_logic_1164.all ;
use IEEE.numeric_std.all;

entity dec3to8 is
	port (	
		din	: in STD_LOGIC_VECTOR(2 downto 0) ;
		En 	: in STD_LOGIC ;
		dout 	: out STD_LOGIC_VECTOR(7 downto 0) 
		);
end dec3to8;

architecture dataflow of dec3to8 is
	signal Enw : STD_LOGIC_VECTOR(3 DOWNTO 0) ;
begin
	Enw <= En & din ;
	with Enw select
		dout <= 
            "00000001" when "1000",  --1
            "00000010" when "1001",  --2
            "00000100" when "1010",  --3
            "00001000" when "1011",  --4
            "00010000" when "1100",  --5
            "00100000" when "1101",  -- 6         
            "01000000" when "1110",  --  7         
            "10000000" when "1111",  --  8
            "00000000" when others; --0xxx
       
end dataflow ;

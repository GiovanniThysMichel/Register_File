library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_file is 
    port(
            clk : in std_logic;
            rst : in std_logic;
            we  : in std_logic;
            addr: in std_logic_vector(2 downto 0);
            din: in std_logic_vector(3 downto 0);
            dout: out std_logic_vector(3 downto 0)
    );
end reg_file;

architecture structural of reg_file is
    
    component reg_module is generic(
        n : integer := 4
    );
        port(
            clk  : in std_logic;
            rst  : in std_logic;
            we   : in std_logic;
            din  : in std_logic_vector(n-1 downto 0);
            dout : out std_logic_vector(n-1 downto 0)

    );
    end component;


    component mux8to1 is
	generic (
		n : integer := 4
	);
	    port(	
            din0 : in std_logic_vector(n - 1 downto 0) ;
            din1 : in std_logic_vector(n - 1 downto 0) ;
            din2 : in std_logic_vector(n - 1 downto 0) ;
            din3 : in std_logic_vector(n - 1 downto 0) ;
            din4 : in std_logic_vector(n - 1 downto 0) ;
            din5 : in std_logic_vector(n - 1 downto 0) ;
            din6 : in std_logic_vector(n - 1 downto 0) ;
            din7 : in std_logic_vector(n - 1 downto 0) ;
			sel	: in STD_LOGIC_VECTOR(2 DOWNTO 0) ;
			dout	: out std_logic_vector(n -1 downto 0) 
		   ) ;
    end component;

    component dec3to8 is
        port (	
            din	: in STD_LOGIC_VECTOR(2 downto 0) ;
            En 	: in STD_LOGIC ;
            dout 	: out STD_LOGIC_VECTOR(7 downto 0) 
            ) ;
    end component;

    signal decoder_dout :std_logic_vector(7 downto 0);
    type array_8of3 is array(0 to 7) of std_logic_vector(3 downto 0); 

    signal reg_dout : array_8of3;

    begin
        
        inst_decoder : dec3to8
        Port map(
            
            din	=> addr,
            En 	=> we,
            dout   => decoder_dout

        );

        inst_mux : mux8to1
        generic map (
            n =>4
        )
        port map(
            sel  => addr,
            din0 => reg_dout(0),
            din1 => reg_dout(1),
            din2 => reg_dout(2),
            din3 => reg_dout(3),
            din4 => reg_dout(4),
            din5 => reg_dout(5),
            din6 => reg_dout(6),
            din7 => reg_dout(7),
            dout => dout
        );


        reg_module_gen : for i in 0 to 7 generate

            inst_reg_module : reg_module
            generic map(
                n => 4
            )
            port map(
                clk     => clk            ,   
                rst     => rst            ,
                we      => decoder_dout(i),
                din     => din            ,
                dout    => reg_dout(i)      

            );
        end generate;

        ---LABEL_NAME : for i in start to stop generate

        --end generate;


        -- label: component_name
        -- generic map(

        -- )
        -- port map (

        -- );
     

    
end structural;



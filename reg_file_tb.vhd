library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_file_tb is
end reg_file_tb;

architecture behaivoral of reg_file_tb  is

component reg_file is 
    port(
            clk : in std_logic;
            rst : in std_logic;
            we  : in std_logic;
            addr: in std_logic_vector(2 downto 0);
            din : in std_logic_vector(3 downto 0);
            dout: out std_logic_vector(3 downto 0)
    );
end component;

signal clk  : std_logic;       
signal rst  : std_logic;
signal we   : std_logic;
signal addr : std_logic_vector(2 downto 0);
signal din  : std_logic_vector(3 downto 0);
signal dout : std_logic_vector(3 downto 0);

constant period : time := 10 ns;

begin 
    UUT: reg_file
    port map(
        clk   => clk,
        rst   => rst,
        we    => we,
        addr  => addr,
        din   => din,
        dout  => dout
    );
    
    clk_gen: process 
    begin
        clk <= '0';
        wait for period/2;
        clk <= '1';
        wait for period/2;
    end process;
    
    tb: process 
    begin 
    --enables decoder 
        we <= '1';
    --disables reset 
        rst<= '1';

        --writes to register 0
        addr <= "000";
        din <= "0010";
        wait for period;
        
        --writes to register 1
        addr <= "001";
        din <= "0001";
        wait for period;

        --writes to register 2
        addr <= "010";
        din <= "0101";
        wait for period;
        
        --writes to register 3
        addr <= "011";
        din <= "0111";
        wait for period;
        
        --writes to register 4
        addr <= "100";
        din <= "1011";
        wait for period;     

        --writes to register 5
        addr <= "101";
        din <= "1001";
        wait for period;   
              
        --writes to register 6
        addr <= "110";
        din <= "1010";
        wait for period;           
        
          
        --writes to register 7
        addr <= "111";
        din <= "0101";
        wait for period;
        
        we <= '0';
        wait for period;
        
        wait;

        --Read from register 0
        addr <= "000";
        wait for period;
        --Read from register 1
        addr <= "001";
        wait for period;
        --Read from register 2
        addr <= "010";
        wait for period;
        --Read from register 3
        addr <= "011";
        wait for period;
        --Read from register 4
        addr <= "100";
        wait for period;
        --Read from register 5
        addr <= "101";
        wait for period;
        --Read from register 6
        addr <= "110";
        wait for period;
        --Read from register 7
        addr <= "111";
        wait for period;       

        --reset everything
        rst<= '0';
        wait for 1 ns;

        --
        --Here we are testing checking to make sure everything was changed to zero so we disable reset again
        rst<= '1';
        --Read from register 0
        addr <= "000";
        wait for period;
        --Read from register 1
        addr <= "001";
        wait for period;
        --Read from register 2
        addr <= "010";
        wait for period;
        --Read from register 3
        addr <= "011";
        wait for period;
        --Read from register 4
        addr <= "100";
        wait for period;
        --Read from register 5
        addr <= "101";
        wait for period;
        --Read from register 6
        addr <= "110";
        wait for period;
        --Read from register 7
        addr <= "111";
        wait for period; 

        --reset everything
        rst<= '0';
        wait for 1 ns;

    end process;
end behaivoral;
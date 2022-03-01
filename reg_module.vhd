library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_module is 
    generic(
        n : integer := 4
    );
    port(
        din         : in std_logic_vector(n-1 downto 0);
        rst, clk  : in std_logic;
        we          : in std_logic;
        dout        : out std_logic_vector(n-1 downto 0)

    );
end reg_module;

---Use for generate
architecture behaivoral of reg_module is
begin
    process ( rst, clk ) 
    begin

         
        if rst ='0' then
            dout <= (others =>'0');
        elsif clk 'event and clk='1' then 
            if we='1' then
                dout <= din;
            end if;
        end if;
    end process;
    ---Here will put register using enable and clock

end behaivoral;
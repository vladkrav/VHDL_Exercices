library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador2b is
  
  port (
    rst     : in  std_logic;
    clk     : in  std_logic;
    out_cnt : out std_logic_vector (1 downto 0));

end contador2b;


architecture rtl of contador2b is

signal sal_contador : unsigned (1 downto 0);
  
begin  -- rtl


  
process (clk, rst)
begin  -- process
  if rst = '1' then                     -- asynchronous reset (active low)
    sal_contador <= (others => '0');
    
  elsif clk'event and clk = '1' then    -- rising clock edge
      sal_contador <= sal_contador+1;
    
  end if;
end process;

out_cnt <= std_logic_vector(sal_contador);

end rtl;

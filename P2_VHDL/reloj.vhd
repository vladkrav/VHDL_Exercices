library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reloj is

  port (
    CLK     : in  std_logic;
    RST     : in  std_logic;
    EN_1KHZ : out std_logic;
    EN_1HZ  : out std_logic);

end entity reloj;


architecture rtl of reloj is

  -- Constantes para simulación
--  constant FIN_CUENTA1 : integer := 4;  --
--  constant FIN_CUENTA2 : integer := 10;
--  constant FIN_CUENTA3 : integer := 100;

  -- Constantes para implementación final
 constant FIN_CUENTA1 : integer := 9;  --
 constant FIN_CUENTA2 : integer := 9999;
 constant FIN_CUENTA3 : integer := 999;

  -- Señales de reloj intermedias
  signal conta_10MHZ : unsigned (3 downto 0);
  signal EN_10MHZ    : std_logic;
  signal conta_1KHz  : unsigned (13 downto 0);
  signal conta_1Hz   : unsigned (9 downto 0);
  signal EN_1KHZ_i   : std_logic;
  
  
begin  -- architecture rtl


  conta1_div5 : process (clk, rst) is
  begin  -- process conta1_div5
    if rst = '1' then                   -- asynchronous reset (active low)
      conta_10MHZ <= (others => '0');
      EN_10MHZ    <= '0';

    elsif clk'event and clk = '1' then  -- rising clock edge
      conta_10MHZ <= conta_10MHZ + 1;
      EN_10MHZ    <= '0';

      if conta_10MHZ = FIN_CUENTA1 then
        conta_10MHZ <= (others => '0');
        EN_10MHZ    <= '1';
      end if;
    end if;
  end process conta1_div5;




  conta2_div10000 : process (clk, rst) is
  begin  -- process conta2_div10000
    if rst = '1' then                   -- asynchronous reset (active low)
      EN_1KHZ_i  <= '0';
      conta_1KHz <= (others => '0');
      
    elsif clk'event and clk = '1' then  -- rising clock edge
      EN_1KHZ_i <= '0';


      if EN_10MHZ = '1' then
        EN_1KHZ_i <= '0';

        if conta_1KHz = FIN_CUENTA2 then
          EN_1KHZ_i  <= '1';
          conta_1KHz <= (others => '0');
        else
          conta_1KHz <= conta_1KHz + 1;
          
        end if;
        
      end if;
    end if;
  end process conta2_div10000;

  EN_1KHZ <= EN_1KHZ_i;

  conta3_div1000 : process (clk, rst) is
  begin  -- process conta3_div1000
    if rst = '1' then                   -- asynchronous reset (active low)
      EN_1HZ    <= '0';
      conta_1Hz <= (others => '0');
      
    elsif clk'event and clk = '1' then  -- rising clock edge
      EN_1HZ <= '0';
      if EN_1KHZ_i = '1' then
        if conta_1Hz = FIN_CUENTA3 then
          conta_1Hz <= (others => '0');
          EN_1HZ    <= '1';
          
        else
          
          conta_1HZ <= conta_1HZ + 1;
        end if;
      end if;
    end if;
  end process conta3_div1000;
  

end architecture rtl;

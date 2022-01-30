library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity M2_sel_PWM is
  
  port (
    CLK      : in  std_logic;           -- reloj de 100 MHz
    rst      : in  std_logic;           -- rst asíncrono (nivel bajo)
    btn_up   : in  std_logic;           -- pulsador de incremento de D(%)
    btn_down : in  std_logic;           -- pulsador de decremento de D(%)
    vecPWM   : out std_logic_vector (7 downto 0));  -- vector de PWM

end entity M2_sel_PWM;



architecture rtl of M2_sel_PWM is
  signal vec_temp       : std_logic_vector (7 downto 0) := "00000000";
  -----------------------------------------------------------------------------
  --SEÑALES PARA PRESCALER--
  -----------------------------------------------------------------------------
  signal temporal_2     : std_logic;
  signal cont_2         : integer range 0 to 4_999_999  := 0;  --cuenta real 10Hz
  --signal cont_2         : integer range 0 to 2499       := 0;  -- cuenta simulación 10kHz
  --constant FIN_CUENTA_2 : integer                       := 2499;
  constant FIN_CUENTA_2 : integer                       := 4_999_999;
  signal clk_10hz       : std_logic;
  
begin  -- architecture rtl
  
  -----------------------------------------------------------------------------
  --PRESCALER--
  -----------------------------------------------------------------------------

  reloj : process (CLK, rst) is
  begin  -- process reloj
    if rst = '0' then  -- asynchronous reset (active low)      
      temporal_2 <= '1';
      cont_2     <= 0;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if cont_2 = FIN_CUENTA_2 then
        temporal_2 <= not(temporal_2);
        cont_2     <= 0;
      else
        cont_2 <= cont_2 + 1;
      end if;
    end if;
  end process reloj;
  clk_10hz <= temporal_2;

  -----------------------------------------------------------------------------
  --SELECCION DE PWM--
  -----------------------------------------------------------------------------

  process (clk_10hz, rst) is
  begin  -- process PWM
    if rst = '0' then
      vec_temp <= (others => '0');
    elsif clk_10hz'event and clk_10hz = '1' then
      if btn_up = '1' and vec_temp < 100 then
        vec_temp <= vec_temp + 1;
      elsif btn_down = '1' and vec_temp > 0 then
        vec_temp <= vec_temp - 1;
      end if;
    end if;
  end process;
  vecPWM <= vec_temp;

end architecture rtl;

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity M1_gen_PWM is
  
  port (
    CLK         : in  std_logic;        -- reloj de 100 MHz
    rst         : in  std_logic;        -- rst asincrono (nivel bajo)
    sw_Dir      : in  std_logic;        -- switch (1) para sentido de giro
    PWM_vector  : in  std_logic_vector (7 downto 0);  -- vector de ciclo de trabajo de 0 a 100%      
    pinDir      : out std_logic;        -- sentido giro del motor (PMOD)
    pinEn       : out std_logic;  -- salida PWM para el puente en H (PMOD)
    sel_display : out std_logic_vector (7 downto 0)
    );                                  -- señal PWM generada

end entity M1_gen_PWM;


architecture rtl of M1_gen_PWM is

  -------------------------------------------------------------------------------
  --PWM--
  -----------------------------------------------------------------------------
  signal cuenta       : unsigned(7 downto 0)  := "00000000";
  signal clk_2khz     : std_logic;
  signal pin_temp     : std_logic;
  signal pin_valor    : std_logic;
  signal pin_final    : std_logic;
  -----------------------------------------------------------------------------
  --RELOJ--
  -----------------------------------------------------------------------------
  signal temporal     : std_logic;
  --signal cont     : integer range 0 to 24_999 := 0; --cuenta real 2kHz
  signal cont     : integer range 0 to 249 := 0; --cuenta real 200kHz
  --signal cont         : integer range 0 to 11 := 0;  -- cuenta simulación 2MHz
  --constant FIN_CUENTA : integer               := 11;
  --constant FIN_CUENTA : integer               := 24_999;
  constant FIN_CUENTA : integer               := 249;
begin  -- architecture rtl
  -----------------------------------------------------------------------------
  --PRESCALER--
  -----------------------------------------------------------------------------

  reloj : process (CLK, rst) is
  begin  -- process reloj
    if rst = '0' then                   -- asynchronous reset (active low)
      temporal <= '1';
      cont     <= 0;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if cont = FIN_CUENTA then
        temporal <= not(temporal);
        cont     <= 0;
      else
        cont <= cont + 1;
      end if;
    end if;
  end process reloj;
  clk_2khz <= temporal;
  -----------------------------------------------------------------------------
  --PROCESO PWM--
  -----------------------------------------------------------------------------

  PWM : process (clk_2khz, rst) is
  begin  -- process PWM
    if rst = '0' then                   -- asynchronous reset (active low)
      cuenta <= (others => '0');
    elsif clk_2khz'event and clk_2khz = '1' then  -- rising clock edge
      if cuenta = 99 then
        cuenta <= (others => '0');
      else
        cuenta <= cuenta + 1;
      end if;
    end if;
    if cuenta < unsigned(PWM_vector)then
      pin_temp <= '1';
    else
      pin_temp <= '0';
    end if;
  end process PWM;
-------------------------------------------------------------------------------
  --PROCESO DIR--
-----------------------------------------------------------------------------
  Direccion : process (sw_Dir, rst) is
  begin  -- process Dirreccion
    if rst = '0' then
      pin_valor <= '0';
      pinDir    <= '0';
    elsif sw_Dir = '1' then
      pinDir    <= '1' after 10 ms;  --PONER 10 ms para real --sentencia  --transport no sintetizable
      pin_valor <= '0';
      pin_valor <= '1' after 20 ms;     --PONER 20 ms para real
    elsif sw_Dir = '0' then
      pinDir    <= '0' after 10 ms;     --PONER 10 ms para real
      pin_valor <= '0';
      pin_valor <= '1' after 20 ms;     --PONER 20 ms para real
    end if;
  end process Direccion;

  process (CLK, rst) is
  begin  -- process  
    if rst = '0' then
      pin_final <= '0';
    elsif CLK'event and CLK = '1' then
      if pin_valor = '0' then
        pin_final <= '0';
      else
        pin_final <= pin_temp;
      end if;
    end if;
  end process;
  pinEn <= pin_final;

end architecture rtl;

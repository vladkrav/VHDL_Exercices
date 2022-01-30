library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;


entity M1_M2_sel_gen_PWM is
  
  port (
    CLK         : in  std_logic;        -- reloj de 100 MHz
    rst         : in  std_logic;        -- rst asíncrono (nivel bajo)
    btn_up      : in  std_logic;        -- pulsador de incremento de D(%)
    btn_down    : in  std_logic;        -- pulsador de decremento de D(%)
    sw_Dir      : in  std_logic;        -- switch (1) para sentido de giro
    pinDir      : out std_logic;        -- sentido giro del motor (PMOD)
    pinEn       : out std_logic;  -- salida PWM para el puente en H (PMOD)
    sel_display : out std_logic_vector (7 downto 0)
    );                                  -- señal PWM generada

end entity M1_M2_sel_gen_PWM;




architecture rtl of M1_M2_sel_gen_PWM is


  component M1_gen_PWM is
    port (
      CLK         : in  std_logic;
      rst         : in  std_logic;
      sw_Dir      : in  std_logic;
      PWM_vector  : in  std_logic_vector (7 downto 0);
      pinDir      : out std_logic;
      pinEn       : out std_logic;
      sel_display : out std_logic_vector (7 downto 0));
  end component M1_gen_PWM;

  component M2_sel_PWM is
    port (
      CLK      : in  std_logic;
      rst      : in  std_logic;
      btn_up   : in  std_logic;
      btn_down : in  std_logic;
      vecPWM   : out std_logic_vector (7 downto 0));
  end component M2_sel_PWM;

  signal PWM_vector : std_logic_vector (7 downto 0);
  
  
begin  -- architecture rtl

  M1_gen_PWM_1 : entity work.M1_gen_PWM
    port map (
      CLK         => CLK,
      rst         => rst,
      sw_Dir      => sw_Dir,
      PWM_vector  => PWM_vector,
      pinDir      => pinDir,
      pinEn       => pinEn,
      sel_display => sel_display);

  M2_sel_PWM_1 : entity work.M2_sel_PWM
    port map (
      CLK      => CLK,
      rst      => rst,
      btn_up   => btn_up,
      btn_down => btn_down,
      vecPWM   => PWM_vector);

end architecture rtl;

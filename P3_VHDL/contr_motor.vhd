library ieee;
use ieee.STD_LOGIC_1164.all;

entity contr_motor is
  port (
    CLK         : in  std_logic;        -- reloj de 100 MHZ
    rst         : in  std_logic;        -- reset del sistema (nivel bajo)
    btn_up      : in  std_logic;        -- pulsador de incremento de D(%)
    btn_down    : in  std_logic;        -- pulsador de decremento de D(%)
    sw_Dir      : in  std_logic;        -- switch (1) para sentido de giro
    sw_sel_disp : in  std_logic;  -- switch (1) para selección de info-display
    pinSA       : in  std_logic;        -- entrada Sensor A Encoder (PMOD)
    pinSB       : in  std_logic;        -- entrada Sensor B Encoder (PMOD)
    pinEn       : out std_logic;  -- salida PWM para el puente en H (PMOD)
    pinDir      : out std_logic;        -- sentido giro del motor (PMOD)
    seg7_code   : out std_logic_vector (7 downto 0);   -- bus de 7 segmentos
    sel_display : out std_logic_vector (7 downto 0));  -- bus de anodos de los displays

end entity contr_motor;


architecture rtl of contr_motor is

  component M1_gen_PWM is
    port (
      CLK         : in  std_logic;
      rst         : in  std_logic;
      sw_Dir      : in  std_logic;
      PWM_vector  : in  std_logic_vector (7 downto 0);
      pinDir      : out std_logic;
      sel_display : out std_logic_vector (7 downto 0);
      pinEn       : out std_logic);
  end component M1_gen_PWM;

  component M2_sel_PWM is
    port (
      CLK      : in  std_logic;
      rst      : in  std_logic;
      btn_up   : in  std_logic;
      btn_down : in  std_logic;
      vecPWM   : out std_logic_vector (7 downto 0));
  end component M2_sel_PWM;

  component M3_visualiza is
    port (
      CLK         : in  std_logic;
      rst         : in  std_logic;
      PWM_vector  : in  std_logic_vector (7 downto 0);
      sw_Dir      : in  std_logic;
      sw_sel_disp : in  std_logic;
      velocidad   : in  std_logic_vector (7 downto 0);
      seg7_code   : out std_logic_vector (7 downto 0);
      sel_disp    : out std_logic_vector (7 downto 0));
  end component M3_visualiza;

  component M4_calc_veloc is
    port (
      clk       : in  std_logic;
      rst       : in  std_logic;
      pinSA     : in  std_logic;
      pinSB     : in  std_logic;
      velocidad : out std_logic_vector (7 downto 0));
  end component M4_calc_veloc;

  signal PWM_vector : std_logic_vector (7 downto 0);
  signal velocidad  : std_logic_vector (7 downto 0);
  
begin  -- architecture rtl

  M1_gen_PWM_1 : entity work.M1_gen_PWM
    port map (
      CLK         => CLK,
      rst         => rst,
      sw_Dir      => sw_Dir,
      PWM_vector  => PWM_vector,
      pinDir      => pinDir,
      sel_display => open,
      pinEn       => pinEn);

  M2_sel_PWM_1 : entity work.M2_sel_PWM
    port map (
      CLK      => CLK,
      rst      => rst,
      btn_up   => btn_up,
      btn_down => btn_down,
      vecPWM   => PWM_vector);

  M3_visualiza_1 : entity work.M3_visualiza
    port map (
      CLK         => CLK,
      rst         => rst,
      PWM_vector  => PWM_vector,
      sw_Dir      => sw_Dir,
      sw_sel_disp => sw_sel_disp,
      velocidad   => velocidad,
      seg7_code   => seg7_code,
      sel_disp    => sel_display);

  M4_calc_veloc_1 : entity work.M4_calc_veloc
    port map (
      clk       => clk,
      rst       => rst,
      pinSA     => pinSA,
      pinSB     => pinSB,
      velocidad => velocidad);
  
end architecture rtl;

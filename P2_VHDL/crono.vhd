library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.std_logic_unsigned.all;



-------------------------------------------------------------------------------
-- OJO LA FRECUENCIA DE LA NEXYS 4 ES 100 MHZ
-------------------------------------------------------------------------------

entity crono is
  port (
    lapso       : in  std_logic;
    rst_n       : in  std_logic;
    clk         : in  std_logic;
    sel_display : out std_logic_vector(7 downto 0);
    led_out     : out std_logic_vector (7 downto 0);
    seg7_code   : out std_logic_vector(7 downto 0));

end crono;

architecture rtl of crono is

  component regs_FSM is
    port (
      lapso       : in  std_logic;
      rst         : in  std_logic;
      clk         : in  std_logic;
      EN_1KHZ     : in  std_logic;
      EN_1HZ      : in  std_logic;
      leds        : out std_logic_vector (7 downto 0);
      sel_display : out std_logic_vector(7 downto 0);
      seg7_code   : out std_logic_vector(7 downto 0));
  end component regs_FSM;


  component reloj is
    port (
      CLK     : in  std_logic;
      RST     : in  std_logic;
      EN_1KHZ : out std_logic;
      EN_1HZ  : out std_logic);

  end component reloj;



-- Declaracion senales intermedias

  signal rst     : std_logic;
  signal en_1khz : std_logic;
  signal EN_1HZ  : std_logic;
  signal leds    : std_logic_vector (7 downto 0);  


begin
  -- creacion de la señal de reset negada
  rst <= not rst_n;
  
  -- Instanciación de los componentes necesarios para 
  -- la generación de reloj
  reloj_1 : RELOJ
    port map (
      CLK     => CLK,
      RST     => RST,
      EN_1KHZ => EN_1KHZ,
      EN_1HZ  => EN_1HZ);


  -- instanciacion de regs_FSM
  regs_FSM_1 : regs_FSM
    port map (
      lapso       => lapso,
      rst         => rst,
      clk         => clk,
      EN_1KHZ     => EN_1KHZ,
      EN_1HZ      => EN_1HZ,
      leds        => leds,
      sel_display => sel_display,
      seg7_code   => seg7_code);


 sel_display(7 downto 4) <= "1111";    -- Deshabilito los 4 DISPLAYS MSB

end rtl;




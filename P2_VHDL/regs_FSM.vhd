library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity regs_FSM is
  port (
    lapso       : in  std_logic;
    rst         : in  std_logic;
    clk         : in  std_logic;
    EN_1KHZ     : in  std_logic;
    EN_1HZ      : in  std_logic;
    leds        : out std_logic_vector (7 downto 0);  -- leds para debug
    sel_display : out std_logic_vector(7 downto 0);
    seg7_code   : out std_logic_vector(7 downto 0));  -- valor en 7 segmentos 

end regs_FSM;


architecture comportamiento of regs_FSM is


  -- declaracion de maq_FSM
  component maq_FSM
    port (
      clk        : in  std_logic;       -- clk maestro
      rst        : in  std_logic;       -- reset del sistema
      lapso      : in  std_logic;       -- pulsador lapso
      actualizar : out std_logic);      -- si se actualizan los displays 
  end component;


  -- declaracion de mux_displays
  component mux_displays
    port (
      clk     : in std_logic;           -- master clock
      EN_1KHZ : in std_logic;           -- habilitacion cada 1KHz
      rst     : in std_logic;           -- reset del sistema

      unidades : in std_logic_vector(3 downto 0);  -- valores bcd
      decenas  : in std_logic_vector(3 downto 0);

      seg7_code   : out std_logic_vector(7 downto 0);
      sel_display : out std_logic_vector(7 downto 0)  -- seleccion del display activo
      );
  end component;


  signal unidades   : std_logic_vector(3 downto 0);
  signal decenas    : std_logic_vector(3 downto 0);
  signal actualizar : std_logic;
  signal leds_i     : unsigned (7 downto 0);

  signal CntUnidades : unsigned (3 downto 0);
  signal CntDecenas  : unsigned (3 downto 0);

begin

  -- instanciacion de maq_FSM
  U1 : maq_FSM
    port map (
      clk        => clk,
      rst        => rst,
      lapso      => lapso,
      actualizar => actualizar);

  -- instanciacion de mux_displays
  U2 : mux_displays
    port map (
      clk         => clk,               -- master clock
      EN_1KHZ     => EN_1KHZ,           -- habilitacion cada 1KHz
      rst         => rst,
      unidades    => unidades,
      decenas     => decenas,
      seg7_code   => seg7_code,
      sel_display => sel_display);
      
-- Conteo de segundos (decenas + unidades)
  conta_seg : process (EN_1HZ, rst) is
  begin  -- process conta_seg
    if rst = '1' then                   -- asynchronous reset (active low)
      CntUnidades <= (others => '0');
      CntDecenas  <= (others => '0');
    elsif EN_1HZ'event and EN_1HZ = '1' then  -- rising clock edge
      if CntUnidades < 9 then
        CntUnidades <= CntUnidades + 1;
      else
        CntUnidades <= (others => '0');
        CntDecenas  <= CntDecenas + 1;
      end if;
      if CntUnidades = 0 and CntDecenas = 6 then
        CntUnidades <= (others => '0');
        CntDecenas  <= (others => '0');
      end if;
    end if;
  end process conta_seg;

-- Proceso de registros de lapso.
  process(clk, rst)
  begin
    if (rst = '1') then
      actualizar <= '0';
    elsif(clk'event and clk = '1') then
      if actualizar = '0' then
        unidades <= std_logic_vector(CntUnidades);
        decenas  <= std_logic_vector(CntDecenas);
      else
        unidades <= unidades;
        decenas  <= decenas;
      end if;
    end if;
  end process;

  leds <= std_logic_vector(leds_i);

end comportamiento;

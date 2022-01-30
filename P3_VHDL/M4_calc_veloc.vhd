library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity M4_calc_veloc is
  port (
    clk       : in  std_logic;          -- reloj de 100 MHZ
    rst       : in  std_logic;          -- reset del sistema (nivel bajo)
    pinSA     : in  std_logic;          -- entrada Sensor A Encoder (PMOD)
    pinSB     : in  std_logic;          -- entrada Sensor B Encoder (PMOD)
    velocidad : out std_logic_vector (7 downto 0)); 
end entity M4_calc_veloc;

architecture rtl of M4_calc_veloc is

  signal SA1          : std_logic;      -- señal de salida del 1 biestable
  signal SA2          : std_logic;      -- señal de salida del 2 biestable
  signal SA3          : std_logic;      -- señal de salida del 3 biestable
  signal var_pulso    : std_logic;  -- Variable que indica si se ha sumado un pulso
  signal var_cont     : std_logic;  -- Variable que permite que se sume un pulso
  signal var_rst      : std_logic;
  signal var_cont2    : std_logic;
  signal rst2         : std_logic;
  signal npulsos      : unsigned(8 downto 0);
  signal resultado    : std_logic_vector(11 downto 0);
  signal temporal     : std_logic;
  signal cont         : integer range 0 to 12_499_999 := 0;  --cuenta real 4Hz=0.25seg
  --signal cont           : integer range 0 to 6249 := 0;  -- cuenta simulación 4kHz
  --constant FIN_CUENTA   : integer                := 6249;
  constant FIN_CUENTA : integer                       := 12_499_999;
  signal clk_4hz      : std_logic;

  component multiplicador is
    port (
      clk      : in  std_logic;
      rst      : in  std_logic;
      dato_A   : in  std_logic_vector(8 downto 0);
      dato_B   : in  std_logic_vector(2 downto 0);
      producto : out std_logic_vector(11 downto 0));
  end component multiplicador;


begin  -- architecture rtl
  ---------------------------------------------------------------
  --PRESCALER--
  ---------------------------------------------------------------
  reloj : process (CLK, rst) is
  begin  -- process reloj
    if rst = '0' then  -- asynchronous reset (active low)      
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
  clk_4hz <= temporal;

  ---------------------------------------------------------------------------
  --GENERACION DE SEÑAL DE RESET DE VARIABLES (SA1,SA2,SA3 Y N_PULSOS)--
  ---------------------------------------------------------------------------

  process (CLK, rst) is
  begin  -- process
    if rst = '0' then
      var_rst   <= '1';
      var_cont2 <= '1';
    elsif CLK'event and CLK = '1' then
      if clk_4hz = '1' and var_cont2 = '1' then
        var_rst   <= '0';
        var_cont2 <= '0';
      elsif clk_4hz = '1' and var_cont2 = '0' then
        var_rst <= '1';
      else
        var_rst   <= '1';
        var_cont2 <= '1';
      end if;
    end if;
  end process;
  rst2 <= rst and var_rst;
  -------------------------------------------------------------
  --REGISTROS--
  -------------------------------------------------------------

  Registro : process (CLK, rst2) is
  begin  -- process Registro1
    if rst2 = '0' then
      SA1 <= '0';
      SA2 <= '0';
      SA3 <= '0';
    elsif CLK'event and CLK = '1' then
      SA1 <= pinSA;
      SA2 <= SA1;
      SA3 <= SA2;
    end if;
  end process Registro;

------------------------------------------------------------------------------
--HABILITACION DE CONTADOR DE PUSLOS--
------------------------------------------------------------------------------ 

  process (CLK, rst) is
  begin  -- process
    if rst = '0' then
      var_cont <= '0';
    elsif CLK'event and CLK = '0' then
      if SA1 = '1' and var_pulso = '1' then
        var_cont <= '1';
      elsif SA1 = '0' then
        var_cont <= '0';
      end if;
    end if;
  end process;
  -----------------------------------------------------------------------------
  --CONTADOR DE PULSOS--
  -----------------------------------------------------------------------------

  process (CLK, rst2) is
  begin  -- process
    if rst2 = '0' then
      npulsos <= (others => '0');
    elsif CLK'event and CLK = '1' then
      if SA1 = '1' and SA2 = '1' and SA3 = '1' and var_cont = '0' then
        npulsos   <= npulsos + 1;
        var_pulso <= '1';
      else
        var_pulso <= '0';
      end if;
    end if;
  end process;


  cto_multiplicador : multiplicador
    port map (
      clk      => CLK,
      rst      => rst,
      dato_A   => std_logic_vector(npulsos),
      dato_B   => "011",
      producto => resultado);
  
  -----------------------------------------------------------------------------
  --VELOCIDAD--
  -----------------------------------------------------------------------------

  process (clk_4hz, rst) is
  begin  -- process clk,rst
    if rst = '0' then
      velocidad <= (others => '0');
    elsif clk_4hz'event and clk_4hz = '1' then
      velocidad <= resultado(8 downto 1);
    end if;
  end process;
  
end architecture rtl;

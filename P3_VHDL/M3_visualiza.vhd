library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;


entity M3_visualiza is
  
  port (
    CLK         : in  std_logic;        -- reloj de 100 MHz
    rst         : in  std_logic;        -- rst asíncrono (nivel bajo)
    PWM_vector  : in  std_logic_vector (7 downto 0);  -- vector de ciclo de trabajo
    sw_Dir      : in  std_logic;        -- switch (1) para sentido de giro
    sw_sel_disp : in  std_logic;  -- switch (1) para selección de info-display
    velocidad   : in  std_logic_vector (7 downto 0);
    seg7_code   : out std_logic_vector (7 downto 0);  -- bus de 7 segmentos
    sel_disp    : out std_logic_vector (7 downto 0)  -- bus de anodos de los displays
    );

end entity M3_visualiza;


architecture rtl of M3_visualiza is

  component hex2bcd is
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      hex_in  : in  std_logic_vector(7 downto 0);
      bcd_hun : out std_logic_vector(3 downto 0);
      bcd_ten : out std_logic_vector(3 downto 0);
      bcd_uni : out std_logic_vector(3 downto 0));
  end component hex2bcd;

  component bcd2seg is
    port (
      bcd     : in  std_logic_vector(3 downto 0);
      display : out std_logic_vector(7 downto 0));
  end component bcd2seg;

  -----------------------------------------------------------------------------
  --Señales--
  -----------------------------------------------------------------------------
  signal unidades     : std_logic_vector(3 downto 0);
  signal decenas      : std_logic_vector(3 downto 0);
  signal centenas     : std_logic_vector(3 downto 0);
  signal bcd_code     : std_logic_vector(3 downto 0);
  signal vector       : std_logic_vector(7 downto 0);
  signal sel          : std_logic_vector(1 downto 0);
  signal aux          : std_logic;
  -----------------------------------------------------------------------------
  --reloj 1khz--
  -----------------------------------------------------------------------------
  signal temporal     : std_logic;
  signal cont     : integer range 0 to 49_999 := 0; --cuenta real 1kHz
  --signal cont         : integer range 0 to 24 := 0;  -- cuenta simulación 1MHz
  --constant FIN_CUENTA : integer               := 24;
  constant FIN_CUENTA : integer               := 49_999;
  signal clk_1khz     : std_logic;
  
begin  -- architecture rtl

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
  clk_1khz <= temporal;
  -----------------------------------------------------------------------------
  --VISUALIZACION EN LOS DISPLAYS--
  -----------------------------------------------------------------------------

  process(clk_1khz, rst) is
  begin
    if rst = '0' then
      sel <= "00";
    elsif clk_1khz'event and clk_1khz = '1' then
      if sel = "00" then
        bcd_code             <= unidades;
        sel_disp(3 downto 0) <= "1110";
        sel                  <= "01";
      elsif sel = "01" then
        bcd_code             <= decenas;
        sel_disp(3 downto 0) <= "1101";
        sel                  <= "10";
      elsif sel = "10" then
        bcd_code             <= centenas;
        sel_disp(3 downto 0) <= "1011";
        sel                  <= "11";
      elsif sel = "11" then
        if aux = '1' then
          bcd_code             <= "1111";
          sel_disp(3 downto 0) <= "0111";
          sel                  <= "00";
        else
          bcd_code             <= "1010";
          sel_disp(3 downto 0) <= "0111";
          sel                  <= "00";
        end if;
      end if;
    end if;
  end process;
-------------------------------------------------------------------------------
  --SELECCION DE VISUALIZACION--
-------------------------------------------------------------------------------
  sw_disp : process (sw_sel_disp, clk) is
  begin  -- process sw_disp
    if rst = '0' then
      vector(7 downto 0) <= PWM_vector(7 downto 0);
    elsif CLK'event and CLK = '1' then
      if sw_sel_disp = '1' then
        vector(7 downto 0) <= PWM_vector(7 downto 0);
      else
        vector(7 downto 0) <= velocidad(7 downto 0);
      end if;
    end if;
  end process sw_disp;
-------------------------------------------------------------------------------
  --SIGNO MENOS--
  -----------------------------------------------------------------------------
  process (sw_Dir, clk, rst) is
  begin  -- process vis
    if rst = '0' then
      aux <= '0';
    elsif CLK'event and CLK = '1' then
      if sw_Dir = '1' then
        aux <= '0';
      else
        aux <= '1';
      end if;
    end if;
  end process;

  --  decodificador BCD a 7 segmentos.
  cto_visualizar : bcd2seg
    port map (
      bcd     => bcd_code,
      display => seg7_code);

  cto_convertir : hex2bcd
    port map (
      clk     => clk,
      rst     => rst,
      hex_in  => vector,
      bcd_hun => centenas,
      bcd_ten => decenas,
      bcd_uni => unidades);

  sel_disp(7 downto 4) <= "1111";       -- Deshabilito los 4 DISPLAYS MSB
  
end architecture rtl;

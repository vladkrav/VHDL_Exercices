library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity mux_displays is
  port (
    clk     : in std_logic;             -- master clock
    EN_1KHZ : in std_logic;             -- habilitacion cada 1KHz
    rst     : in std_logic;
    unidades : in std_logic_vector(3 downto 0);  -- valores bcd
    decenas  : in std_logic_vector(3 downto 0);
    seg7_code   : out std_logic_vector(7 downto 0);  --meter al display para que se ilumine
    sel_display : out std_logic_vector(7 downto 0)  -- seleccion del display activo
    );                                  -- fin de port
end mux_displays;

-- Control de la multiplexación de los displays.
architecture multiplexacion of mux_displays is
  
  signal bcd_code : std_logic_vector(3 downto 0);
  signal sel      : std_logic;
  -- Declaración del decodificador BCD a 7 segmentos.
  component bcd2seg
    port(
      bcd     : in  std_logic_vector (3 downto 0);
      display : out std_logic_vector (7 downto 0));  -- valor 7seg
  end component;

  
begin

  -- multiplexacion de sel_display
  -- hay que contar KHz y cada ms multiplexar la entrada bcd_code
  -- (unidades->decenas->blanco->blanco->unidades ...)
  process(EN_1KHZ, rst) is
  begin 
    if rst = '1' then
      sel <= '0';
    elsif EN_1KHZ'event and EN_1KHZ = '1' then
      if sel = '0' then
        bcd_code                <= unidades;
        sel_display(3 downto 0) <= "1110";
        sel                     <= '1';
      elsif sel = '1' then
        bcd_code                <= decenas;
        sel_display(3 downto 0) <= "1101";
        sel                     <= '0';
      end if;
    end if;
  end process;

--  decodificador BCD a 7 segmentos.
  cto_visualizar : bcd2seg
    port map (
      bcd     => bcd_code,
      display => seg7_code);

end multiplexacion;

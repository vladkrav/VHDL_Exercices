library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reloj is
  
  port (
    clk     : in  std_logic;            -- reloj de 100MHz
    rst     : in  std_logic;            -- Reset
    EN_1HZ  : out std_logic;            -- reloj 1Hz
    EN_1KHZ : out std_logic);           --reloj 1kHz
end entity reloj;

architecture rtl of reloj is
  
  constant max_cont  : integer   := 49_999;  -- Frecuencias de 1Hz
  --constant max_cont  : integer   := 4999;  -- Frecuencia de 20kHz
  signal cont        : integer range 0 to max_cont;
  signal clk_state   : std_logic := '0';
  signal refres_cont : integer range 0 to 49_999;
  signal temporal    : std_logic := '0';
  
begin
  
  clock : process (clk, rst) is
  begin  -- process clock
    if (rst = '1') then                 -- asynchronous reset (active low)
      cont        <= 0;
      temporal    <= '0';
      clk_state   <= '0';
      refres_cont <= 0;
      
    elsif (clk'event and clk = '1') then  -- rising clock edge
      if (cont < max_cont) then
        cont <= cont+1;
      else
        clk_state <= not clk_state;
        cont      <= 0;
      end if;
    end if;

    --calculo del frecuencia 1khz
    if (refres_cont = 49999) then
      temporal    <= not(temporal);
      refres_cont <= 0;
    else
      refres_cont <= refres_cont +1;
    end if;
  end process clock;

  EN_1HZ  <= std_logic(clk_state);
  EN_1KHZ <= std_logic(temporal);

end architecture rtl;

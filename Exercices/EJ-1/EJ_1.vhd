library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prog_counter is
  port (
    clr     : in  std_logic;
    clk     : in  std_logic;
    cnt_max : in  std_logic_vector(3 downto 0);
    cnt_min : in  std_logic_vector(3 downto 0);
    enable  : in  std_logic;
    cnt     : out std_logic_vector(3 downto 0);
    tc      : out std_logic;
    ceo     : out std_logic);
end entity;

architecture cuestion_1 of prog_counter is
  signal inicio : unsigned(3 downto 0);
  signal final  : unsigned(3 downto 0);

begin  -- architecture cuestion_1
  
  contador : process (clk, clr) is
  begin  -- process contador
    if clr = '0' then                   -- asynchronous reset (active low)
      inicio <= unsigned(cnt_min);
      final  <= unsigned(cnt_max);
      tc     <= '0';
      ceo    <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if enable = '1' then
        if inicio < final then
          tc     <= '0';
          inicio <= inicio + 1;
          ceo    <= '0';
        else
          inicio <= unsigned(cnt_min);
          final  <= unsigned(cnt_max);
          tc     <= '1';
          ceo    <= '1';
        end if;
      end if;
    end if;
  end process contador;
  cnt <= std_logic_vector(inicio);

end architecture cuestion_1;

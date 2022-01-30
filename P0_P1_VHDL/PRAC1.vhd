library ieee;
use ieee.std_logic_1164.all;

entity prac1 is

  port (
    clk     : in  std_logic;
    rst     : in  std_logic;
    sel     : in  std_logic;
    out_mux : out std_logic_vector(1 downto 0));

end entity prac1;

architecture rtl of prac1 is

  signal in1_mux : std_logic_vector (1 downto 0);
  signal in2_mux : std_logic_vector(1 downto 0);

  component contador2b is
    port (
      rst     : in  std_logic;
      clk     : in  std_logic;
      out_cnt : out std_logic_vector (1 downto 0));
  end component contador2b;
  
begin  -- architecture rtl

  conta1 : contador2b
    port map(
      rst     => rst,
      clk     => clk,
      out_cnt => in1_mux);

  process (clk, rst) is
  begin  -- process

    if rst = '1' then                   -- asynchronous reset (active low)
      in2_mux <= (others => '0');

    elsif clk'event and clk = '1' then  -- rising clock edge
      in2_mux <= in1_mux;
    end if;

  end process;

  process (sel, in1_mux, in2_mux) is
  begin  -- process

    if sel = '0' then
      out_mux <= in1_mux;

    elsif sel = '1' then
      out_mux <= in2_mux;
    end if;
  end process;

end architecture rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity xxx is
  port (
    din    : in  std_logic_vector(7 downto 0);
    n_bits : in  std_logic_vector(2 downto 0);
    dout   : out std_logic_vector(7 downto 0)); 
end xxx;
architecture rtl of xxx is
  signal tap_2 : std_logic_vector(7 downto 0);
  signal tap_1 : std_logic_vector(7 downto 0);
  signal tap_0 : std_logic_vector(7 downto 0);
  function rotate_bits (
    x      : std_logic_vector(0 to 7);
    n_bits : natural
    ) return std_logic_vector is 
    variable n   : natural := n_bits rem 8;
    variable aux : std_logic_vector(0 to 7);
  begin
    if (n = 0) then
      aux := x;
    else aux := x(n to 7) & x(0 to n-1);
    end if;
    return aux;
  end rotate_bits;
begin
  tap_0 <= rotate_bits(din, 4)   when (n_bits(2) = '1') else din;
  tap_1 <= rotate_bits(tap_0, 2) when (n_bits(1) = '1') else tap_0;
  tap_2 <= rotate_bits(tap_1, 1) when (n_bits(0) = '1') else tap_1;
  dout  <= tap_2;
end rtl;

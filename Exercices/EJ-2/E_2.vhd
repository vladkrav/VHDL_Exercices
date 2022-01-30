library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux is
  port (
    din    : in  std_logic_vector(3 downto 0);
    sel    : in  std_logic_vector(1 downto 0);
    enable : in  std_logic;
    dout   : out std_logic);
end entity;
architecture rtl of mux is
begin
  process(din, sel, enable)
    constant N : integer := din'length;
  begin
    if (enable = '1') then
--      for i in 0 to N-1 loop
--        if(i = unsigned(sel)) then
--          dout <= din((i));
--        end if;
--      end loop;
        case sel is 
        when "00" => dout <= din(0);
        when "01" => dout <= din(1);
        when "10" => dout <= din(2);
        when "11" => dout <= din(3);
        when others => dout <= '0';
        end case;
    end if;
  end process;
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bin2gray is
  generic (N : integer);
  port (
    b : in  std_logic_vector(N-1 downto 0);
    g : out std_logic_vector(N-1 downto 0)); 
end entity;

architecture bin_to_gray of bin2gray is
 signal temp : std_logic_vector (N-1 downto 0);
begin  -- architecture bin_to_gray
    g(N-1) <= b(N-1);
  gray_gen : for i in 0 to N-2 generate
    begin
       g(i) <= b(i) xor b(i+1);
      -- g(i) := b(i) xor ('0' & b(N-1 downto 1));
    end generate;
    --g <= temp;

end architecture bin_to_gray;

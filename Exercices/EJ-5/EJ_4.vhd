library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity gray_cnt is
  generic (
    N : integer := 4); 
  port (
    rst      : in  std_logic;
    clk      : in  std_logic;
    enable   : in  std_logic;
    cnt_gray : out std_logic_vector(N-1 downto 0)); 
end entity;
architecture rtl of gray_cnt is
  signal cnt_bin       : unsigned(N-1 downto 0);
  signal next_cnt_bin  : unsigned(N-1 downto 0);
  signal next_cnt_gray : std_logic_vector(N-1 downto 0);
begin
  next_cnt_bin <= cnt_bin + 1;
  process(clk, rst)
  begin
    if (rst = '1') then
      cnt_bin <= (others => '0');
    elsif(clk'event and clk = '1') then
      if (enable = '1') then
        cnt_bin <= next_cnt_bin;
      end if;
    end if;
  end process;
  BIN2GRAY_I : entity work.bin2gray
    generic map (
      N => N) 
    port map (
      b => std_logic_vector(next_cnt_bin),
      g => next_cnt_gray);
  process(clk, rst)
  begin
    if (rst = '1') then
      cnt_gray <= (others => '0');
    elsif(clk'event and clk = '1') then
      if (enable = '1') then
        cnt_gray <= next_cnt_gray;
      end if;
    end if;
  end process;
end rtl;

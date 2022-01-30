-------------------------------------------------------------------------------
-- Title      : Testbench for design "xxx"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : xxx_tb.vhd
-- Author     : VLAD
-- Company    : 
-- Created    : 2019-01-03
-- Last update: 2019-01-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-01-03  1.0      Vlad    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity xxx_tb is

end entity xxx_tb;

-------------------------------------------------------------------------------

architecture ej of xxx_tb is

  -- component ports
  signal din    : std_logic_vector(7 downto 0);
  signal n_bits : std_logic_vector(2 downto 0);
  signal dout   : std_logic_vector(7 downto 0);

  component xxx is
    port (
      din    : in  std_logic_vector(7 downto 0);
      n_bits : in  std_logic_vector(2 downto 0);
      dout   : out std_logic_vector(7 downto 0));
  end component xxx;
  
  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture ej

  -- component instantiation
  DUT : entity work.xxx
    port map (
      din    => din,
      n_bits => n_bits,
      dout   => dout);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    n_bits <= "000";
    din    <= "00000011";
    wait for 300 ns;
    n_bits <= "001";
    din    <= "00000011";
    wait for 300 ns;
    n_bits <= "010";
    din    <= "00000011";
    wait for 300 ns;
    n_bits <= "011";
    din    <= "00000011";
    wait for 300 ns;
    n_bits <= "111";
    din    <= "00000011";
    wait for 300 ns;

    wait until Clk = '1';

  end process WaveGen_Proc;

end architecture ej;

-------------------------------------------------------------------------------

configuration xxx_tb_ej_cfg of xxx_tb is
  for ej
  end for;
end xxx_tb_ej_cfg;

-------------------------------------------------------------------------------

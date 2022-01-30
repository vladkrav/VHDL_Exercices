-------------------------------------------------------------------------------
-- Title      : Testbench for design "bin2gray"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : bin2gray_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-12-28
-- Last update: 2018-12-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-12-28  1.0      Vlad95	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity bin2gray_tb is

end entity bin2gray_tb;

-------------------------------------------------------------------------------

architecture EJ_3 of bin2gray_tb is

  -- component generics
  constant N : integer := 4;

  -- component ports
  signal b : std_logic_vector(N-1 downto 0);
  signal g : std_logic_vector(N-1 downto 0);

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture EJ_3

  -- component instantiation
  DUT: entity work.bin2gray
    generic map (
      N => N)
    port map (
      b => b,
      g => g);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
    b <= "0101";
    wait for 200 ns;
    b <= "1111";
    wait for 200 ns;
    b <= "0011";
    wait for 200 ns;
    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture EJ_3;

-------------------------------------------------------------------------------

configuration bin2gray_tb_EJ_3_cfg of bin2gray_tb is
  for EJ_3
  end for;
end bin2gray_tb_EJ_3_cfg;

-------------------------------------------------------------------------------

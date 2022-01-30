-------------------------------------------------------------------------------
-- Title      : Testbench for design "gray_cnt"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : gray_cnt_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-12-29
-- Last update: 2018-12-29
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-12-29  1.0      Vlad95	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity gray_cnt_tb is

end entity gray_cnt_tb;

-------------------------------------------------------------------------------

architecture gray of gray_cnt_tb is

  -- component generics
  constant N : integer := 4;

  -- component ports
  signal rst      : std_logic;
  --signal clk      : std_logic;
  signal enable   : std_logic;
  signal cnt_gray : std_logic_vector(N-1 downto 0);

  component gray_cnt is
    generic (
      N : integer);
    port (
      rst      : in  std_logic;
      clk      : in  std_logic;
      enable   : in  std_logic;
      cnt_gray : out std_logic_vector(N-1 downto 0));
  end component gray_cnt;
  
  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture gray

  -- component instantiation
  DUT: entity work.gray_cnt
    generic map (
      N => N)
    port map (
      rst      => rst,
      clk      => clk,
      enable   => enable,
      cnt_gray => cnt_gray);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
rst <= '1';
enable <= '1';
wait for 10 ns;
rst <= '0';
wait for 45 ns;
enable <= '0';
wait for 40 ns;
enable <= '1';
wait;
    
    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture gray;

-------------------------------------------------------------------------------

configuration gray_cnt_tb_gray_cfg of gray_cnt_tb is
  for gray
  end for;
end gray_cnt_tb_gray_cfg;

-------------------------------------------------------------------------------

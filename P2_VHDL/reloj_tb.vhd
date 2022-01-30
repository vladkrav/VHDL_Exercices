-------------------------------------------------------------------------------
-- Title      : Testbench for design "reloj"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : reloj_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-10-20
-- Last update: 2018-10-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-10-20  1.0      Vlad95	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity reloj_tb is

end entity reloj_tb;

-------------------------------------------------------------------------------

architecture reloj of reloj_tb is

  -- component ports
 -- signal clk     : std_logic;
  signal rst     : std_logic;
  signal EN_1HZ  : std_logic;
  signal EN_1KHZ : std_logic;

  -- clock
  signal Clk : std_logic := '1';


  component reloj is
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      EN_1HZ  : out std_logic;
      EN_1KHZ : out std_logic);
  end component reloj;
  
begin  -- architecture reloj

  -- component instantiation
  DUT: entity work.reloj
    port map (
      clk     => clk,
      rst     => rst,
      EN_1HZ  => EN_1HZ,
      EN_1KHZ => EN_1KHZ);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait;
    
    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture reloj;

-------------------------------------------------------------------------------

configuration reloj_tb_reloj_cfg of reloj_tb is
  for reloj
  end for;
end reloj_tb_reloj_cfg;

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Title      : Testbench for design "prac1"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : prac1_tb.vhd
-- Author     :   <Alumno@PC08-L6>
-- Company    : 
-- Created    : 2018-10-11
-- Last update: 2018-10-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-10-11  1.0      Alumno	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity prac1_tb is

end entity prac1_tb;

-------------------------------------------------------------------------------

architecture tst of prac1_tb is

  -- component ports
  --signal clk     : std_logic;
  signal rst     : std_logic;
  signal sel     : std_logic;
  signal out_mux : std_logic_vector(1 downto 0);

  -- clock
  signal Clk : std_logic := '1';

  component prac1 is
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      sel     : in  std_logic;
      out_mux : out std_logic_vector(1 downto 0));
  end component prac1;
  
begin  -- architecture tst

  -- component instantiation
  DUT: entity work.prac1
    port map (
      clk     => clk,
      rst     => rst,
      sel     => sel,
      out_mux => out_mux);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
    rst <= '1';
    sel <= '0';
    wait for 100 ns;
    rst <= '0';
    sel <= '1';
    wait;
    
    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture tst;

-------------------------------------------------------------------------------

configuration prac1_tb_tst_cfg of prac1_tb is
  for tst
  end for;
end prac1_tb_tst_cfg;

-------------------------------------------------------------------------------

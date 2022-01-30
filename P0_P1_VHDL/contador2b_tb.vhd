-------------------------------------------------------------------------------
-- Title      : Testbench for design "contador2b"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : contador2b_tb.vhd
-- Author     :   <Nacho@DESKTOP-5F83GTL>
-- Company    : 
-- Created    : 2018-10-04
-- Last update: 2018-10-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-10-04  1.0      Nacho   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity contador2b_tb is

end entity contador2b_tb;

-------------------------------------------------------------------------------

architecture sim of contador2b_tb is

  -- component ports
  signal rst_i     : std_logic;
  signal clk_i     : std_logic := '0';
  signal out_cnt_i : std_logic_vector (1 downto 0);

  constant TCLK : time := 20 ns;


begin  -- architecture sim

  -- component instantiation
  DUT : entity work.contador2b
    port map (
      rst     => rst_i,
      clk     => clk_i,
      out_cnt => out_cnt_i);

  -- clock generation
  clk_i <= not clk_i after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst_i <= '1';
    wait for 101 ns;

    rst_i <= '0';
    wait;
 
  end process WaveGen_Proc;

  

end architecture sim;

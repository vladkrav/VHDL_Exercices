-------------------------------------------------------------------------------
-- Title      : Testbench for design "mux"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : mux_tb.vhd
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
-- 2018-12-28  1.0      Vlad95  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity mux_tb is

end entity mux_tb;

-------------------------------------------------------------------------------

architecture EJ2 of mux_tb is

  -- component ports
  signal din    : std_logic_vector(3 downto 0);
  signal sel    : std_logic_vector(1 downto 0);
  signal enable : std_logic;
  signal dout   : std_logic;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture EJ2

  -- component instantiation
  DUT : entity work.mux
    port map (
      din    => din,
      sel    => sel,
      enable => enable,
      dout   => dout);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    enable <= '0';
    wait for 100 ns;
    enable <= '1';
    wait for 100 ns;
    din    <= "0101";
    sel    <= "10";
    wait for 200 ns;
    sel    <= "11";
    wait for 200 ns;
    sel    <= "01";
    wait for 200 ns;
    sel    <= "00";
    wait;

    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture EJ2;

-------------------------------------------------------------------------------

configuration mux_tb_EJ2_cfg of mux_tb is
  for EJ2
  end for;
end mux_tb_EJ2_cfg;

-------------------------------------------------------------------------------

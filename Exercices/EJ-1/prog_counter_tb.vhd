-------------------------------------------------------------------------------
-- Title      : Testbench for design "prog_counter"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : prog_counter_tb.vhd
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
-- 2018-12-29  1.0      Vlad95  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity prog_counter_tb is

end entity prog_counter_tb;

-------------------------------------------------------------------------------

architecture contador of prog_counter_tb is

  -- component ports
  signal clr     : std_logic;
--  signal clk     : std_logic;
  signal cnt_max : std_logic_vector(3 downto 0);
  signal cnt_min : std_logic_vector(3 downto 0);
  signal enable  : std_logic;
  signal cnt     : std_logic_vector(3 downto 0);
  signal tc      : std_logic;
  signal ceo     : std_logic;

  component prog_counter is
    port (
      clr     : in  std_logic;
      clk     : in  std_logic;
      cnt_max : in  std_logic_vector(3 downto 0);
      cnt_min : in  std_logic_vector(3 downto 0);
      enable  : in  std_logic;
      cnt     : out std_logic_vector(3 downto 0);
      tc      : out std_logic;
      ceo     : out std_logic);
  end component prog_counter;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture contador

  -- component instantiation
  DUT : entity work.prog_counter
    port map (
      clr     => clr,
      clk     => clk,
      cnt_max => cnt_max,
      cnt_min => cnt_min,
      enable  => enable,
      cnt     => cnt,
      tc      => tc,
      ceo     => ceo);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    clr     <= '0';
    cnt_min <= "0101";
    cnt_max <= "1011";
    wait for 40 ns;
    enable <= '1';
    clr    <= '1';
    wait for 400 ns;
    cnt_min <= "0000";
    cnt_max <= "1111";
    wait for 400 ns;

    wait;


    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture contador;

-------------------------------------------------------------------------------

configuration prog_counter_tb_contador_cfg of prog_counter_tb is
  for contador
  end for;
end prog_counter_tb_contador_cfg;

-------------------------------------------------------------------------------

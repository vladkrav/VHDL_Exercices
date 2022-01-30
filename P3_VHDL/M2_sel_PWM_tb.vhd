-------------------------------------------------------------------------------
-- Title      : Testbench for design "M2_sel_PWM"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : M2_sel_PWM_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-12-03
-- Last update: 2019-01-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-12-03  1.0      Vlad95  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-------------------------------------------------------------------------------

entity M2_sel_PWM_tb is

end entity M2_sel_PWM_tb;

-------------------------------------------------------------------------------

architecture PWM of M2_sel_PWM_tb is

  -- component ports
  -- signal CLK      : std_logic;
  signal rst      : std_logic;
  signal btn_up   : std_logic;
  signal btn_down : std_logic;
  signal vecPWM   : std_logic_vector (7 downto 0);

  component M2_sel_PWM is
    port (
      CLK      : in  std_logic;
      rst      : in  std_logic;
      btn_up   : in  std_logic;
      btn_down : in  std_logic;
      vecPWM   : out std_logic_vector (7 downto 0));
  end component M2_sel_PWM;
  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture PWM

  -- component instantiation
  DUT : entity work.M2_sel_PWM
    port map (
      CLK      => CLK,
      rst      => rst,
      btn_up   => btn_up,
      btn_down => btn_down,
      vecPWM   => vecPWM);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here

    rst      <= '1';
    wait for 100 ns;
    rst      <= '0';
    wait for 100 ns;
    btn_up   <= '1';                    --1
    wait for 10 us;
    btn_up   <= '0';                    --
    wait for 100 us;
    btn_up   <= '1';                    --2
    wait for 10 us;
    btn_up   <= '0';                    --
    wait for 100 us;
    btn_down <= '1';                    --1
    wait for 100 us;
    btn_down <= '0';                    --
    wait for 100 us;
    btn_up   <= '1';
    wait for 300 us;
    btn_up   <= '0';
    wait;

    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture PWM;

-------------------------------------------------------------------------------

configuration M2_sel_PWM_tb_PWM_cfg of M2_sel_PWM_tb is
  for PWM
  end for;
end M2_sel_PWM_tb_PWM_cfg;

-------------------------------------------------------------------------------

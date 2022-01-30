-------------------------------------------------------------------------------
-- Title      : Testbench for design "M1_gen_PWM"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : M1_gen_PWM_tb.vhd
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

entity M1_gen_PWM_tb is

end entity M1_gen_PWM_tb;

-------------------------------------------------------------------------------

architecture pwm of M1_gen_PWM_tb is

  -- component ports
  -- signal CLK         : std_logic;
  signal rst         : std_logic;
  signal sw_Dir      : std_logic;
  signal PWM_vector  : std_logic_vector (7 downto 0);
  signal pinDir      : std_logic;
  signal pinEn       : std_logic;
  signal sel_display : std_logic_vector (7 downto 0);

  component M1_gen_PWM is
    port (
      CLK         : in  std_logic;
      rst         : in  std_logic;
      sw_Dir      : in  std_logic;
      PWM_vector  : in  std_logic_vector (7 downto 0);
      pinDir      : out std_logic;
      pinEn       : out std_logic;
      sel_display : out std_logic_vector (7 downto 0));
  end component M1_gen_PWM;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture pwm

  -- component instantiation
  DUT : entity work.M1_gen_PWM
    port map (
      CLK         => CLK,
      rst         => rst,
      sw_Dir      => sw_Dir,
      PWM_vector  => PWM_vector,
      pinDir      => pinDir,
      pinEn       => pinEn,
      sel_display => sel_display);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst        <= '0';
    wait for 100 ns;
    rst        <= '1';
    PWM_vector <= "01000001";           --65%
    sw_Dir     <= '0';
    wait for 200 us;
    sw_Dir     <= '1';
    wait for 100 us;
    sw_Dir     <= '0';
    wait for 100 us;
    sw_Dir     <= '1';
    wait for 500 us;
--    PWM_vector <= "00011110";           --30%
--    PWM_vector <= "00000000";           --0%
--    PWM_vector <= "00000101";           --5%
--    PWM_vector <= "00000000";           --0%
--    PWM_vector <= "00110010";           --50%
--    PWM_vector <= "01000001";           --65%
--    PWM_vector <= "01010101";           --85%
--    PWM_vector <= "01100100";           --100%

    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture pwm;

-------------------------------------------------------------------------------

configuration M1_gen_PWM_tb_pwm_cfg of M1_gen_PWM_tb is
  for pwm
  end for;
end M1_gen_PWM_tb_pwm_cfg;

-------------------------------------------------------------------------------

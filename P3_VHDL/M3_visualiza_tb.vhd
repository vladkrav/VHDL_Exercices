-------------------------------------------------------------------------------
-- Title      : Testbench for design "M3_visualiza"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : M3_visualiza_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-12-06
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
-- 2018-12-06  1.0      Vlad95  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity M3_visualiza_tb is

end entity M3_visualiza_tb;

-------------------------------------------------------------------------------

architecture visualiza of M3_visualiza_tb is

  -- component ports
  -- signal CLK         : std_logic;
  signal rst         : std_logic;
  signal PWM_vector  : std_logic_vector (7 downto 0);
  signal sw_Dir      : std_logic;
  signal sw_sel_disp : std_logic;
  signal velocidad   : std_logic_vector (7 downto 0);
  signal seg7_code   : std_logic_vector (7 downto 0);
  signal sel_disp    : std_logic_vector (7 downto 0);

  component M3_visualiza is
    port (
      CLK         : in  std_logic;
      rst         : in  std_logic;
      PWM_vector  : in  std_logic_vector (7 downto 0);
      sw_Dir      : in  std_logic;
      sw_sel_disp : in  std_logic;
      velocidad   : in  std_logic_vector (7 downto 0);
      seg7_code   : out std_logic_vector (7 downto 0);
      sel_disp    : out std_logic_vector (7 downto 0));
  end component M3_visualiza;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture visualiza

  -- component instantiation
  DUT : entity work.M3_visualiza
    port map (
      CLK         => CLK,
      rst         => rst,
      PWM_vector  => PWM_vector,
      sw_Dir      => sw_Dir,
      sw_sel_disp => sw_sel_disp,
      velocidad   => velocidad,
      seg7_code   => seg7_code,
      sel_disp    => sel_disp);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst         <= '0';
    wait for 100 ns;
    rst         <= '1';
    PWM_vector  <= "01000001";          --65%
    velocidad   <= x"63";
    sw_Dir      <= '0';
    sw_sel_disp <= '0';
    wait for 100 ns;
    sw_sel_disp <= '0';
    wait for 210 us;
    sw_Dir      <= '1';
    wait for 100 us;
    sw_Dir      <= '0';
    sw_sel_disp <= '1';
    wait for 100 us;
    sw_Dir      <= '1';
    sw_sel_disp <= '0';
    PWM_vector  <= "00011001";          --25%
    wait for 250 us;

    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture visualiza;

-------------------------------------------------------------------------------

configuration M3_visualiza_tb_visualiza_cfg of M3_visualiza_tb is
  for visualiza
  end for;
end M3_visualiza_tb_visualiza_cfg;

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Title      : Testbench for design "M1_M2_sel_gen_PWM"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : M1_M2_sel_gen_PWM_tb.vhd
-- Author     :   <Alumno@PC08-L6>
-- Company    : 
-- Created    : 2018-12-18
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
-- 2018-12-18  1.0      Alumno  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity M1_M2_sel_gen_PWM_tb is

end entity M1_M2_sel_gen_PWM_tb;

-------------------------------------------------------------------------------

architecture m1_m2 of M1_M2_sel_gen_PWM_tb is

  -- component ports
  -- signal CLK         : std_logic;
  signal rst         : std_logic;
  signal btn_up      : std_logic;
  signal btn_down    : std_logic;
  signal sw_Dir      : std_logic;
  signal pinDir      : std_logic;
  signal pinEn       : std_logic;
  signal sel_display : std_logic_vector (7 downto 0);


  component M1_M2_sel_gen_PWM is
    port (
      CLK         : in  std_logic;
      rst         : in  std_logic;
      btn_up      : in  std_logic;
      btn_down    : in  std_logic;
      sw_Dir      : in  std_logic;
      pinDir      : out std_logic;
      pinEn       : out std_logic;
      sel_display : out std_logic_vector (7 downto 0));
  end component M1_M2_sel_gen_PWM;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture m1_m2

  -- component instantiation
  DUT : entity work.M1_M2_sel_gen_PWM
    port map (
      CLK         => CLK,
      rst         => rst,
      btn_up      => btn_up,
      btn_down    => btn_down,
      sw_Dir      => sw_Dir,
      pinDir      => pinDir,
      pinEn       => pinEn,
      sel_display => sel_display);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here

    rst      <= '0';
    wait for 100 ns;
    rst      <= '1';
    sw_Dir   <= '0';
    wait for 210 us;
    sw_Dir   <= '1';
    wait for 100 us;
    sw_Dir   <= '0';
    btn_up   <= '1';                    --1
    wait for 100 us;
    btn_up   <= '0';                    --
    sw_Dir   <= '1';
    wait for 50 us;
    btn_up   <= '1';                    --2
    wait for 50 us;
    btn_up   <= '0';                    --
    wait for 50 us;
    btn_down <= '1';                    --1
    wait for 50 us;
    btn_down <= '0';                    --
    wait for 50 us;
    btn_up   <= '1';
    wait for 250 ms;

    wait until Clk = '1';
  end process WaveGen_Proc;



end architecture m1_m2;

-------------------------------------------------------------------------------

configuration M1_M2_sel_gen_PWM_tb_m1_m2_cfg of M1_M2_sel_gen_PWM_tb is
  for m1_m2
  end for;
end M1_M2_sel_gen_PWM_tb_m1_m2_cfg;

-------------------------------------------------------------------------------

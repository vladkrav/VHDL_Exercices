-------------------------------------------------------------------------------
-- Title      : Testbench for design "contr_motor"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : contr_motor_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-12-30
-- Last update: 2018-12-30
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-12-30  1.0      Vlad95  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity contr_motor_tb is

end entity contr_motor_tb;

-------------------------------------------------------------------------------

architecture motor of contr_motor_tb is

  -- component ports
  -- signal CLK         : std_logic;
  signal rst         : std_logic;
  signal btn_up      : std_logic;
  signal btn_down    : std_logic;
  signal sw_Dir      : std_logic;
  signal sw_sel_disp : std_logic;
  signal pinSA       : std_logic;
  signal pinSB       : std_logic;
  signal pinEn       : std_logic;
  signal pinDir      : std_logic;
  signal seg7_code   : std_logic_vector (7 downto 0);
  signal sel_display : std_logic_vector (7 downto 0);

  component contr_motor is
    port (
      CLK         : in  std_logic;
      rst         : in  std_logic;
      btn_up      : in  std_logic;
      btn_down    : in  std_logic;
      sw_Dir      : in  std_logic;
      sw_sel_disp : in  std_logic;
      pinSA       : in  std_logic;
      pinSB       : in  std_logic;
      pinEn       : out std_logic;
      pinDir      : out std_logic;
      seg7_code   : out std_logic_vector (7 downto 0);
      sel_display : out std_logic_vector (7 downto 0));
  end component contr_motor;
  
    CONSTANT period : time := 10 ns;
    signal k : std_logic := '0';
  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture motor

  -- component instantiation
  DUT : entity work.contr_motor
    port map (
      CLK         => CLK,
      rst         => rst,
      btn_up      => btn_up,
      btn_down    => btn_down,
      sw_Dir      => sw_Dir,
      sw_sel_disp => sw_sel_disp,
      pinSA       => pinSA,
      pinSB       => pinSB,
      pinEn       => pinEn,
      pinDir      => pinDir,
      seg7_code   => seg7_code,
      sel_display => sel_display);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst <= '0';
    btn_up <= '0';
    btn_down <= '0';
    sw_sel_disp <= '0';
    pinSA <= '0';
    sw_Dir <= '0';
    wait for 100 ns;
    rst <= '1';
    wait for 100 us;
    btn_up <= '1';
    wait for 390 ns;
    for i in 0 to 100 loop
      wait for 20 ns;
      pinSA <= '1';
      wait for 60 ns;
      pinSA <= '0';
  end loop;  -- i
  wait for 400 us;
  btn_up <= '0';
  wait until Clk = '1';
end process WaveGen_Proc;



end architecture motor;

-------------------------------------------------------------------------------

configuration contr_motor_tb_motor_cfg of contr_motor_tb is
  for motor
  end for;
end contr_motor_tb_motor_cfg;

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Title      : Testbench for design "regs_FSM"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : regs_FSM_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-10-26
-- Last update: 2018-10-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-10-26  1.0      Vlad95  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity regs_FSM_tb is

end entity regs_FSM_tb;

-------------------------------------------------------------------------------

architecture cnt of regs_FSM_tb is

  -- component ports
  signal lapso       : std_logic;
  signal rst         : std_logic;
--  signal clk         : std_logic;
  signal En_1KHz     : std_logic;
  signal En_1Hz      : std_logic;
  signal leds        : std_logic_vector (7 downto 0);
  signal sel_display : std_logic_vector(3 downto 0);
  signal seg7_code   : std_logic_vector(7 downto 0);

  component regs_FSM is
    port (
      lapso       : in  std_logic;
      rst         : in  std_logic;
      clk         : in  std_logic;
      En_1KHz     : in  std_logic;
      En_1Hz      : in  std_logic;
      leds        : out std_logic_vector (7 downto 0);
      sel_display : out std_logic_vector(3 downto 0);
      seg7_code   : out std_logic_vector(7 downto 0));
  end component regs_FSM;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture cnt

  -- component instantiation
  DUT : entity work.regs_FSM
    port map (
      lapso       => lapso,
      rst         => rst,
      clk         => clk,
      En_1KHz     => En_1KHz,
      En_1Hz      => En_1Hz,
      leds        => leds,
      sel_display => sel_display,
      seg7_code   => seg7_code);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait for 100 ns;
    lapso <= '1';
    wait for 100 ns;
    lapso <= '0';
    wait for 300 ns;
    lapso <= '1';
    wait for 200 ns;
    lapso <= '0';
    wait;
      wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture cnt;

-------------------------------------------------------------------------------

configuration regs_FSM_tb_cnt_cfg of regs_FSM_tb is
  for cnt
  end for;
end regs_FSM_tb_cnt_cfg;

-------------------------------------------------------------------------------

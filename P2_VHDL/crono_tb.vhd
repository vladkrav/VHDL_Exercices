-------------------------------------------------------------------------------
-- Title      : Testbench for design "crono"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : crono_tb.vhd
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

entity crono_tb is

end entity crono_tb;

-------------------------------------------------------------------------------

architecture cronometro of crono_tb is

  -- component ports
  signal lapso       : std_logic;
  signal rst_n       : std_logic;
--signal clk         : std_logic;
  signal sel_display : std_logic_vector(7 downto 0);
  signal led_out     : std_logic_vector (7 downto 0);
  signal seg7_code   : std_logic_vector(7 downto 0);


  component crono is
    port (
      lapso       : in  std_logic;
      rst_n       : in  std_logic;
      clk         : in  std_logic;
      sel_display : out std_logic_vector(7 downto 0);
      led_out     : out std_logic_vector (7 downto 0);
      seg7_code   : out std_logic_vector(7 downto 0));
  end component crono;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture cronometro

  -- component instantiation
  DUT : entity work.crono
    port map (
      lapso       => lapso,
      rst_n       => rst_n,
      clk         => clk,
      sel_display => sel_display,
      led_out     => led_out,
      seg7_code   => seg7_code);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst_n <= '0';
    wait for 50 ns;
    rst_n <= '1';
    wait for 1 ms;
    lapso <= '1';
    wait for 1 ms;
    lapso <= '0';
    wait for 1 ms;
    lapso <= '1';
    wait for 1 ms;
    lapso <= '0';
    wait for 3 ms;
    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture cronometro;

-------------------------------------------------------------------------------

configuration crono_tb_cronometro_cfg of crono_tb is
  for cronometro
  end for;
end crono_tb_cronometro_cfg;

-------------------------------------------------------------------------------

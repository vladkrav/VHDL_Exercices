-------------------------------------------------------------------------------
-- Title      : Testbench for design "hex2bcd"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : hex2bcd_tb.vhd
-- Author     :   <Vlad95@VLADKRAV>
-- Company    : 
-- Created    : 2018-12-07
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
-- 2018-12-07  1.0      Vlad95  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity hex2bcd_tb is

end entity hex2bcd_tb;

-------------------------------------------------------------------------------

architecture hex of hex2bcd_tb is

  -- component ports
--  signal clk     : std_logic;
  signal rst     : std_logic;
  signal hex_in  : std_logic_vector (7 downto 0);
  signal bcd_hun : std_logic_vector (3 downto 0);
  signal bcd_ten : std_logic_vector (3 downto 0);
  signal bcd_uni : std_logic_vector (3 downto 0);

  component hex2bcd is
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      hex_in  : in  std_logic_vector (7 downto 0);
      bcd_hun : out std_logic_vector (3 downto 0);
      bcd_ten : out std_logic_vector (3 downto 0);
      bcd_uni : out std_logic_vector (3 downto 0));
  end component hex2bcd;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture hex

  -- component instantiation
  DUT : entity work.hex2bcd
    port map (
      clk     => clk,
      rst     => rst,
      hex_in  => hex_in,
      bcd_hun => bcd_hun,
      bcd_ten => bcd_ten,
      bcd_uni => bcd_uni);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst    <= '1';
    wait for 100 ns;
    rst    <= '0';
    hex_in <= "01000001";               --65%
    wait for 300 ns;
    hex_in <= "00011110";               --30%
    wait for 200 ns;
    hex_in <= "01000001";               --65%
    wait for 300 ns;
    hex_in <= "00011110";               --30%
    rst    <= '1';
    wait for 200 ns;
    hex_in <= "01000001";               --65%
    rst    <= '0';
    wait for 300 ns;
    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture hex;

-------------------------------------------------------------------------------

configuration hex2bcd_tb_hex_cfg of hex2bcd_tb is
  for hex
  end for;
end hex2bcd_tb_hex_cfg;

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Title      : Testbench for design "M4_calc_veloc"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : M4_calc_veloc_tb.vhd
-- Author     :   <Oscar Betancort@LENOVO-PC>
-- Company    : 
-- Created    : 2018-12-29
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
-- 2018-12-29  1.0      Oscar Betancort Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity M4_calc_veloc_tb is

end entity M4_calc_veloc_tb;

-------------------------------------------------------------------------------

architecture velocidad of M4_calc_veloc_tb is

  -- component ports
  --signal clk       : std_logic;
  signal rst       : std_logic;
  --signal pinSA     : std_logic;
  signal pinSB     : std_logic;
  signal velocidad : std_logic_vector (7 downto 0);

  component M4_calc_veloc is
    port (
      clk       : in  std_logic;
      rst       : in  std_logic;
      pinSA     : in  std_logic;
      pinSB     : in  std_logic;
      velocidad : out std_logic_vector (7 downto 0));
  end component M4_calc_veloc;

  constant period : time      := 10 ns;
  -- clock
  signal Clk      : std_logic := '1';
  signal pinSA    : std_logic := '0';

begin  -- architecture velocidad

  -- component instantiation
  DUT : entity work.M4_calc_veloc
    port map (
      clk       => clk,
      rst       => rst,
      pinSA     => pinSA,
      pinSB     => pinSB,
      velocidad => velocidad);

  -- clock generation
  Clk   <= not Clk   after 10 ns;
  pinSA <= not pinSA after 10 ms;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    rst <= '0';
    wait for 10 ns;
    rst <= '1';
    wait for 10000 ms;

  --wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture velocidad;

-------------------------------------------------------------------------------

configuration M4_calc_veloc_tb_velocidad_cfg of M4_calc_veloc_tb is
  for velocidad
  end for;
end M4_calc_veloc_tb_velocidad_cfg;

-------------------------------------------------------------------------------

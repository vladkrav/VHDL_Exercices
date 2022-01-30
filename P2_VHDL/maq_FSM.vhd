library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- pragma translate_off
library unisim;
use unisim.vcomponents.all;
-- pragma translate_on

entity maq_FSM is
  port (
    clk  : in  std_logic;             -- clk maestro
    rst   : in  std_logic;             -- reset del sistema
    lapso : in  std_logic;             -- pulsador lapso
    actualizar : out std_logic);       -- si se actualizan los displays 
end maq_FSM;

architecture secuencial of maq_FSM is
  type stateFSM is (S1,S2,S3,S4);
  signal state : stateFSM ;  -- estado de la máquina secuencial

begin  -- secuencial
  -- Maquina de estados de control del lapso:
  --    Control del cambio de estados.
  process(clk, rst)
  begin
    if (rst = '1') then
      state       <= S1;
    elsif(clk = '1' and clk'event) then
      case state is
        when S1 =>
          if (lapso = '1') then
            state <= S2;
          end if;
        when S2 =>
          if (lapso = '0') then
            state <= S3;
          end if;
        when S3 =>
          if (lapso = '1') then
            state <= S4;
          end if;
        when S4 =>
          if (lapso = '0') then
            state <= S1;
          end if;
      end case;
    end if;
  end process;

  -- Maquina de estados de control del lapso:
  --    Control de la salida.
  process(state)
  begin
    case state is
      when S2 | S3 =>
        actualizar <= '0';
      when S1 | S4 =>
        actualizar <= '1';
    end case;		
  end process;
end secuencial;                         -- fin de la architecture secuencial

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use std.env.finish;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Seven_Segment_Display_Sim is
--  Port ( );
end Seven_Segment_Display_Sim;

architecture Behavioral of Seven_Segment_Display_Sim is
  signal r_Clk, r_Reset : std_logic := '0';
  signal displayed_number: std_logic_vector(15 downto 0); -- HEX 0-F
  signal an  : std_logic_vector(3 downto 0);
  signal seg : std_logic_vector(6 downto 0);
begin
  r_Clk <= not r_Clk after 5 ns;
  
  Unit_Under_Test :  entity work.Seven_Segment_Display
    generic map (CYCLES_PER_ANODE => 100000)
    port map (
      i_Clock => r_Clk,
      i_Reset => r_Reset,
      i_Displayed => displayed_number,
      o_Anodes => an,
      o_Segments => seg
    );
  
  process is  
  begin
    displayed_number <= (others => '0');
    wait until r_Clk = '1';
    wait until r_Clk = '1';
    wait until r_Clk = '1';
    wait until r_Clk = '1';
    displayed_number <= displayed_number + x"0001";
    wait until r_Clk = '1';
    wait until r_Clk = '1';
    wait until r_Clk = '1';
    
    finish;
  end process;
     

end Behavioral;

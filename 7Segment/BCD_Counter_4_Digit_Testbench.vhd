library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_Counter_4_Digit_Testbench is

end BCD_Counter_4_Digit_Testbench;

architecture Behavioral of BCD_Counter_4_Digit_Testbench is
  signal r_Clk, r_Reset: std_logic := '0';
  signal r_BCD: std_logic_vector(15 downto 0);
begin
  r_Clk <= not r_Clk after 5 ns;
  
  Unit_Under_Test :  entity work.BCD_Counter_4_Digit
    port map (
      i_Reset => r_Reset, 
      i_Increment => r_Clk,
      o_BCD => r_BCD
    );
    
  process is  
  begin
    for i in 0 to 999 loop 
      wait until r_Clk = '1'; 
    end loop;
    finish;
  end process;

end Behavioral;

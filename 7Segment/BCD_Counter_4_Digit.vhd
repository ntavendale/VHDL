library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_Counter_4_Digit is
  port (
    i_Reset     : in std_logic;
    i_Increment : in std_logic;
    o_BCD       : out std_logic_vector(15 downto 0)
   );
end BCD_Counter_4_Digit;

architecture RTL of BCD_Counter_4_Digit is
  signal r_Digit_0: std_logic_vector(3 downto 0) := "0000"; 
  signal r_Digit_1: std_logic_vector(3 downto 0) := "0000";
  signal r_Digit_2: std_logic_vector(3 downto 0) := "0000";
  signal r_Digit_3: std_logic_vector(3 downto 0) := "0000";
begin
  process(i_Increment, i_Reset)
  begin
    if i_Reset = '1' then
      r_Digit_0 <= "0000";
      r_Digit_1 <= "0000";
      r_Digit_2 <= "0000";
      r_Digit_3 <= "0000";
    elsif rising_edge(i_Increment) then
      if r_Digit_3 = "1001" and r_Digit_2 = "1001" and r_Digit_1 = "1001" and r_Digit_0 = "1001" then
        -- Reset
        r_Digit_0 <= "0000";
        r_Digit_1 <= "0000";
        r_Digit_2 <= "0000";
        r_Digit_3 <= "0000";
      elsif r_Digit_0 = "1001" then
        r_Digit_0 <= "0000"; 
        if r_Digit_1 = "1001" then
          r_Digit_1 <= "0000";
          if r_Digit_2 = "1001" then
            r_Digit_2 <= "0000";
            r_Digit_3 <= r_Digit_3 + "1";
          else
            r_Digit_2 <= r_Digit_2 + "1";
          end if; 
        else
          r_Digit_1 <= r_Digit_1 + "1";
        end if;
      else
        r_Digit_0 <= r_Digit_0 + "1";
      end if;
    end if;
  end process;
  o_BCD(15 downto 12) <= r_Digit_3;
  o_BCD(11 downto 8)  <= r_Digit_2;
  o_BCD(7 downto 4)   <= r_Digit_1;
  o_BCD(3 downto 0)   <= r_Digit_0;
end RTL;


library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Basys_7_Segment_Top is
  port (
    clk : in std_logic;
    btnC : in std_logic; 
    an  : out std_logic_vector(3 downto 0);
    seg : out std_logic_vector(6 downto 0) -- GFEDCAB
  );
end Basys_7_Segment_Top;

architecture Behavioral of Basys_7_Segment_Top is
  -- counter for genrerating one second clockl enable
  signal one_second_counter: std_logic_vector(27 downto 0);
  -- one second enable
  signal one_second_enable : std_logic;
  signal displayed_number  : std_logic_vector(15 downto 0); -- HEX 0-F
begin
  
  Seven_Segment : entity work.Seven_Segment_Display
    generic map (CYCLES_PER_ANODE => 100000) -- 1 KHz   
    port map (
      i_Clock     => clk,
      i_Reset     => btnC,
      i_Displayed => displayed_number,
      o_Anodes    => an,
      o_Segments  => seg
    );
    
  BDC_Counter : entity work.BCD_Counter_4_Digit
    port map (
      i_Increment  => one_second_enable,
      i_Reset     => btnC,
      o_BCD       => displayed_number
    );
  
  -- Counting the number to be displayed on 4-digit 7-segment Display 
  -- on Basys 3 FPGA board
  process(clk, btnC)
  begin
    if (btnC = '1') then
      one_second_counter <= (others => '0');
    elsif rising_edge(clk) then
      if one_second_counter>=x"5F5E0FF" then
        one_second_counter <= (others => '0');
        one_second_enable <= '1';
      else
        one_second_counter <= one_second_counter + "0000001";
        one_second_enable <= '0';
      end if;
    end if;
  end process;
  --process(clk, btnC)
  --begin
  --  if btnC = '1' then
  --    displayed_number <= (others => '0');
  --  elsif rising_edge(clk) then
  --    if one_second_enable = '1' then
  --      displayed_number <= displayed_number + x"0001";
  --    end if;
  --  end if;
  --end process;

end Behavioral;

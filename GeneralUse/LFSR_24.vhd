library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 24 bit Linear Feedback Shift Register

entity LFSR_24 is
    Port ( 
      i_lfsr_clk  : in std_logic;
      o_lfsr_data : out std_logic_vector(23 downto 0);
      o_lfsr_done : out std_logic
    );
end LFSR_24;

architecture RTL of LFSR_24 is
  signal r_lfsr : std_logic_vector(23 downto 0);
  signal w_xnor : std_logic;
begin
  process(i_lfsr_clk) begin
    if rising_edge(i_lfsr_clk) then
      r_lfsr <= r_lfsr(22 downto 0) & w_xnor;
    end if;
  end process;
  
  w_xnor <= r_lfsr(23) xnor r_lfsr(22);
  o_lfsr_done <= '1' when (r_lfsr = "000000000000000000000000") else '0';
  o_lfsr_data <= r_lfsr;
   
end RTL;

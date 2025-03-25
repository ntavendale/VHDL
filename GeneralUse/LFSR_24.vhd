-- Copyright 2025 Nigel Tavendale
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this code 
-- associated documentation files (the “Code”), to deal in the Code without restriction, including 
-- without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
-- and/or sell copies of the Code, and to permit persons to whom the Code is furnished to do so, 
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial 
-- portions of the Code.
--
-- THE CODE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
-- TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
-- SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN 
-- ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE CODE OR THE USE OR 
-- OTHER DEALINGS IN THE CODE.
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

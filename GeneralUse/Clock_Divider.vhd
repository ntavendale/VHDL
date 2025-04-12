-- Copyright 2025 Nigel Tavendale
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this code 
-- associated documentation files (the "Code"), to deal in the Code without restriction, including 
-- without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
-- and/or sell copies of the Code, and to permit persons to whom the Code is furnished to do so, 
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial 
-- portions of the Code.
--
-- THE CODE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
-- TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
-- SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN 
-- ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE CODE OR THE USE OR 
-- OTHER DEALINGS IN THE CODE.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- {VHDL 2008}

entity Clock_Divider is
  generic (
    -- Basys 3 is 100 MHz. VGA is 25 Mhz.
    DIVIDE_BY: integer := 4 
  );
  port (
    i_Clk_In    : in std_logic;
    i_Reset     : in std_logic;
    o_Clock_Out : out std_logic
  );
end Clock_Divider;

architecture RTL of Clock_Divider is
  signal count : integer := 0;
  signal tmp : std_logic := '0';
begin
  process (i_Clk_In, i_Reset)
  begin
    if i_Reset = '1' then
      count <= 0;
      tmp   <= '0';
    elsif rising_edge(i_Clk_In) then
      count <= count + 1;
      if (count = (DIVIDE_BY / 2) -1) then
        count <= 0;
        tmp <= not tmp;
      end if; 
    end if;
    
    o_Clock_Out <= tmp;
    
  end process;
end RTL;

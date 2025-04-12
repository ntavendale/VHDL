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
use std.env.finish;

-- {VHDL 2008}

entity Clock_Divider_Testbench is
end Clock_Divider_Testbench;

architecture Behavioral of Clock_Divider_Testbench is
  component Clock_Divider
  port(
    i_Clk_In    : in std_logic;
    i_Reset     : in std_logic;
    o_Clock_Out : out std_logic
  );
  end component;
  
  signal r_Clk : std_logic := '0';
  signal reset : std_logic := '0';
  --Outputs
  signal clock_out : std_logic;
  -- Clock period definitions
  constant clk_period : time := 10 ns;
begin
  r_Clk <= not r_Clk after 5 ns;
  
  Unit_Under_Test: Clock_Divider 
    port map (
      i_Clk_In => r_Clk,
      i_Reset => reset,
      o_Clock_Out => clock_out
    );

  process is  
  begin
    for i in 0 to 21 loop 
      wait until r_Clk = '1'; 
    end loop;
    finish;
  end process;
  
end Behavioral;

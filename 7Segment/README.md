# 7 Segment
VHDL Modules And Top Project for 7 Segment Counter on Basys 3 Board.

## BCD_Counter_4_Digit.vhd
Module to count from 0 - 9999 in base 10 output Binary Coded decimal that can be used by the 7 segment display.

## Seven_Segment_Display.vhd
Module to display 4 digit BCD number on Basys 3 board's 7 segment display. Each segment has common cathodes (1-7) and Decimal point. Anodes are driven low on clock signal. Defaults to 1 KHz. Needs to be fast enough that persistence of vision will compensate for blinking.

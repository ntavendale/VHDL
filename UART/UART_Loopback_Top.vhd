library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

-- VHDL 2008

entity UART_Loopback_Top is
  generic (
      BASYS3_CLKS_PER_BIT : integer := 868 -- 100,000,000 / 115,200 = 868 
  );
  port (
    -- Main clock 100 MHz
    clk   : in std_logic;
    -- UART Data
    RsRx : in  std_logic;
    RsTx : out std_logic;
    an   : out std_logic_vector (3 downto 0);
    seg  : out std_logic_vector (6 downto 0)
  );
end UART_Loopback_Top;

architecture RTL of UART_Loopback_Top is
  signal w_RX_DV     : std_logic;
  signal w_RX_Byte   : std_logic_vector(7 downto 0);
  signal w_TX_Active : std_logic;
  signal w_TX_Serial : std_logic;
begin

  ART_RX_Inst : entity work.UART_RX
    generic map (
      CLKS_PER_BIT => BASYS3_CLKS_PER_BIT)
    port map (
      i_Rx_Clk    => clk,
      i_RX_Serial => RsRx,
      o_RX_DV     => w_RX_DV,
      o_RX_Byte   => w_RX_Byte);
 
 
  -- Creates a simple loopback to test TX and RX
  UART_TX_Inst : entity work.UART_TX
    generic map (
      CLKS_PER_BIT => BASYS3_CLKS_PER_BIT)               
    port map (
      i_TX_Clk    => clk,
      i_TX_DV     => w_RX_DV,
      i_TX_Byte   => w_RX_Byte,
      o_TX_Active => w_TX_Active,
      o_TX_Serial => w_TX_Serial,
      o_TX_Done   => open
      );
 
  -- Drive UART line high when transmitter is not active
  RsTx <= w_TX_Serial when w_TX_Active = '1' else '1';
  
  SevenSeg1_Inst : entity work.Seven_Segment_Display_Binary
    port map (
      i_Clock       => clk,
      i_Reset       => '0',
      i_Displayed   => (7 downto 0 => w_RX_Byte, others => '0'),
      o_Anodes      => an,
      o_Segments    => seg
      );

end RTL;

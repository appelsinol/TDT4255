----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:27:11 09/19/2012 
-- Design Name: 
-- Module Name:    SignShiftLeft2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignShiftLeft2 is
	port(
			shiftLeftIn : in std_logic_vector(31 downto 0);
			shiftLeftOut : out std_logic_vector(31 downto 0)
		);
end SignShiftLeft2;

architecture Behavioral of SignShiftLeft2 is

begin
	leftshift : process(shiftLeftIn)
	begin
		shiftLeftOut <= shiftLeftIn( 29 downto 0) & "00";
	end process;

end Behavioral;


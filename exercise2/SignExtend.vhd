----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:26:26 09/19/2012 
-- Design Name: 
-- Module Name:    SignExtend - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignExtend is
	Port ( 	
			  ins_in : in  STD_LOGIC_VECTOR (15 downto 0);
           extendins_out : out  STD_LOGIC_VECTOR(31 downto 0));
end SignExtend;

architecture Behavioral of SignExtend is
begin
	SignExtend:process(ins_in)
	begin
		extendins_out <= STD_LOGIC_VECTOR(RESIZE(SIGNED(ins_in),extendins_out'LENGTH));
	end process;

end Behavioral;


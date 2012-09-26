----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:28:48 09/24/2012 
-- Design Name: 
-- Module Name:    JumpShift - Behavioral 
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

entity JumpShift is
	PORT(
		pc_4_instruction : in STD_LOGIC_VECTOR(31 downto 0);
		immediate_ins : in STD_LOGIC_VECTOR(25 downto 0);
		after_jump_instruction : out STD_LOGIC_VECTOR(31 downto 0)
		);
end JumpShift;

architecture Behavioral of JumpShift is

begin
	jump_shift:process(pc_4_instruction,immediate_ins)
	begin
		after_jump_instruction <= pc_4_instruction(31 downto 28) & immediate_ins & "00";
	end process;
end Behavioral;


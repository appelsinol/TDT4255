----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:26 09/24/2012 
-- Design Name: 
-- Module Name:    ALUControl - Behavioral 
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
library WORK;
use WORK.MIPS_CONSTANT_PKG.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUControl is
	PORT(
		instr_15_0 : in STD_LOGIC_VECTOR(15 downto 0);
		ALUop : in STD_LOGIC_VECTOR(1 downto 0);
		ALUopcode : out ALU_INPUT
	);
end ALUControl;

architecture Behavioral of ALUControl is
signal alu_temp : STD_LOGIC_VECTOR(3 downto 0);
	
begin

alu_control: process (instr_15_0,ALUop)

	constant oADD : STD_LOGIC_VECTOR(5 downto 0) := "100000";
	constant oSUB : STD_LOGIC_VECTOR(5 downto 0) := "100010";
	constant oAND : STD_LOGIC_VECTOR(5 downto 0) := "100100";
	constant oOR : STD_LOGIC_VECTOR(5 downto 0) := "100101";
	constant oSLT : STD_LOGIC_VECTOR(5 downto 0) := "1001010";
	
	begin
		case ALUop is 
			when "00" => 
				alu_temp <= "0010"; -- add
			when "01" =>
				alu_temp <= "0110"; -- subtract
			when "10" =>
				case instr_15_0(5 downto 0) is 
					when oADD =>
						alu_temp <= "0010"; -- add
					when oSUB =>
						alu_temp <= "0110";  -- subtract
					when oAND =>
						alu_temp <= "0000"; -- and
					when oOR =>
						alu_temp <= "0001"; -- or
					when oSLT =>
						alu_temp <= "0111"; -- slt
				end case;
			when others =>
				alu_temp <= "0000";
		end case;
end process;
	
	assign_signal_ALUopcode:process(alu_temp)
	begin
		ALUopcode.Op0 <= alu_temp(0);
		ALUopcode.Op1 <= alu_temp(1);
		ALUopcode.Op2 <= alu_temp(2);
		ALUopcode.Op3 <= alu_temp(3);
	end process;
	
end Behavioral;


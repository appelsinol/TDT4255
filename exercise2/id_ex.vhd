----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:31 10/09/2012 
-- Design Name: 
-- Module Name:    id_ex - Behavioral 
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

entity id_ex is
	PORT(
	   CLK : in STD_LOGIC;
		reset : in STD_LOGIC;
		processor_en : in STD_LOGIC;
		incremented_addr_in : in STD_LOGIC_VECTOR(31 downto 0);
		read_data_1_in : in STD_LOGIC_VECTOR(31 downto 0);
		read_data_2_in : in STD_LOGIC_VECTOR(31 downto 0);
		sign_extend_in : in STD_LOGIC_VECTOR(31 downto 0);
		instruction_20_16_in : in STD_LOGIC_VECTOR(4 downto 0);
		instruction_15_11_in : in STD_LOGIC_VECTOR(4 downto 0);
		incremented_addr_out : out STD_LOGIC_VECTOR(31 downto 0);
		read_data_1_out : out STD_LOGIC_VECTOR(31 downto 0);
		read_data_2_out : out STD_LOGIC_VECTOR(31 downto 0);
		sign_extend_out : out STD_LOGIC_VECTOR(31 downto 0);
		instruction_20_16_out : out STD_LOGIC_VECTOR(4 downto 0);
		instruction_15_11_out : out STD_LOGIC_VECTOR(4 downto 0);
		RegDst_in : in  STD_LOGIC;
	   ALUSrc_in : in  STD_LOGIC;
		MemtoReg_in : in  STD_LOGIC;
		RegWrite_in : in  STD_LOGIC;
	   MemRead_in : in  STD_LOGIC;
		MemWrite_in : in  STD_LOGIC;   
      Branch_in : in  STD_LOGIC;
      ALUOp_in : in  STD_LOGIC_VECTOR(1 downto 0);
     
		RegDst_out : out  STD_LOGIC;
	   ALUSrc_out: out  STD_LOGIC;
		MemtoReg_out : out  STD_LOGIC;
		RegWrite_out : out  STD_LOGIC;
	   MemRead_out : out  STD_LOGIC;
		MemWrite_out : out  STD_LOGIC;   
      Branch_out : out  STD_LOGIC;
      ALUOp_out : out  STD_LOGIC_VECTOR(1 downto 0)
     
		
	);
end id_ex;


architecture Behavioral of id_ex is
-- signal allocation according from the book
begin
		pipe_process : process(clk)
		begin
		if (reset = '1') then 
		   incremented_addr_out <= ZERO32b;
		   read_data_1_out <= ZERO32b;
		   read_data_2_out <= ZERO32b;
			sign_extend_out <= ZERO32b;
			instruction_20_16_out <= "00000";
			instruction_15_11_out <= "00000";
			RegDst_out <= '0';
			ALUSrc_out <= '0';
			MemtoReg_out <= '0';
			RegWrite_out <= '0';
			MemRead_out <= '0';
			Branch_out <= '0';
			ALUOp_out <= "00";
		
		elsif (rising_edge(clk)) then
			if(processor_en = '1') then
				incremented_addr_out <= incremented_addr_in; 	
				read_data_1_out <= read_data_1_in;
				read_data_2_out <= read_data_2_in;
				sign_extend_out <= sign_extend_in;
				instruction_20_16_out <= instruction_20_16_in;
				instruction_15_11_out <= instruction_15_11_in;
				RegDst_out <= RegDst_in;
				ALUSrc_out <= ALUSrc_in;
				MemtoReg_out <= MemtoReg_in;
				RegWrite_out <= RegWrite_in;
				MemRead_out <= MemRead_in;
				Branch_out <= Branch_in;
				ALUOp_out <= ALUOp_in;
				
			end if;
		end if;
end process;



end Behavioral;


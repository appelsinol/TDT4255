----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:03:01 10/09/2012 
-- Design Name: 
-- Module Name:    ex_mem - Behavioral 
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

entity ex_mem is
		PORT (CLK : in STD_LOGIC;
				reset : in STD_LOGIC;	
			  processor_en : in STD_LOGIC;
			  -- Write back control lines
			  mem_RegWrite_in : in  STD_LOGIC;
			  mem_MemtoReg_in : in  STD_LOGIC;
			  mem_RegWrite_out : out  STD_LOGIC;
			  mem_MemtoReg_out : out  STD_LOGIC;
			  -- Memory State control lines
			  mem_Branch_in : in  STD_LOGIC;
			  mem_MemRead_in : in  STD_LOGIC;
			  mem_MemWrite_in : in  STD_LOGIC;
			  mem_Branch_out : out  STD_LOGIC;
			  mem_MemRead_out : out  STD_LOGIC;
			  mem_MemWrite_out : out  STD_LOGIC;
			  --input lines for EX_MEM pipeline
			  add_result_in : in STD_LOGIC_VECTOR(31 downto 0);
			  FLAGS_in		: in ALU_FLAGS;
			  alu_result_in : in STD_LOGIC_VECTOR(31 downto 0);
			  read_data_2_in : in STD_LOGIC_VECTOR(31 downto 0);
			  mux_in	:  in STD_LOGIC_VECTOR(4 downto 0);
			   --Output lines for EX_MEM pipeline
			  add_result_out : out STD_LOGIC_VECTOR(31 downto 0);
			  FLAGS_out		: out ALU_FLAGS;
			  alu_result_out : out STD_LOGIC_VECTOR(31 downto 0);
			  read_data_2_out : out STD_LOGIC_VECTOR(31 downto 0);
			  mux_out	:  out STD_LOGIC_VECTOR(4 downto 0)
			  );
end ex_mem;

architecture Behavioral of ex_mem is
begin
		ex_mem_pipeline : process(clk)
		begin
		if (reset = '1') then
			 mem_RegWrite_out <= '0';
			 mem_MemtoReg_out <= '0';
			 mem_Branch_out <= '0';
			 mem_MemRead_out <= '0';
			 mem_MemWrite_out <=  '0';
			 add_result_out <= ZERO32b;
			 alu_result_out <= ZERO32b;
			 FLAGS_out <= FLAGS_in;
			 read_data_2_out <= ZERO32b;
			 mux_out <= mux_in;
		elsif rising_edge(clk)then
			if(processor_en = '1') then
			 mem_RegWrite_out <= mem_RegWrite_in;
			 mem_MemtoReg_out <= mem_MemtoReg_in;
			 mem_Branch_out <= mem_Branch_in;
			 mem_MemRead_out <= mem_MemRead_in;
			 mem_MemWrite_out <=  mem_MemWrite_in;
			 add_result_out <= add_result_in;
			 alu_result_out <= alu_result_in;
			 FLAGS_out <= FLAGS_in;
			 read_data_2_out <= read_data_2_in;
			 mux_out <= mux_in;
		end if;
		end if;
end process;

end Behavioral;


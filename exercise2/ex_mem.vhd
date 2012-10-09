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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex_mem is
			PORT (CLK : in STD_LOGIC;
			  processor_en : in STD_LOGIC;
			  -- Write back control lines
			  RegWrite_in : in  STD_LOGIC;
			  MemtoReg_in : in  STD_LOGIC;
			  RegWrite_out : out  STD_LOGIC;
			  MemtoReg_out : out  STD_LOGIC;
			  -- Memory State control lines
			  Branch_in : in  STD_LOGIC;
			  MemRead_in : in  STD_LOGIC;
			  MemWrite_in : in  STD_LOGIC;
			  Branch_out : out  STD_LOGIC;
			  MemRead_out : out  STD_LOGIC;
			  MemWrite_out : out  STD_LOGIC;
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
		if rising_edge(clk)then
			if(processor_en = '1') then
			 RegWrite_out <= RegWrite_in;
			 MemtoReg_out <= MemtoReg_in;
			 Branch_out <= Branch_in;
			 MemRead_out <= MemRead_in;
			 MemWrite_out <=  MemWrite_in;
			 add_result_out <= add_result_in;
			 FLAGS_out <= FLAGS_in;
			 read_data_2_out <= read_data_2_in;
			 mux_out <= mux_in;
		end if;
		end if;
end process;

end Behavioral;


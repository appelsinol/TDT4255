----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:14 10/09/2012 
-- Design Name: 
-- Module Name:    mem_wb - Behavioral 
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

entity mem_wb is
PORT(
	   CLK : in STD_LOGIC;
		processor_en : in STD_LOGIC;
		data_memory_in : in STD_LOGIC_VECTOR(31 downto 0);
		address_in : in STD_LOGIC_VECTOR(31 downto 0);
		register_no_in : in STD_LOGIC_VECTOR(4 downto 0);
		data_memory_out : out STD_LOGIC_VECTOR(31 downto 0);
		address_out : out STD_LOGIC_VECTOR(31 downto 0);
		register_no_out : out STD_LOGIC_VECTOR(4 downto 0);
		MemtoReg_in : in  STD_LOGIC;
		RegWrite_in : in  STD_LOGIC;
		MemtoReg_out : out  STD_LOGIC;
		RegWrite_out : out  STD_LOGIC
	);
end mem_wb;

architecture Behavioral of mem_wb is

begin
 
pipe_process : process(clk)
		begin
		
		if (rising_edge(clk)) then
			if(processor_en = '1') then
				data_memory_out <= data_memory_in;
				address_out <= address_in;
				register_no_out <= register_no_in;
				MemtoReg_out <= MemtoReg_in;
				RegWrite_out <= RegWrite_in;
			end if;
		end if;
end process;
end Behavioral;


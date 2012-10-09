----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:10 10/09/2012 
-- Design Name: 
-- Module Name:    if_id - Behavioral 
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
entity if_id is
	PORT(
	   CLK : in STD_LOGIC;
		processor_en : in STD_LOGIC;
		incremented_addr_in : in STD_LOGIC_VECTOR(31 downto 0);
		instruction_data_in : in STD_LOGIC_VECTOR(31 downto 0);
		incremented_addr_out : out STD_LOGIC_VECTOR(31 downto 0);
		instruction_data_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end if_id;


architecture Behavioral of if_id is
-- signal allocation according from the book
begin
		pipe_process : process(clk)
		begin
		
		if (rising_edge(clk)) then
			if(processor_en = '1') then
				incremented_addr_out <= incremented_addr_in; 	
				instruction_data_out <= instruction_data_in;
			end if;
		end if;
end process;



end Behavioral;


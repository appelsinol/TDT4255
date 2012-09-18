----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:00:50 09/18/2012 
-- Design Name: 
-- Module Name:    pc - Behavioral 
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

entity pc is
    Port ( 
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR(31 downto 0));
     
          
end pc;

architecture Behavioral of pc is

begin
    PC_PROCESS : process(clk,reset)
    begin 
            if reset = '1' then
                pc_out <= (others =>'0');
            elsif rising_edge(clk) then
                pc_out <= pc_in;
            end if;
    end process;
end Behavioral;


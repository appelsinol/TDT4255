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
library WORK;
use WORK.MIPS_CONSTANT_PKG.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc is
    Port ( 
			  clk : in  STD_LOGIC;
			  pc_en : in STD_LOGIC;
           reset : in  STD_LOGIC;
			  pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR(31 downto 0));
     
          
end pc;

architecture Behavioral of pc is
--signal current_state,next_state:state_type;
--signal pc_temp : STD_LOGIC_VECTOR(31 downto 0);

begin
    PC_PROCESS : process(clk)
    begin 
          if rising_edge(clk) then
					if reset = '1' then
                pc_out <= (others =>'0');
					else
						if pc_en = '1' then 
							PC_OUT <= pc_in;
						end if;
					end if;
				end if;
    end process;
end Behavioral;


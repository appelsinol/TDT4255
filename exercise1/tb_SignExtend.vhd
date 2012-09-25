--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:30:39 09/22/2012
-- Design Name:   
-- Module Name:   Z:/TDT4255/exercise1/tb_SignExtend.vhd
-- Project Name:  ComputerDesignEx1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SignExtend
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_SignExtend IS
END tb_SignExtend;
 
ARCHITECTURE behavior OF tb_SignExtend IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SignExtend
    PORT(
         ins_in : IN  std_logic_vector(15 downto 0);
         extendins_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ins_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal extendins_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SignExtend PORT MAP (
          ins_in => ins_in,
          extendins_out => extendins_out
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

--      wait for <clock>_period*10;

      -- insert stimulus here 
		
		ins_in <= "0000111100001111";
		
		wait for 100ns;
		
		ins_in <= "1111000011110000";

      wait;
   end process;

END;

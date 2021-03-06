----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:51:11 09/19/2012 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is

    Port ( 
		     clk : in STD_LOGIC;
	        reset : in STD_LOGIC;
			  processor_en : in STD_LOGIC;
			  opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out  STD_LOGIC;
			  ALUSrc : out  STD_LOGIC;
			  MemtoReg : out  STD_LOGIC;
			  RegWrite : out  STD_LOGIC;
			  MemRead : out  STD_LOGIC;
			  MemWrite : out  STD_LOGIC;   
           Branch : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR(1 downto 0);
			  PCwrite : out STD_LOGIC;
           Jump : out STD_LOGIC);
end  ControlUnit;



architecture Behavioral of ControlUnit is

-- signal allocation according from the book
signal current_state,next_state:state_type;

begin
		state_process : process(clk,reset)
		begin
		if (reset='1') then
			current_state <= STALL;
	
		elsif (rising_edge(clk)) then
			if(processor_en = '1') then
				current_state <= next_state; 		
			end if;
		end if;
end process;
				

	control_process : process(current_state,opcode,processor_en)
	begin

				
	if(current_state = fetch and processor_en = '1') then
		next_state <= EXEC;
		PCwrite <= '0';
  end if;
	if(current_state = EXEC and processor_en = '1') then
		if opcode = "000000" then -- control signal for R instructions.
			RegDst <= '1';
			ALUSrc <= '0';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUOp <= "10";
			Jump <= '0';
			next_state <= fetch;
			PCwrite <= '1';
		
			  
			  
		elsif opcode = "100011" then   -- control signal for load word.
			RegDst <= '0';
			ALUSrc <= '1';
			MemtoReg <= '1';
			RegWrite <= '1';
			MemRead <= '1';
			MemWrite <= '0';
			Branch <= '0';
			ALUOp <= "00";
			Jump <= '0';
			next_state <= STALL;
			PCwrite <='0';
			
       elsif opcode = "101011" then  -- control singal for save word.
			RegDst <= '0';
			ALUSrc <= '1';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '1';
			Branch <= '0';
			ALUOp <= "00";
			Jump <= '0';
			next_state <= STALL;
			PCwrite <='0';
		
			 
			  
		 elsif opcode = "000100" then  -- control singal for beq.
			RegDst <= '0';
			ALUSrc <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '1';
			ALUOp <= "01";
			Jump <= '0';
			next_state <= fetch;
			PCwrite <='1';
			
		elsif opcode = "001111" then  -- control singal for LDI.
			RegDst <= '1';
			ALUSrc <= '1';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUOp <= "00";
			Jump <= '0';
			next_state <= fetch;
			PCwrite <='1';
			
		 else --opcode = "000010" then  -- control singal for jump.
			RegDst <= '0';
			ALUSrc <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUOp <= "00";
			Jump <= '1';
			next_state <= fetch;
			PCwrite <='1';
		end if;
	elsif(current_state = STALL and processor_en = '1') then
          next_state<= fetch;
          PCwrite <='1';
	end if; 
	
	end process;

end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:02:03 09/20/2012 
-- Design Name: 
-- Module Name:    processor - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library WORK;
use WORK.MIPS_CONSTANT_PKG.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processor is
	GENERIC (
			MEM_ADDR_BUS    : integer := 32;
			MEM_DATA_BUS    : integer := 32
	);
	PORT(
		 clk :in STD_LOGIC;
		 reset: in STD_LOGIC;
		 processor_enable : in STD_LOGIC;
		 dmem_address : out STD_LOGIC_VECTOR(MEM_ADDR_BUS-1 downto 0);
		 dmem_address_wr : out STD_LOGIC_VECTOR(MEM_DATA_BUS-1 downto 0);
		 dmem_write_enable : out STD_LOGIC;
		 dmem_data_in : in  STD_LOGIC_VECTOR(MEM_DATA_BUS-1 downto 0);
		 imem_address : out  STD_LOGIC_VECTOR(MEM_ADDR_BUS-1 downto 0);
		 imem_data_in : in STD_LOGIC_VECTOR(MEM_DATA_BUS-1 downto 0)
		);
end processor;

architecture Behavioral of processor is

-- component for the register
	component register_file is 
	port(
			CLK 			:	in	STD_LOGIC;				
			RESET			:	in	STD_LOGIC;				
			RW				:	in	STD_LOGIC;				
			RS_ADDR 		:	in	STD_LOGIC_VECTOR (RADDR_BUS-1 downto 0); 
			RT_ADDR 		:	in	STD_LOGIC_VECTOR (RADDR_BUS-1 downto 0); 
			RD_ADDR 		:	in	STD_LOGIC_VECTOR (RADDR_BUS-1 downto 0);
			WRITE_DATA	:	in	STD_LOGIC_VECTOR (DDATA_BUS-1 downto 0); 
			RS				:	out	STD_LOGIC_VECTOR (DDATA_BUS-1 downto 0);
			RT				:	out	STD_LOGIC_VECTOR (DDATA_BUS-1 downto 0)
	);
	end component register_file;

--	component ALU
	component alu is
	generic (N: NATURAL);
	port(
		X			: in STD_LOGIC_VECTOR(N-1 downto 0);
		Y			: in STD_LOGIC_VECTOR(N-1 downto 0);
		ALU_IN	: in ALU_INPUT;
		R			: out STD_LOGIC_VECTOR(N-1 downto 0);
		FLAGS		: out ALU_FLAGS
	);
	end component alu;

--	component PC
	component pc is
    Port ( 
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR(31 downto 0));
  end component pc;
 
-- component ControlUnit
  component ControlUnit is
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out  STD_LOGIC;
			  ALUSrc : out  STD_LOGIC;
			  MemtoReg : out  STD_LOGIC;
			  RegWrite : out  STD_LOGIC;
			  MemRead : out  STD_LOGIC;
			  MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR(1 downto 0);
           Jump : out STD_LOGIC);
	end component ControlUnit;

--Component SignExtend
	component SignExtend is
	Port ( 	
			  ins_in : in  STD_LOGIC_VECTOR (15 downto 0);
           extendins_out : out  STD_LOGIC_VECTOR(31 downto 0));
	end component SignExtend;
	
--	Component SignShiftLeft
	component SignShiftLeft2 is
	port(
			shiftLeftIn : in std_logic_vector(31 downto 0);
			shiftLeftOut : out std_logic_vector(31 downto 0)
		);
	end component SignShiftLeft2;

--Component 2 adders, one for pc increment and one for the branch instruction	
	component adder is 
	generic (N: natural);    
	port(
		X	: in	STD_LOGIC_VECTOR(N-1 downto 0);
		Y	: in	STD_LOGIC_VECTOR(N-1 downto 0);
		CIN	: in	STD_LOGIC;
		COUT	: out	STD_LOGIC;
		R	: out	STD_LOGIC_VECTOR(N-1 downto 0)
	);
	end component adder;
	
-- Component ALUcontrol

	component ALUControl is
	PORT(
		instr_15_0 : in STD_LOGIC_VECTOR(15 downto 0);
		ALUop : in STD_LOGIC_VECTOR(1 downto 0);
		ALUopcode : out ALU_INPUT;
	);
	end component ALUControl;
	
-- component Jumpshift
component JumpShift is
	PORT(
		pc_4_instruction : in STD_LOGIC_VECTOR(31 downto 0);
		immediate_ins : in STD_LOGIC_VECTOR(25 downto 0);
		after_shift_instruction : out STD_LOGIC_VECTOR(31 downto 0)
		);
end component JumpShift;
	
-- control signal for the ALU control unit
	signal ins_31_26 : STD_LOGIC_VECTOR (5 downto 0);
	
-- control signal for the R type instructions
	signal ins_25_21_rs : STD_LOGIC_VECTOR(4 downto 0);
	signal ins_20_16_rt : STD_LOGIC_VECTOR(4 downto 0);
	signal ins_15_11_rd : STD_LOGIC_VECTOR(4 downto 0);

-- address for the I type instructions
	signal ins_address : STD_LOGIC_VECTOR(15 downto 0);
	
-- signal after extend
	signal extened_32_address : STD_LOGIC_VECTOR(31 downto 0);

-- signal after left shifting
	signal after_2_left_shifting : STD_LOGIC_VECTOR(31 downto 0);

-- control signal for ALU Control Unit
	signal regDst_signal : STD_LOGIC;
	signal aLUSrc_signal : STD_LOGIC;
	signal memtoReg_signal : STD_LOGIC;
	signal regWrite_signal : STD_LOGIC;
	signal memRead_signal : STD_LOGIC;
	signal memWrite_signal : STD_LOGIC;
	signal branch_signal : STD_LOGIC;
	signal aLUOp_signal : STD_LOGIC_VECTOR(1 downto 0);
	signal jump_signal : STD_LOGIC;

-- other signals
	signal read_data_1 : STD_LOGIC_VECTOR(31 downto 0);
	signal read_data_2 : STD_LOGIC_VECTOR(31 downto 0);
	signal signalToMem_alu_result : STD_LOGIC_VECTOR(31 downto 0);
	signal 

-- signal from pc part
	signal pc_original : STD_LOGIC_VECTOR(31 downto 0);
	signal pc_increment : STD_LOGIC_VECTOR(31 downto 0);
	signal after_shift_adder_signal: STD_LOGIC_VECTOR(31 downto 0);
	
	



end Behavioral;


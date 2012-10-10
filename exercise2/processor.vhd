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
		 dmem_data_out : out  STD_LOGIC_VECTOR (MEM_DATA_BUS-1 downto 0);
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
	generic (N: NATURAL:=32);
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
		     pc_en : in STD_LOGIC;
			  pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR(31 downto 0));
  end component pc;
 
-- component ControlUnit
 component ControlUnit is
  
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
			  clk: STD_LOGIC;
			  reset:STD_LOGIC;
			  processor_en : in STD_LOGIC;
           RegDst : out  STD_LOGIC;
			  ALUSrc : out  STD_LOGIC;
			  MemtoReg : out  STD_LOGIC;
			  RegWrite : out  STD_LOGIC;
			  MemRead : out  STD_LOGIC;
			  MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR(1 downto 0);
--			  PCwrite : out STD_LOGIC;
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
	generic (N: natural:= 32);    
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
		ALUopcode : out ALU_INPUT
	);
	end component ALUControl;

--component JumpShift is
--	PORT(
--		pc_4_instruction : in STD_LOGIC_VECTOR(31 downto 0);
--		immediate_ins : in STD_LOGIC_VECTOR(25 downto 0);
--		after_jump_instruction : out STD_LOGIC_VECTOR(31 downto 0)
--		);
--end component JumpShift;

component if_id is
	PORT(
	   CLK : in STD_LOGIC;
		reset : in STD_LOGIC;
		processor_en : in STD_LOGIC;
		incremented_addr_in : in STD_LOGIC_VECTOR(31 downto 0);
		instruction_data_in : in STD_LOGIC_VECTOR(31 downto 0);
		incremented_addr_out : out STD_LOGIC_VECTOR(31 downto 0);
		instruction_data_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end component if_id;

component id_ex is
	PORT(
	    CLK : in STD_LOGIC;
		reset : in STD_LOGIC;
		processor_en : in STD_LOGIC;
		ex_incremented_addr_in : in STD_LOGIC_VECTOR(31 downto 0);
		read_data_1_in : in STD_LOGIC_VECTOR(31 downto 0);
		read_data_2_in : in STD_LOGIC_VECTOR(31 downto 0);
		sign_extend_in : in STD_LOGIC_VECTOR(31 downto 0);
		instruction_20_16_in : in STD_LOGIC_VECTOR(4 downto 0);
		instruction_15_11_in : in STD_LOGIC_VECTOR(4 downto 0);
		ex_incremented_addr_out : out STD_LOGIC_VECTOR(31 downto 0);
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
-- TODO check the memwrite signal is necessary
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
end component id_ex;

component ex_mem is
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
end component ex_mem;

component mem_wb is
PORT(
	   CLK : in STD_LOGIC;
		reset : in STD_LOGIC;
		processor_en : in STD_LOGIC;
		data_memory_in : in STD_LOGIC_VECTOR(31 downto 0);
		address_in : in STD_LOGIC_VECTOR(31 downto 0);
		register_no_in : in STD_LOGIC_VECTOR(4 downto 0);
		data_memory_out : out STD_LOGIC_VECTOR(31 downto 0);
		address_out : out STD_LOGIC_VECTOR(31 downto 0);
		register_no_out : out STD_LOGIC_VECTOR(4 downto 0);
		wb_MemtoReg_in : in  STD_LOGIC;
		wb_RegWrite_in : in  STD_LOGIC;
		wb_MemtoReg_out : out  STD_LOGIC;
		wb_RegWrite_out : out  STD_LOGIC
	);
end component mem_wb;


------- internal signal for connection of component ----------
	
-- control signal for the ALU control unit
	signal ins_31_26 : STD_LOGIC_VECTOR (5 downto 0);


-- address for the I type instructions
	signal ins_15_0_add : STD_LOGIC_VECTOR(15 downto 0);
	
-- signal after extend
	signal extened_32_address : STD_LOGIC_VECTOR(31 downto 0);


-- control signal for Control Unit
	signal regDst_signal : STD_LOGIC;
	signal aLUSrc_signal : STD_LOGIC;
	signal memtoReg_signal : STD_LOGIC;
	signal regWrite_signal : STD_LOGIC;
	signal memRead_signal : STD_LOGIC;
	signal branch_signal : STD_LOGIC;
	signal aLUOp_signal : STD_LOGIC_VECTOR(1 downto 0);
	signal jump_signal : STD_LOGIC;
--	signal PCwrite_signal: STD_LOGIC;

-- signal for ALUcontrol	
	signal ALUopcode : ALU_INPUT;
	

-- other signals
	signal read_data_1 : STD_LOGIC_VECTOR(31 downto 0);
	signal read_data_2 : STD_LOGIC_VECTOR(31 downto 0);
	signal signalToMem_alu_result : STD_LOGIC_VECTOR(31 downto 0);
	signal alu_mux_result : STD_LOGIC_VECTOR(31 downto 0);
	signal ALUflags : ALU_FLAGS;

-- signal into register file
	signal write_register : STD_LOGIC_VECTOR(4 downto 0);
-- signal from memory to register
	signal memory_to_register : STD_LOGIC_VECTOR(31 downto 0);
-- signal for branch and zero
	signal PCSrc: STD_LOGIC;
	signal branched_result : STD_LOGIC_VECTOR(31 downto 0);
	
-- control signal for the R type instructions
	signal ins_25_21_rs : STD_LOGIC_VECTOR(4 downto 0);
	signal ins_20_16_rt : STD_LOGIC_VECTOR(4 downto 0);



-- signal pc part
--	signal pc_en_signal : STD_LOGIC;
	signal pc_in_result : STD_LOGIC_VECTOR(31 downto 0);
	signal pc_out_internal : STD_LOGIC_VECTOR(31 downto 0);
	signal pc_incremented : STD_LOGIC_VECTOR(31 downto 0);
	signal immediate_address : STD_LOGIC_VECTOR(25 downto 0);
	signal jumped_instr : STD_LOGIC_VECTOR(31 downto 0);
	signal after_shift_adder_signal: STD_LOGIC_VECTOR(31 downto 0);
	signal current_state:state_type;
	
-- signal for if/id pipeline
	signal imem_data_in_out : STD_LOGIC_VECTOR(31 downto 0);
	signal ins_15_11 : STD_LOGIC_VECTOR(4 downto 0);
	signal pc_incremented_id : STD_LOGIC_VECTOR(31 downto 0);
	
-- signal for id/ex pipeline
	signal MemWrite_enable : STD_LOGIC;
	signal pc_incremented_ex : STD_LOGIC_VECTOR(31 downto 0);
	signal ex_sign_extended_out : STD_LOGIC_VECTOR(31 downto 0);
	signal ex_read_data_1 : STD_LOGIC_VECTOR(31 downto 0);
	signal ex_read_data_2 : STD_LOGIC_VECTOR(31 downto 0);
	signal ex_ins_20_16 : STD_LOGIC_VECTOR(4 downto 0);
	signal ex_ins_15_11 : STD_LOGIC_VECTOR(4 downto 0);
	signal ex_RegDst_out : STD_LOGIC;
	signal ex_ALUSrc_out: STD_LOGIC;
	signal ex_MemtoReg_out : STD_LOGIC;
	signal ex_RegWrite_out : STD_LOGIC;
	signal ex_MemRead_out : STD_LOGIC;
	signal ex_MemWrite_out : STD_LOGIC;   
   signal ex_Branch_out : STD_LOGIC;
   signal ex_ALUOp_out : STD_LOGIC_VECTOR(1 downto 0);
	
-- signal for ex/mem pipeline
	signal p_add_result : STD_LOGIC_VECTOR(31 downto 0);
	signal FLAGS_out_mem : ALU_FLAGS;
	signal alu_result_out_mem : STD_LOGIC_VECTOR(31 downto 0);
	signal read_data_2_out_mem : STD_LOGIC_VECTOR(31 downto 0);
	signal mux_out_mem : STD_LOGIC_VECTOR(4 downto 0);		
	signal mem_RegWrite_out_wb : STD_LOGIC;
	signal mem_MemtoReg_out_wb : STD_LOGIC;
	signal mem_Branch_out_out : STD_LOGIC;
	signal mem_MemRead_out_out : STD_LOGIC;
	signal mem_MemWrite_out_out : STD_LOGIC;

--signal for mem/wb pipeline
	signal register_no_wb : STD_LOGIC_VECTOR(4 downto 0);	
	signal wb_MemtoReg_out_result : STD_LOGIC;
	signal wb_RegWrite_out_result : STD_LOGIC;
	signal alu_to_register : STD_LOGIC_VECTOR(31 downto 0);
	signal data_memory_to_register : STD_LOGIC_VECTOR(31 downto 0);


begin

	register_imp : register_file
		PORT MAP(
			CLK => clk,		
			RESET	=> reset,		
			RW	=> wb_RegWrite_out_result,				
			RS_ADDR => ins_25_21_rs,
			RT_ADDR => ins_20_16_rt,
			RD_ADDR => register_no_wb,
			WRITE_DATA => memory_to_register,
			RS	=> read_data_1,
			RT	=> read_data_2
		);
		
	alucontrol_imp : ALUControl
		PORT MAP(
		instr_15_0 => ex_sign_extended_out(15 downto 0),
		ALUop => ex_ALUOp_out,
		ALUopcode => ALUopcode  
		);

	adder_increment_4 : adder
		PORT MAP(
			X => pc_out_internal,
			Y => "00000000000000000000000000000001",
			CIN => '0',
		--	COUT => '0',
			R => pc_incremented
			);
	
	adder_branch : adder
		PORT MAP(
			X => pc_incremented_ex,
			Y => ex_sign_extended_out,
			CIN => '0',
		--	COUT => '0',
			R => after_shift_adder_signal
			);

	signextened_imp : SignExtend
		PORT MAP(
			ins_in => ins_15_0_add,
         extendins_out => extened_32_address
		);
		
	controlunit_imp : ControlUnit
		PORT MAP(
			  clk => clk,
			  reset => reset,
			  processor_en => processor_enable,
			  opcode => ins_31_26,
			  RegDst => regDst_signal,
			  ALUSrc => aLUSrc_signal,
			  MemtoReg => memtoReg_signal,
			  RegWrite => regWrite_signal,
			  MemRead => memRead_signal,
			  MemWrite => dmem_write_enable,
           Branch => branch_signal,
           ALUOp => aLUOp_signal,
--			  PCwrite => PCwrite_signal,
           Jump => jump_signal
		);
	alu_imp : alu
		PORT MAP(
			X => ex_read_data_1,
			Y => alu_mux_result,			
			ALU_IN => ALUopcode ,
			R => signalToMem_alu_result,
			FLAGS	=> ALUflags	
		);
--TODO remove pc_En
	PCregister : PC
		PORT MAP(
			  clk => clk,
           reset => reset,
			  pc_en => processor_enable,
			  pc_in => pc_in_result,
           pc_out => pc_out_internal
		);
--	jumpshift_imp : JumpShift
--		PORT MAP(
--			pc_4_instruction => pc_incremented,
--			after_jump_instruction => jumped_instr,
--			immediate_ins => immediate_address 
--			);
			
	if_id_imp : if_id
	PORT MAP(
				CLK => clk,
				reset => reset,
				processor_en => processor_enable,
				incremented_addr_in => pc_incremented,
				instruction_data_in => imem_data_in,
				incremented_addr_out => pc_incremented_id,
				instruction_data_out => imem_data_in_out
	);
	
  id_ex_imp : id_ex
	PORT MAP(
	   CLK => clk,
		reset => reset,
		processor_en => processor_enable,
		ex_incremented_addr_in => pc_incremented_id,
		read_data_1_in => read_data_1,
		read_data_2_in => read_data_2,
		sign_extend_in => extened_32_address,
		instruction_20_16_in => ins_20_16_rt,
		instruction_15_11_in => ins_15_11,
		ex_incremented_addr_out => pc_incremented_ex,
		read_data_1_out => ex_read_data_1,
		read_data_2_out => ex_read_data_2,
		sign_extend_out => ex_sign_extended_out,
		instruction_20_16_out => ex_ins_20_16,
		instruction_15_11_out => ex_ins_15_11,
		RegDst_in => regDst_signal,
	   ALUSrc_in => aLUSrc_signal,
		MemtoReg_in => memtoReg_signal,
		RegWrite_in => regWrite_signal,
	   MemRead_in => memRead_signal,
		MemWrite_in => MemWrite_enable,
      Branch_in => branch_signal,
      ALUOp_in  => aLUOp_signal,
     
		RegDst_out => ex_RegDst_out,
	   ALUSrc_out => ex_ALUSrc_out,
		MemtoReg_out => ex_MemtoReg_out,
		RegWrite_out => ex_RegWrite_out, 
	   MemRead_out => ex_MemRead_out, 
		MemWrite_out => dmem_write_enable,  
      Branch_out => ex_Branch_out,
      ALUOp_out => ex_ALUOp_out
 );

 ex_mem_imp : ex_mem
		PORT MAP(CLK => clk,
				reset => reset,
			  processor_en  => processor_enable,
			  -- Write back control lines
			  mem_RegWrite_in  => ex_RegWrite_out, 
			  mem_MemtoReg_in => ex_MemtoReg_out,
			  mem_RegWrite_out => mem_RegWrite_out_wb,
			  mem_MemtoReg_out => mem_MemtoReg_out_wb,
			  -- Memory State control lines
			  mem_Branch_in  => ex_Branch_out,
			  mem_MemRead_in => ex_MemRead_out, 
			  mem_MemWrite_in  => ex_MemWrite_out,
			  mem_Branch_out => mem_Branch_out_out,
			  mem_MemRead_out => mem_MemRead_out_out,
			  mem_MemWrite_out => mem_MemWrite_out_out,
			  --input lines for EX_MEM pipeline
			  add_result_in => after_shift_adder_signal,
			  FLAGS_in	=> ALUflags,
			  alu_result_in => signalToMem_alu_result,
			  read_data_2_in  => ex_read_data_2,
			  mux_in	=> write_register,
			   --Output lines for EX_MEM pipeline
			  add_result_out => p_add_result,
			  FLAGS_out		=> FLAGS_out_mem,
			  alu_result_out => alu_result_out_mem,
			  read_data_2_out => read_data_2_out_mem,
			  mux_out => mux_out_mem
			  );
			  
 mem_wb_imp : mem_wb
PORT MAP(
	   CLK => clk,
		reset => reset,
		processor_en => processor_enable,
		data_memory_in => dmem_data_in,
		address_in => alu_result_out_mem,
		register_no_in => mux_out_mem,
		data_memory_out => data_memory_to_register,
		address_out => alu_to_register,
		register_no_out => register_no_wb,
		wb_MemtoReg_in => mem_MemtoReg_out_wb,
		wb_RegWrite_in => mem_RegWrite_out_wb,
		wb_MemtoReg_out => wb_MemtoReg_out_result,
		wb_RegWrite_out => wb_RegWrite_out_result
	);



				
--	pc_en_signal <= PCwrite_signal or branch_and_zero;
--	MemWrite_enable <= dmem_write_enable;
	PCSrc <= mem_Branch_out_out and FLAGS_out_mem.ZERO;
	
	mux_register : process(ex_ins_20_16,ex_ins_15_11,ex_RegDst_out)
	begin
		if ex_RegDst_out = '0' then
			write_register <= ex_ins_20_16;
		else
			write_register <= ex_ins_15_11;
		end if;
	end process;
	
	mux_memToReg : process(dmem_data_in,alu_to_register, wb_MemtoReg_out_result)
	begin
		if wb_MemtoReg_out_result = '1' then
			memory_to_register <= dmem_data_in;
		else
			memory_to_register <= alu_to_register;
		end if;
	end process;
		
	mux_alu : process(ex_ALUSrc_out,ex_read_data_2,ex_sign_extended_out)
	begin
		if ex_ALUSrc_out = '0' then
			alu_mux_result <= ex_read_data_2;
		else
			alu_mux_result <= ex_sign_extended_out;
		end if;
	end process;
	
--	mux_add : process(after_shift_adder_signal,pc_incremented,branch_and_zero)
--	begin
--		if branch_and_zero = '1' then
--			branched_result <= after_shift_adder_signal;
--		else
--			branched_result <= pc_incremented;
--		end if;
--	end process;
	
	mux_branch : process(p_add_result,PCSrc,pc_incremented)
	begin
		if PCSrc = '1' then
		    pc_in_result <= p_add_result;
		else 
          pc_in_result <= pc_incremented;
		end if;
	end process;
			
			


		

	
	mapping_instruction_to_bus: process(imem_data_in_out,processor_enable)
	begin
	if (processor_enable = '1') then
	ins_31_26 <= imem_data_in_out(31 downto 26);
	ins_25_21_rs <= imem_data_in_out(25 downto 21);
	ins_20_16_rt <= imem_data_in_out(20 downto 16);
	ins_15_11 <= imem_data_in_out(15 downto 11);
	ins_15_0_add <= imem_data_in_out(15 downto 0);
	end if;
   end process;
	
	processor_re: process(processor_enable,read_data_2_out_mem,alu_result_out_mem)
	begin
		if (processor_enable = '1') then
				dmem_data_out <= read_data_2_out_mem;
				dmem_address <= alu_result_out_mem;
				dmem_address_wr <= alu_result_out_mem;
			end if;
	end process;
	
	mapping_pc_instruction : process(pc_out_internal)
	begin
		imem_address <= pc_out_internal;
	end process;
	
end Behavioral;


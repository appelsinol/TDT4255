    --------------------------------------------------------------------------------
    -- Company:
    -- Engineer:
    --
    -- Create Date:   15:54:20 05/03/2012
    -- Design Name:  
    -- Module Name:   E:/My-documents/Dropbox/tdt4255_final/single_cycle/tb_everythingelse.vhd
    -- Project Name:  single_cycle
    -- Target Device:  
    -- Tool versions:  
    -- Description:  
    -- 
    -- VHDL Test Bench Created by ISE for module: toplevel
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
     
    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;
     
    -- Uncomment the following library declaration if using
    -- arithmetic functions with Signed or Unsigned values
    --USE ieee.numeric_std.ALL;
     
    ENTITY tb_everythingelse IS
    END tb_everythingelse;
     
    ARCHITECTURE behavior OF tb_everythingelse IS
     
        -- Component Declaration for the Unit Under Test (UUT)
     
        COMPONENT toplevel
        PORT(
             clk : IN  std_logic;
             reset : IN  std_logic;
             command : IN  std_logic_vector(0 to 31);
             bus_address_in : IN  std_logic_vector(0 to 31);
             bus_data_in : IN  std_logic_vector(0 to 31);
             status : OUT  std_logic_vector(0 to 31);
             bus_data_out : OUT  std_logic_vector(0 to 31)
            );
        END COMPONENT;
       
     
       --Inputs
       signal clk : std_logic := '0';
       signal reset : std_logic := '0';
       signal command : std_logic_vector(0 to 31) := (others => '0');
       signal bus_address_in : std_logic_vector(0 to 31) := (others => '0');
       signal bus_data_in : std_logic_vector(0 to 31) := (others => '0');
     
            --Outputs
       signal status : std_logic_vector(0 to 31);
       signal bus_data_out : std_logic_vector(0 to 31);
     
       -- Clock period definitions
       constant clk_period : time := 40 ns;
           
            constant zero : std_logic_vector(0 to 31) := "00000000000000000000000000000000";
           
            constant addr1 : std_logic_vector(0 to 31) := "00000000000000000000000000000001";
            constant addr2 : std_logic_vector(0 to 31) := "00000000000000000000000000000010";
            constant addr3 : std_logic_vector(0 to 31) := "00000000000000000000000000000011";
            constant addr4 : std_logic_vector(0 to 31) := "00000000000000000000000000000100";
            constant addr5 : std_logic_vector(0 to 31) := "00000000000000000000000000000101";
            constant addr6 : std_logic_vector(0 to 31) := "00000000000000000000000000000110";
            constant addr7 : std_logic_vector(0 to 31) := "00000000000000000000000000000111";
            constant addr8 : std_logic_vector(0 to 31) := "00000000000000000000000000001000";
            constant addr9 : std_logic_vector(0 to 31) := "00000000000000000000000000001001";
            constant addr10 : std_logic_vector(0 to 31):= "00000000000000000000000000001010";
            constant addr11 : std_logic_vector(0 to 31):= "00000000000000000000000000001011";
            constant addr12 : std_logic_vector(0 to 31):= "00000000000000000000000000001100";
            constant addr13 : std_logic_vector(0 to 31):= "00000000000000000000000000001101";
            constant addr14 : std_logic_vector(0 to 31):= "00000000000000000000000000001110";
            constant addr15 : std_logic_vector(0 to 31):= "00000000000000000000000000001111";
            constant addr16 : std_logic_vector(0 to 31):= "00000000000000000000000000010000";
            constant addr17 : std_logic_vector(0 to 31):= "00000000000000000000000000010001";
            constant addr18 : std_logic_vector(0 to 31):= "00000000000000000000000000010010";
       
            constant data1 : std_logic_vector(0 to 31):= "00000000000000000000000000001010";        -- 10
            constant data2 : std_logic_vector(0 to 31):= "00000000000000000000000000000010";        -- 2
           
            constant IDLE : std_logic_vector(0 to 31)               := "00000000000000000000000000100010";          --      Do Nothing              00 00 00 22
            constant LOAD_1 : std_logic_vector(0 to 31)     := "10001100000000010000000000000001";          -- LW   $1 $0(1)                8C $4 $0(1)
            constant LOAD_2 : std_logic_vector(0 to 31)     := "10001100000000100000000000000010";          -- LW   $2 $0(2)                8C $4 $0(1)
            constant LDI_1 : std_logic_vector(0 to 31)      := "00111100000000010000000000000110";          -- LDI  $1 06           3C 01 00 06
        constant LDI_2 : std_logic_vector(0 to 31)  := "00111100000000100000000000001000";          -- LDI  $2 08           3C 02 00 08    
            constant ADD : std_logic_vector(0 to 31)                := "00000000001000100001100000100000";          -- ADD  $3 $2 $1        00 22 18 20
            constant SW : std_logic_vector(0 to 31)         := "10101100000000110000000000000101";          -- SW   $3 $0(5)                AC 03 00 01
            constant BEQ : std_logic_vector(0 to 31)                := "00010000000000000000000000000011";          -- BEQ  $0 $0(3)                AC 03 00 01
       
        --Additional constants for testing
            constant SUB    : std_logic_vector(0 to 31)             := "00000000001000100001100000100010";          -- SUB  $3 $1 $2        00 22 18 22
            constant SLT    : std_logic_vector(0 to 31)             := "00000000100001010011000000101010";          -- SLT  $6 $4 $5
            constant COMMAND_AND    : std_logic_vector(0 to 31)             := "00000000100000010010100000100100";          -- AND  $5 $4 $1
            constant COMMAND_OR             : std_logic_vector(0 to 31)             := "00000000011000100010000000100101";          -- OR   $4 $3 $2        00 62 20 25
            constant BEQ_2  : std_logic_vector(0 to 31)             := "00010000010001000000000000000011";                                  -- BEQ $2 $4 3 // jump relative to pc 3 instructions
            constant JMP    : std_logic_vector(0 to 31)             := "00001000000000000000000000001101";                                  -- JMP addr13
            constant ADD_2  : std_logic_vector(0 to 31)             := "00000000011000100001000000100000";          -- ADD  $2 $2 $3
            constant ADD_3  : std_logic_vector(0 to 31)             := "00000000010000010000100000100000";          -- ADD  $1 $1 $2
            constant LOAD_3 : std_logic_vector(0 to 31)             := "10001100000001000000000000000101";          -- LW   $4 $0(5)
            constant LDI_3  : std_logic_vector(0 to 31)             := "00111100000000010000000000000000";          -- LDI  $1 00  
            constant LDI_4  : std_logic_vector(0 to 31)             := "00111100000000100000000000000000";          -- LDI  $2 00
            constant LDI_5  : std_logic_vector(0 to 31)             := "00111100000000110000000000000001";          -- LDI  $3 01
            constant LDI_6  : std_logic_vector(0 to 31)             := "00111100000001000000000000000101";          -- LDI  $4 05
       
        constant CMD_IDLE   : std_logic_vector(0 to 31) := "00000000000000000000000000000000";
            constant CMD_WI : std_logic_vector(0 to 31) := "00000000000000000000000000000001";
            constant CMD_RD : std_logic_vector(0 to 31) := "00000000000000000000000000000010";
            constant CMD_WD : std_logic_vector(0 to 31) := "00000000000000000000000000000011";
            constant CMD_RUN        : std_logic_vector(0 to 31) := "00000000000000000000000000000100";
           
     
    BEGIN
     
            -- Instantiate the Unit Under Test (UUT)
       uut: toplevel PORT MAP (
              clk => clk,
              reset => reset,
              command => command,
              bus_address_in => bus_address_in,
              bus_data_in => bus_data_in,
              status => status,
              bus_data_out => bus_data_out
            );
     
       -- Clock process definitions
       clk_process :process
       begin
                    clk <= '0';
                    wait for clk_period/2;
                    clk <= '1';
                    wait for clk_period/2;
       end process;
     
     
       -- Stimulus process
       stim_proc: process
           
       begin               
           
          -- hold reset state for 100 ns.
          wait for 20 ns;  
     
          -- insert stimulus here
                   
    --TEST THE FOLLOWING ASSEMBLY CODE
    --LW    $1 10
    --LW    $2 2
    --SUB   $3 $1 $2
    --SW    $3 $0(5)
    --OR    $4 $3 $2
    --AND   $5 $4 $1
    --SLT   $6 $4 $5
    --LW    $4 $0(5)
     
    --LDI   $1 00                   --variable SUM
    --LDI   $2 00                   --variable i
    --LDI   $3 01                   --constant 1
    --LDI   $4 05                   --constant 5
    --BEQ   $2 $4 addr17
    --ADD   $2 $2 $3                --i++
    --ADD   $1 $1 $2                --SUM=SUM+i
    --JMP   JMP addr13
     
                   
                    -- INSTR: WRITE DATA TO DMEM : addr1 = 10, addr 2 = 2
                   
                    command <= CMD_WD;                                     
          bus_address_in <= addr1;
          bus_data_in <= data1;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
                   
                    command <= CMD_WD;                                     
          bus_address_in <= addr2;
          bus_data_in <= data2;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
                   
                   
                    -- INSTR-1: LOAD DATA TO REGISTER : LW $1 10
                   
                    command <= CMD_WI;                                     
          bus_address_in <= addr1;
          bus_data_in <= LOAD_1;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
                   
                    -- INSTR-2: LOAD DATA TO REGISTER : LW $2 2
                    command <= CMD_WI;                                     
          bus_address_in <= addr2;
          bus_data_in <= LOAD_2;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
                   
                    -- INSTR-3: SUB (R3 = R1 + R2) : SUB $3 $1 $2
                    command <= CMD_WI;                                     
          bus_address_in <= addr3;
          bus_data_in <= SUB;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
                   
                    -- INSTR-4: STORE TO DMEM : SW $3 $0(5)
                    command <= CMD_WI;                                     
          bus_address_in <= addr4;
          bus_data_in <= SW;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
     
              -- INSTR-5: OR $4 $3 $2
                    command <= CMD_WI;
          bus_address_in <= addr5;
          bus_data_in <= COMMAND_OR;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-6: AND $5 $4 $1
                    command <= CMD_WI;
          bus_address_in <= addr6;
          bus_data_in <= COMMAND_AND;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-7: SLT $6 $4 $5
                    command <= CMD_WI;
          bus_address_in <= addr7;
          bus_data_in <= SLT;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-8: LW $4 $0(5)
                    command <= CMD_WI;
          bus_address_in <= addr8;
          bus_data_in <= LOAD_3;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-9: LDI $1 00
                    command <= CMD_WI;
          bus_address_in <= addr9;
          bus_data_in <= LDI_3;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-10: LDI $2 00
                    command <= CMD_WI;
          bus_address_in <= addr10;
          bus_data_in <= LDI_4;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-11: LDI $3 01
                    command <= CMD_WI;
          bus_address_in <= addr11;
          bus_data_in <= LDI_5;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-12: LDI $4 05
                    command <= CMD_WI;
          bus_address_in <= addr12;
          bus_data_in <= LDI_6;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-13: BEQ $2 $4 addr17
                    command <= CMD_WI;
          bus_address_in <= addr13;
          bus_data_in <= BEQ_2;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-14: ADD $2 $2 $3
                    command <= CMD_WI;
          bus_address_in <= addr14;
          bus_data_in <= ADD_2;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-15: ADD $1 $1 $2
                    command <= CMD_WI;
          bus_address_in <= addr15;
          bus_data_in <= ADD_3;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
              -- INSTR-16: JMP addr13
                    command <= CMD_WI;
          bus_address_in <= addr16;
          bus_data_in <= JMP;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
             
                    -- NOTHING               TODO: Increment addresses
                    command <= CMD_WI;                                     
          bus_address_in <= addr17;
          bus_data_in <= IDLE;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
                   
                    command <= CMD_WI;                                     
          bus_address_in <= addr18;
          bus_data_in <= IDLE;
          wait for clk_period*3;
         
          command <= CMD_IDLE;                                     
          bus_address_in <= zero;
          bus_data_in <= zero;
          wait for clk_period*3;
                   
                    command <= CMD_RUN;                                    
          bus_address_in <= zero;
          bus_data_in <= zero;
                    wait for clk_period*100;
     
          wait;
       end process;
     
    END;

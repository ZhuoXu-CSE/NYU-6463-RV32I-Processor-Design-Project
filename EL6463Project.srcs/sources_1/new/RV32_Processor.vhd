----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2021 05:06:52 AM
-- Design Name: 
-- Module Name: RV32_Processor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RV32IProcessor is
  Port ( 
    clk: in std_logic := '0';
    rst: in std_logic := '1'; 
    
    cpu_out: out std_logic_vector(31 downto 0)
  );
end RV32IProcessor;

architecture behavior of RV32IProcessor is

signal reg_rd_mux : std_logic_vector(31 downto 0); 
signal alu_mux_1 : std_logic_vector(31 downto 0); 
signal alu_mux_2 : std_logic_vector(31 downto 0); 
signal output_mux : std_logic_vector(31 downto 0) := (others => '0'); 
signal pc_mux: STD_LOGIC := '1';
signal pc_enable: STD_LOGIC := '0'; 
signal IM_enable: STD_LOGIC := '1'; 
signal rs1: std_logic_vector(4 downto 0) := "00000"; 
signal rs2: std_logic_vector(4 downto 0) := "00000";
signal rd: std_logic_vector(4 downto 0) := "00000";
signal reg_we: std_logic := '0';
signal reg_rd_input: std_logic := '1';
signal bc_oper: std_logic_vector(2 downto 0);
signal alu_oper: std_logic_vector(3 downto 0);
signal use_rs1: std_logic := '1';
signal use_rs2: std_logic := '1'; 
signal immed: std_logic_vector(31 downto 0) := X"00000000";
signal mem_write: std_logic_vector( 2 downto 0) := "000"; 
signal mem_read: std_logic_vector( 2 downto 0) := "000"; 
signal use_alu: std_logic := '1'; 
signal bc: std_logic := '0'; 
signal extension_out: std_logic_vector(9 downto 0); 
signal t_pc_addr_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal t_pc_addr_next: STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); 
signal t_instr: std_logic_vector(31 downto 0);
signal t_instr2: std_logic_vector(31 downto 0);
signal t_ReadData1 : std_logic_vector(31 downto 0); 
signal t_ReadData2 : std_logic_vector(31 downto 0);
signal t_imm_out: std_logic_vector(31 downto 0);
signal t_ALU_RESULT: STD_LOGIC_VECTOR(31 downto 0);
signal t_mem_data_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal t_data_ext: std_logic_vector(31 downto 0);
signal out_con_sig: std_logic_vector(13 downto 0);
signal sig_cpu_out: std_logic_vector(31 downto 0);
 signal t_Flag_Zero : STD_LOGIC; 
 signal t_Flag_Negative : STD_Logic;   

component Program_Counter is
  Port (
    clk : IN STD_LOGIC := '0';
    rst : IN STD_LOGIC := '1'; 
    advcounter: IN STD_LOGIC := '0'; 
    next_addr: IN STD_LOGIC := '1';
    addr_in: IN STD_LOGIC_VECTOR(31 downto 0) := X"01000000";
    addr_out: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    addr_next: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
   );
end component;

component Instruction_Memory is
  Port ( 
    clk : IN STD_LOGIC := '0';
    rst : IN STD_LOGIC := '1';
    read_instr: IN STD_LOGIC := '1'; 
    addr_in: IN STD_LOGIC_VECTOR(31 downto 0) := X"01000000";
    addr_in2: IN STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    instr_out: OUT STD_LOGIC_VECTOR(31 downto 0);
    instr_out2: OUT STD_LOGIC_VECTOR(31 downto 0);
    read_enable: IN STD_LOGIC_VECTOR(2 downto 0) := "000" 
  );
end component;

component Control_Unit is
  Port ( 
    clk: in std_logic := '0';
    rst: in std_logic := '1'; 
    instruction: in std_logic_vector(31 downto 0);
    pc_mux: OUT STD_LOGIC := '1';
    pc_enable: OUT STD_LOGIC := '0'; 
    IM_enable: OUT STD_LOGIC := '1';
    rs1: out std_logic_vector(4 downto 0) := "00000"; 
    rs2: out std_logic_vector(4 downto 0) := "00000";
    rd: out std_logic_vector(4 downto 0) := "00000";
    reg_we: out std_logic := '0';
    rd_input: out std_logic := '1';    
    bc_oper: out std_logic_vector(2 downto 0);   
    alu_out: out std_logic_vector(3 downto 0);
    alu_1: out std_logic := '1'; 
    alu_2: out std_logic := '1'; 
    immed: out std_logic_vector(31 downto 0) := X"00000000";
    mem_write: out std_logic_vector( 2 downto 0) := "000"; 
    mem_read: out std_logic_vector( 2 downto 0) := "000";    
    use_alu: out std_logic := '1'; 
    bc: in std_logic := '0';    
    extension_out: out std_logic_vector(9 downto 0) 
  );
end component; 

component reg_file is
    Port (
            CLK                  : in std_logic;
            ReadReg1, ReadReg2   : in std_logic_vector(4 downto 0);
            ReadData1, ReadData2 : out std_logic_vector(31 downto 0);
            WriteReg             : in std_logic_vector(4 downto 0);
            WriteData            : in std_logic_vector(31 downto 0);
            WriteEnable          : in std_logic
    );
end component;

component ALU_Results is
    Port ( rs1        : in STD_LOGIC_VECTOR (31 downto 0); 
           rs2        : in STD_LOGIC_VECTOR (31 downto 0);
           BC_Control : in std_logic_vector(2 downto 0);
           compare    : out STD_LOGIC
         );
end component;

component Imm_ext is
    Port (
        imm_in: in std_logic_vector(31 downto 0);  
        imm_out: out std_logic_vector(31 downto 0); 
        opc_in: in std_logic_vector(9 downto 0)     
    );
end component;

component ALU is
    Port ( SrcA : in STD_LOGIC_VECTOR (31 downto 0);
           SrcB : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_Control : in std_logic_vector(3 downto 0);
           ALU_Result : out STD_LOGIC_VECTOR (31 downto 0);
           Flag_Zero : out STD_LOGIC;
           Flag_Negative : out STD_Logic);
end component;

component Memory is
  Port ( 
    clk : IN STD_LOGIC := '0';
    rst : IN STD_LOGIC := '1'; 
    MEM_WE: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    MEM_RE: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    addr_in: IN STD_LOGIC_VECTOR(31 downto 0) := X"80000000";
    data_in: IN STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    opc_in: in std_logic_vector(9 downto 0);
    data_out: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    instr_in: IN STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
  );
end component;

begin

Unit1: Program_Counter 
  Port Map(
    clk => clk,
    rst => rst, 
    advcounter => pc_enable, 
    next_addr => pc_mux, 
    addr_in => t_ALU_RESULT,
    addr_out => t_pc_addr_out,
    addr_next => t_pc_addr_next
   );

Unit2: Instruction_Memory 
  Port Map( 
    clk => clk,
    rst => rst,
    read_instr => IM_enable, 
    addr_in => t_pc_addr_out,
    addr_in2 => t_ALU_RESULT,
    instr_out => t_instr,
    instr_out2 => t_instr2,
    read_enable => mem_read
  );

Unit3: Control_Unit 
  Port Map( 
    clk => clk,
    rst => rst,
    instruction => t_instr,
    pc_mux => pc_mux , 
    pc_enable => pc_enable,
    IM_enable => IM_enable, 
    rs1 => rs1, 
    rs2 => rs2,
    rd => rd,
    reg_we => reg_we, 
    rd_input => reg_rd_input, 
    bc_oper => bc_oper,
    alu_out => alu_oper,
    alu_1 => use_rs1, 
    alu_2 => use_rs2,
    immed => immed, 
    mem_write => mem_write, 
    mem_read => mem_read, 
    use_alu => use_alu, 
    bc => bc, 
    extension_out => extension_out
  );

Unit4: reg_file 
    Port Map(
            CLK                  => clk,
            ReadReg1             => rs1,
            ReadReg2             => rs2,
            ReadData1            => t_ReadData1,
            ReadData2            => t_ReadData2,
            WriteReg             => rd,
            WriteData            => reg_rd_mux,
            WriteEnable          => reg_we
    );

Unit5: Imm_ext 
    Port Map(
        imm_in => immed,  
        imm_out => t_imm_out,
        opc_in => extension_out    
    );

Unit6: ALU 
    Port Map(SrcA => alu_mux_1,
             SrcB => alu_mux_2,
             ALU_Control => alu_oper,
             ALU_Result => t_ALU_RESULT,
             Flag_Zero => t_Flag_Zero,
             Flag_Negative => t_Flag_Negative);

Unit7: Memory 
  Port Map( 
    clk => clk,
    rst => rst,
    MEM_WE => mem_write,
    MEM_RE => mem_read, 
    addr_in => t_ALU_RESULT,
    data_in => t_ReadData2,
    opc_in => extension_out,
    data_out => t_mem_data_out,
    instr_in => t_instr2
  );

Unit8: ALU_Results 
    Port Map(  rs1        => t_ReadData1,
               rs2        => t_ReadData2,
               BC_Control => bc_oper,
               compare    => bc
             );

with reg_rd_input select reg_rd_mux <=
    output_mux when '1',
    t_pc_addr_next when others;
    
with use_rs1 select alu_mux_1 <= 
    t_ReadData1 when '1',
    t_pc_addr_out when others;
    
with use_rs2 select alu_mux_2 <=
    t_ReadData2 when '1',
    t_imm_out when others;    

with use_alu select output_mux <=
    t_ALU_RESULT when '1',
    t_data_ext when others;    

out_con_sig <= reg_we & reg_rd_input & rd & extension_out(6 downto 0);
with out_con_sig select sig_cpu_out <= 
    output_mux when "1100000"&"0110011" | "1100000"&"0000011" | "1100000"&"0010011",
    (others => '0') when others;    

cpu_out <= sig_cpu_out;

end behavior;


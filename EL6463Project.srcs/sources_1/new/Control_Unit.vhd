----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Control_Unit is
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
    bc_oper: out std_logic_vector(2 downto 0) := "000";
    alu_out: out std_logic_vector(3 downto 0) := "0000";
    alu_1: out std_logic := '1'; 
    alu_2: out std_logic := '1'; 
    immed: out std_logic_vector(31 downto 0) := X"00000000";
    mem_write: out std_logic_vector( 2 downto 0) := "000"; 
    mem_read: out std_logic_vector( 2 downto 0) := "000";    
    use_alu: out std_logic := '1'; 
    bc: in std_logic := '0';    
    extension_out: out std_logic_vector(9 downto 0) 
  );
end Control_Unit; 

architecture behavior of Control_Unit is

signal opcode: std_logic_vector(6 downto 0);
signal funct7: std_logic_vector(6 downto 0);
signal funct3: std_logic_vector(2 downto 0);
signal stop_flag : std_logic := '0';
signal combinekey: std_logic_vector(9 downto 0);
TYPE StateType IS (pre_stg, DM_stg, PC_stg, IM_stg, stop_stg);
SIGNAL state : StateType := IM_stg;

begin

opcode <= instruction(6 downto 0);

process(instruction, opcode,funct3,funct7) begin
if (opcode = "0110111") or (opcode = "0010111") or (opcode = "1101111") then
    funct3 <= "000";
else
    funct3 <= instruction(14 downto 12);
end if;
    
combinekey <= funct3 & opcode;
extension_out <= combinekey;

if (combinekey = "1010110011") or (combinekey = "1010010011") or (combinekey = "0000110011") then
    funct7<= instruction(31 downto 25);
else
    funct7<= "0000000";
end if;

if (opcode = "0110011") then
        case funct3 is
        when "000" => 
            if (funct7 = "0000000") then
                alu_out <= "0000";                        
            else 
                alu_out <= "0001";                    
            end if;
        when "001" => 
            alu_out <= "0010";
        when "010" => --SLT
            alu_out <= "0011";
        when "011" => --SLTU
            alu_out <= "0100";
        when "100" => --xor
            alu_out<= "0101";
        when "101" => --SRL or SRA
            if (funct7 = "0000000") then
                alu_out <= "0110";                        
            else 
                alu_out <= "0111";                    
            end if;
        when "110" => --OR
            alu_out <= "1000";
        when "111" => --AND
            alu_out<= "1001";    
        when others => null;
    end case;
end if; 
   
if (opcode = "0010011") then
        case funct3 is
        when "000" => --ADD
            alu_out <= "0000";                    
        when "001" => --SLL
            alu_out <= "0010";
        when "010" => --SLT
            alu_out <= "0011";
        when "011" => --SLTU
            alu_out <= "0100";
        when "100" => --xor
            alu_out<= "0101";
        when "101" => --SRL or SRA
            if (funct7 = "0000000") then
                alu_out <= "0110";                        
            else 
                alu_out <= "0111";                    
            end if;
        when "110" => --OR
            alu_out <= "1000";
        when "111" => --AND
            alu_out<= "1001";    
        when others => null;
    end case;
end if;    

if (opcode = "1100011") then            
    case funct3 is
        when "000" => --EQ
            bc_oper <= "000";
        when "001" => --NE
            bc_oper <= "001";
        when "100" => --LT
            bc_oper<= "010";
        when "101" => --GE
            bc_oper <= "011";
        when "110" => --LHU
            bc_oper <= "100";
        when "111" => --GEU
            bc_oper<= "101";
        when others => null;
    end case;
end if;

if (opcode = "0001111") or (opcode = "0110111") then
    rs1 <= "00000";
else
    rs1 <= instruction(19 downto 15);
end if;

rs2  <= instruction(24 downto 20);


if (opcode = "0001111") then
    rd <= "00000";
else
    rd <= instruction(11 downto  7);
end if;

if (combinekey = "0001101111") or (combinekey = "0001100111") then
    rd_input <= '0';
else
    rd_input <= '1';
end if;
    
if (opcode = "0010111") or (opcode = "1101111") or (opcode = "1100011") then
    alu_1 <= '0';
else
    alu_1 <= '1';
end if;
    
if (opcode = "0110011")then
    alu_2 <= '1';
else
    alu_2 <= '0';
end if;    

if (opcode = "0000011") or (opcode = "1100111") or (opcode = "0010011") then
    immed <=X"00000" & instruction(31 downto 20);
elsif (opcode = "0100011") then
    immed <=X"00000" & instruction(31 downto 25) & instruction(11 downto 7);
elsif (opcode = "1100011") then
    immed <="000" & X"0000" & instruction(31) & instruction(7) & instruction(30 downto 25) & instruction(11 downto 8) & '0';
elsif (opcode = "0110111") or (opcode = "0010111") then
    immed <= instruction(31 downto 12) & X"000";
elsif (opcode = "1101111") then
    immed <= "000" & X"00" & instruction(31) & instruction(19 downto 12) & instruction(20) & instruction(30 downto 21) & '0';
else
    immed <= X"00000000";
end if;

if (opcode = "0000011")then
    use_alu <= '0';
else
    use_alu <= '1';
end if;  

if (bc = '1') then
    if (opcode = "1100011") or (opcode = "1101111") or (opcode = "1100111") then
        pc_mux <= '0';
    else
        pc_mux <= '1';
    end if;
else
    if (opcode = "1101111") or (opcode = "1100111") then
        pc_mux <= '0';
    else
        pc_mux <= '1';
    end if;
end if;

end process;

process(rst,opcode) begin
    if(rst = '0') then
        stop_flag <= '0';
    elsif(opcode = "1110011") then
        stop_flag <= '1';
    end if;
end process;

PROCESS(rst, clk) BEGIN 
    IF(rst='0') THEN
        state <= IM_stg;
        
    ELSIF(rising_edge(clk)) THEN
        IF(stop_flag = '1') THEN
            state <= stop_stg;
        ELSE
            CASE state IS
                WHEN pre_stg =>
                    state <= DM_stg;
                WHEN DM_stg=>
                    state<=PC_stg;
                WHEN PC_stg=>
                    state <= IM_stg;
                WHEN IM_stg =>
                    state <= pre_stg;
                WHEN stop_stg =>
                    if(stop_flag = '1') then
                        NULL;
                    else
                        state <= pre_stg;
                    end if;
            END CASE;
        END IF;
    END IF;
END PROCESS;

process(rst,state) begin
    if(rst = '0') then
        pc_enable <= '0';
    elsif(state=PC_stg) then
        pc_enable <= '1';
    else
        pc_enable <= '0';
    end if;
end process;

process(rst,state) begin
    if(rst='0') then
        IM_enable <= '1';
    elsif(state=IM_stg) then
        IM_enable <= '1';
    else
        IM_enable <= '0';
    end if;
end process;

process(rst,state,opcode) begin
    if(rst='0') then
        reg_we <= '0';
    
    elsif(state=pre_stg) then
        if(opcode = "0010111" or opcode = "1101111" or opcode = "1100111") then
            reg_we <= '1';
        else
            reg_we <= '0';
        end if;
        
    elsif(state=DM_stg) then
        if(opcode ="0110011" or opcode = "0010011" or opcode = "0001111" or opcode = "0110111") then
            reg_we <= '1';
        else
            reg_we <= '0';
        end if;
        
    elsif(state=PC_stg) then
        if(opcode = "0000011") then
            reg_we <= '1';
        else
            reg_we <= '0';
        end if;
           
    else
        reg_we <= '0';
    end if;
end process;

process(rst,state,funct3) begin
    if(rst='0') then
        mem_write <= "000";
    elsif(state=DM_stg) then
        if(opcode = "0100011") then
            if(funct3 = ("000")) then
                mem_write <= "001";            
            elsif(funct3 = ("001")) then
                mem_write <= "011";
            elsif(funct3= ("010")) then
                mem_write <= "111";
            else
                mem_write <= "000";
            end if;
        end if;
    else
        mem_write <= "000";
    end if;
end process;

process(rst,state,opcode,funct3) begin
    if(rst='0') then
        mem_read <= "000";
    elsif(state=DM_stg) then
        if(opcode = "0000011") then
            if (funct3 = "000") or (funct3 = "100") then
                mem_read <= "001";
            elsif (funct3 = "001") or (funct3 = "101") then
                mem_read <= "011";
            elsif (funct3 = "010") then
                mem_read <= "111";
            else
                mem_read <= "000";
            end if;
        end if;    
    else
        mem_read <= "000";    
    end if;  
end process;
end behavior;

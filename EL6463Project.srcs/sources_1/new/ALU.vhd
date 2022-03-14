----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name: ALU - structural
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity S_LL is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           shamt : in STD_LOGIC_VECTOR (4 downto 0);
           rd : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end S_LL;

architecture S_LL_Body of S_LL is
signal dout : STD_LOGIC_VECTOR (31 downto 0);
signal zt : STD_LOGIC;
begin

    with shamt select
    dout <=     rs1(30 downto 0) & '0' when "00001",
                rs1(0)           & "0000000000000000000000000000000" when "11111",
                rs1(1 downto 0)  & "000000000000000000000000000000" when "11110",
                rs1(2 downto 0)  & "00000000000000000000000000000" when "11101",
                rs1(3 downto 0)  & "0000000000000000000000000000" when "11100",
                rs1(4 downto 0)  & "000000000000000000000000000" when "11011",
                rs1(5 downto 0)  & "00000000000000000000000000" when "11010",
                rs1(6 downto 0)  & "0000000000000000000000000" when "11001",
                rs1(7 downto 0)  & "000000000000000000000000" when "11000",
                rs1(8 downto 0)  & "00000000000000000000000" when "10111",
                rs1(9 downto 0)  & "0000000000000000000000" when "10110",
                rs1(10 downto 0) & "000000000000000000000" when "10101",
                rs1(11 downto 0) & "00000000000000000000" when "10100",
                rs1(12 downto 0) & "0000000000000000000" when "10011",
                rs1(13 downto 0) & "000000000000000000" when "10010",
                rs1(14 downto 0) & "00000000000000000" when "10001",
                rs1(15 downto 0) & "0000000000000000" when "10000",
                rs1(16 downto 0) & "000000000000000" when "01111",
                rs1(17 downto 0) & "00000000000000" when "01110",
                rs1(18 downto 0) & "0000000000000" when "01101",
                rs1(19 downto 0) & "000000000000" when "01100",
                rs1(20 downto 0) & "00000000000" when "01011",
                rs1(21 downto 0) & "0000000000" when "01010",
                rs1(22 downto 0) & "000000000" when "01001",
                rs1(23 downto 0) & "00000000" when "01000",
                rs1(24 downto 0) & "0000000" when "00111",
                rs1(25 downto 0) & "000000" when "00110",
                rs1(26 downto 0) & "00000" when "00101",
                rs1(27 downto 0) & "0000" when "00100",
                rs1(28 downto 0) & "000" when "00011",
                rs1(29 downto 0) & "00" when "00010",
                rs1 when others;
                
    with dout select
    zt <= '1' when X"00000000",
                      '0' when others;
    rd <= dout;
    zero <= zt;
end S_LL_Body;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity S_RL is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           shamt : in STD_LOGIC_VECTOR (4 downto 0);
           rd : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end S_RL;

architecture S_RL_Body of S_RL is
signal dout : STD_LOGIC_VECTOR (31 downto 0);
signal zt : STD_LOGIC;
begin

    with shamt select
       dout <=  "0000000000000000000000000000000" & rs1(31) when "11111",
                "000000000000000000000000000000" & rs1(31 downto 30) when "11110",
                "00000000000000000000000000000" & rs1(31 downto 29) when "11101",
                "0000000000000000000000000000" & rs1(31 downto 28) when "11100",
                "000000000000000000000000000" & rs1(31 downto 27) when "11011",
                "00000000000000000000000000" & rs1(31 downto 26) when "11010",
                "0000000000000000000000000" & rs1(31 downto 25) when "11001",
                "000000000000000000000000" & rs1(31 downto 24) when "11000",
                "00000000000000000000000" & rs1(31 downto 23) when "10111",
                "0000000000000000000000" & rs1(31 downto 22) when "10110",
                "000000000000000000000" & rs1(31 downto 21) when "10101",
                "00000000000000000000" & rs1(31 downto 20) when "10100",
                "0000000000000000000" & rs1(31 downto 19)when "10011",
                "000000000000000000" & rs1(31 downto 18) when "10010",
                "00000000000000000" & rs1(31 downto 17) when "10001",
                "0000000000000000" & rs1(31 downto 16) when "10000",
                "000000000000000" & rs1(31 downto 15) when "01111",
                "00000000000000" & rs1(31 downto 14) when "01110",
                "0000000000000" & rs1(31 downto 13) when "01101",
                "000000000000" & rs1(31 downto 12) when "01100",
                "00000000000" & rs1(31 downto 11) when "01011",
                "0000000000" & rs1(31 downto 10) when "01010",
                "000000000" & rs1(31 downto 9) when "01001",
                "00000000" & rs1(31 downto 8) when "01000",
                "0000000" & rs1(31 downto 7) when "00111",
                "000000" & rs1(31 downto 6) when "00110",
                "00000" & rs1(31 downto 5) when "00101",
                "0000" & rs1(31 downto 4) when "00100",
                "000" & rs1(31 downto 3) when "00011",
                "00" & rs1(31 downto 2)  when "00010",
                '0' & rs1(31 downto 1) when "00001",
                rs1 when others;
                
    with dout select
    zt <= '1' when X"00000000",
                      '0' when others;
    rd <= dout;
    zero <= zt;
    
end S_RL_Body;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity S_RA is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           shamt : in STD_LOGIC_VECTOR (4 downto 0);
           rd : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end S_RA;

architecture S_RA_Body of S_RA is
signal dout : STD_LOGIC_VECTOR (31 downto 0);
signal zt : STD_LOGIC;
begin

    with shamt select
    dout <=     rs1(30 downto 0) & rs1(31 downto 31) when "11111",
                rs1(29 downto 0) & rs1(31 downto 30) when "11110",
                rs1(28 downto 0) & rs1(31 downto 29) when "11101",
                rs1(27 downto 0) & rs1(31 downto 28) when "11100",
                rs1(26 downto 0) & rs1(31 downto 27) when "11011",
                rs1(25 downto 0) & rs1(31 downto 26) when "11010",
                rs1(24 downto 0) & rs1(31 downto 25) when "11001",
                rs1(23 downto 0) & rs1(31 downto 24) when "11000",
                rs1(22 downto 0) & rs1(31 downto 23) when "10111",
                rs1(21 downto 0) & rs1(31 downto 22) when "10110",
                rs1(20 downto 0) & rs1(31 downto 21) when "10101",
                rs1(19 downto 0) & rs1(31 downto 20) when "10100",
                rs1(18 downto 0) & rs1(31 downto 19) when "10011",
                rs1(17 downto 0) & rs1(31 downto 18) when "10010",
                rs1(16 downto 0) & rs1(31 downto 17) when "10001",
                rs1(15 downto 0) & rs1(31 downto 16) when "10000",
                rs1(14 downto 0) & rs1(31 downto 15) when "01111",
                rs1(13 downto 0) & rs1(31 downto 14) when "01110",
                rs1(12 downto 0) & rs1(31 downto 13) when "01101",
                rs1(11 downto 0) & rs1(31 downto 12) when "01100",
                rs1(10 downto 0) & rs1(31 downto 11) when "01011",
                rs1(9 downto 0)  & rs1(31 downto 10) when "01010",
                rs1(8 downto 0)  & rs1(31 downto 9)  when "01001",
                rs1(7 downto 0)  & rs1(31 downto 8)  when "01000",
                rs1(6 downto 0)  & rs1(31 downto 7)  when "00111",
                rs1(5 downto 0)  & rs1(31 downto 6)  when "00110",
                rs1(4 downto 0)  & rs1(31 downto 5)  when "00101",
                rs1(3 downto 0)  & rs1(31 downto 4)  when "00100",
                rs1(2 downto 0)  & rs1(31 downto 3)  when "00011",
                rs1(1 downto 0)  & rs1(31 downto 2)  when "00010",
                rs1(0)           & rs1(31 downto 1)  when "00001",
                rs1 when others;
                
    with dout select
    zt <= '1' when X"00000000",
                      '0' when others;
    rd <= dout;
    zero <= zt;
    
end S_RA_Body;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity S_LT is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           rs2 : in STD_LOGIC_VECTOR (31 downto 0);
           NF_SLT : out STD_LOGIC;
           zero : out STD_LOGIC);
end S_LT;

architecture Behavioral of S_LT is
signal Diff_Val : signed (31 downto 0);
signal zt : STD_LOGIC := '0';
begin

    Diff_Val <= signed(rs1) - signed(rs2);

    with Diff_Val select
        zt <= '1' when X"00000000",
                          '0' when others;
    zero <= zt;                     
                          
    NF_SLT <= std_logic(Diff_Val(31)); 

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity S_LTU is
    Port (   rs1                : in STD_LOGIC_VECTOR (31 downto 0);
             rs2                : in STD_LOGIC_VECTOR (31 downto 0);
             NF_SLTU : out STD_LOGIC;
             zero       : out STD_LOGIC);
                
end S_LTU;

architecture Behavioral of S_LTU is
  
  signal bibi : unsigned (31 downto 0);
  signal zt : STD_LOGIC := '0';

  begin

      bibi <= unsigned(rs1) - unsigned(rs2);

      with bibi select
          zt <= '1' when X"00000000",
                            '0' when others;

      zero <= zt;                                               
      NF_SLTU <= std_logic(bibi(31)); 

  end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
entity ALU is
    Port (  SrcA : in STD_LOGIC_VECTOR (31 downto 0);
           SrcB : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_Control : in STD_LOGIC_VECTOR (3 downto 0);
           ALU_Result : out STD_LOGIC_VECTOR (31 downto 0);
           Flag_Zero : out STD_LOGIC;
           Flag_Negative : out STD_Logic);
end ALU;
    
architecture ALU_Body of ALU is

component S_LL is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           shamt : in STD_LOGIC_VECTOR (4 downto 0);
           rd : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end component;

component S_RL is
  Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
         shamt : in STD_LOGIC_VECTOR (4 downto 0);
         rd : out STD_LOGIC_VECTOR (31 downto 0);
         zero : out STD_LOGIC);
end component;
 
component S_RA is
  Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
         shamt : in STD_LOGIC_VECTOR (4 downto 0);
         rd : out STD_LOGIC_VECTOR (31 downto 0);
         zero : out STD_LOGIC);
end component;

component S_LT is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           rs2 : in STD_LOGIC_VECTOR (31 downto 0);
           NF_SLT : out STD_LOGIC;
           zero : out STD_LOGIC);
end component;

component S_LTU is
    Port ( rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           rs2 : in STD_LOGIC_VECTOR (31 downto 0);
           NF_SLTU : out STD_LOGIC;
           zero : out STD_LOGIC);
end component;



signal ALU_Output : STD_LOGIC_VECTOR (31 downto 0);
signal Output_Add, Output_Sub, Output_And, Output_Or, Output_Xor, Output_ShiftLL, Output_SRL, Output_SRA : STD_LOGIC_VECTOR (31 downto 0); 
signal zero_Add, zero_Sub, zero_And, zero_Or, zero_Xor, zero_ShiftLL, zero_SRL, zero_SRA, zero_SLT, zero_SLTU : STD_LOGIC;
signal NFlag_SLT, NF_SLTU  : STD_LOGIC;

begin
Output_Add <= std_logic_vector(signed(SrcA) + signed(SrcB));
 with Output_Add select
zero_Add <= '1' when X"00000000",
                      '0' when others;
Output_Sub <= std_logic_vector(signed(SrcA) - signed(SrcB));
with Output_Sub select
zero_Sub <= '1' when X"00000000",
                      '0' when others;
Output_And <= SrcA and SrcB;
with Output_And select
zero_And <= '1' when X"00000000",
                      '0' when others;
Output_Or <= SrcA or SrcB;
with Output_Or select
zero_Or <= '1' when X"00000000",
           '0' when others;
Output_Xor <= SrcA xor SrcB;
with Output_Xor select
zero_Xor <= '1' when X"00000000",
           '0' when others;

component_SLL: S_LL Port Map ( rs1 => SrcA, shamt => SrcB(4 downto 0), rd => Output_ShiftLL, zero => zero_ShiftLL);
component_SRL: S_RL Port Map ( rs1 => SrcA, shamt => SrcB(4 downto 0), rd => Output_SRL, zero => zero_SRL);
component_SRA: S_RA Port Map ( rs1 => SrcA, shamt => SrcB(4 downto 0), rd => Output_SRA, zero => zero_SRA);
component_SLT: S_LT Port Map ( rs1 => SrcA, rs2 => SrcB, NF_SLT => NFlag_SLT, zero => zero_SLT);
component_SLTU: S_LTU Port Map ( rs1 => SrcA, rs2 => SrcB, NF_SLTU => NF_SLTU, zero => zero_SLTU);
Select_Func: with ALU_Control select
             ALU_Output <= Output_Add when "0000",
                           Output_Sub when "0001",
                           Output_ShiftLL when "0010",
                           Output_Xor when "0101",
                           Output_SRL when "0110",
                           Output_SRA when "0111",
                           Output_Or when "1000",
                           Output_And when "1001",
                           X"00000000" when others;

Select_zero: with ALU_Control select
             Flag_Zero <= zero_Add when "0000",
                           zero_Sub when "0001",
                           zero_ShiftLL when "0010",
                           zero_SLT when "0011",
                           zero_SLTU when "0100",
                           zero_Xor when "0101",
                           zero_SRL when "0110",
                           zero_SRA when "0111",
                           zero_Or when "1000",
                           zero_And when "1001",
                           '0' when others;
                    
Select_NF: with ALU_Control select
                      Flag_Negative <= NFlag_SLT when "0011",
                                                   NF_SLTU when "0100",
                      '0' when others;

                          
ALU_Result <= ALU_Output;

end ALU_Body;
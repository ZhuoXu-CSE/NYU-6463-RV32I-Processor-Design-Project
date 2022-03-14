library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity ALU_Results is
    Port ( rs1        : in STD_LOGIC_VECTOR (31 downto 0); 
           rs2        : in STD_LOGIC_VECTOR (31 downto 0);
           BC_Control : in STD_LOGIC_VECTOR (2 downto 0);
           compare    : out STD_LOGIC
         );
end ALU_Results;
architecture ALU_Results_Body of ALU_Results is

component ALU is
    Port ( SrcA : in STD_LOGIC_VECTOR (31 downto 0);
           SrcB : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_Control : in STD_LOGIC_VECTOR (3 downto 0);
           ALU_Result : out STD_LOGIC_VECTOR (31 downto 0);
           Flag_Zero : out STD_LOGIC;
           Flag_Negative : out STD_Logic);
end component;  
signal ALU_Result : STD_LOGIC_VECTOR (31 downto 0);
signal ALU_Control : STD_LOGIC_VECTOR (3 downto 0);
signal Zero : STD_LOGIC;
signal Flag_Negative : STD_Logic;

begin  
ALU_Branching:  ALU Port Map ( SrcA           => rs1,
                               SrcB           => rs2,
                               ALU_Control    => ALU_Control,
                               ALU_Result     => ALU_Result,
                               Flag_Zero      => Zero,
                               Flag_Negative  => Flag_Negative);  

Select_Func: with BC_Control select
             ALU_Control <=  "0101"  when "000", 
                             "0101"  when "001",
                             "0011"  when "010",
                             "0011"  when "011",
                             "0100" when "100",
                             "0100" when "101",
                             "1111" when others;                             

Set_Func: with BC_Control select
             compare <=  Zero         when "000",
                         not Zero     when "001",
                         Flag_Negative     when "010",
                         NOT Flag_Negative when "011",
                         Flag_Negative     when "100",
                         NOT Flag_Negative when "101",
                         '0' when others;
end ALU_Results_Body;
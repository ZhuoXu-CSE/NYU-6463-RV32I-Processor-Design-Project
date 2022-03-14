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
-- Description: Register File
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;


entity reg_file is
    Port (
            CLK                  : in std_logic;
            ReadReg1, ReadReg2   : in std_logic_vector(4 downto 0);
            ReadData1, ReadData2 : out std_logic_vector(31 downto 0);
            WriteReg             : in std_logic_vector(4 downto 0);
            WriteData            : in std_logic_vector(31 downto 0);
            WriteEnable          : in std_logic
    );
end reg_file;

architecture reg_file_body of reg_file is
type Register_Type is array (0 to 31) of std_logic_vector(31 downto 0);
signal Reg32 : Register_Type := (others => (others => '0'));

begin

process(CLK) 
begin        
    if(rising_edge(CLK)) then
        if (WriteEnable = '1' and WriteReg /= "00000") then
            Reg32(to_integer(unsigned(WriteReg))) <= WriteData;
        end if;
    end if;
end process;        

process(CLK) 
begin        
    if(rising_edge(CLK)) then
           ReadData1 <= Reg32(to_integer(unsigned(ReadReg1)));
    end if;
end process; 

process(CLK) 
begin        
    if(rising_edge(CLK)) then
           ReadData2 <= Reg32(to_integer(unsigned(ReadReg2)));
    end if;
end process; 

end reg_file_body;

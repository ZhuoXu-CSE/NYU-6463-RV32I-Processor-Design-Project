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
use IEEE.numeric_std.all;



entity Reg_file_TB is
--  Port ( );
end Reg_file_TB;

architecture achReg_file_TB of Reg_file_TB is
signal tClk, tWriteEnable: STD_LOGIC;
signal tReadReg1, tReadReg2, tWriteReg : std_logic_vector(4 downto 0);
signal tWriteData, tReadData1, tReadData2 : std_logic_vector(31 downto 0);
signal period : time := 10 ns;
begin
uut: entity  work.reg_file PORT MAP( 
                  CLK => tClk,
                  ReadReg1 => tReadReg1,
                  ReadReg2 => tReadReg2,
                  WriteReg => tWriteReg,
                  WriteEnable => tWriteEnable,
                  WriteData => tWriteData,
                  ReadData1 => tReadData1,
                  ReadData2 => tReadData2
                  );
    CLK: process 
    begin
        tclk <= '0';
        wait for period/2;
        tclk <= '1';
        wait for period/2;
    end process;
REGISTER_TEST : process
begin
    tWriteEnable <= '1';
    tReadReg1 <= "00001";
    tReadReg2 <= "00010";
    tWriteReg <= "00011";
    tWriteData <= X"389D7910";

    wait for 1 * period;
    tWriteEnable <= '1';
    tReadReg1 <= "00001";
    tReadReg2 <= "00010";
    tWriteReg <= "00100";
    tWriteData <= X"FEDCBA98";

    wait for 1 * period;
    tWriteEnable <= '0';
    tReadReg1 <= "00100";
    tReadReg2 <= "00011";
    tWriteReg <= "00001";
    tWriteData <= "00000000000000000000000000000000";
    wait for 1 * period;
    assert (tReadData1 = X"FEDCBA98" and tReadData2 = X"389D7910")report "Data doesn't match!d" severity failure;
    tWriteEnable <= '1';
    tReadReg1 <= "00000";
    tReadReg2 <= "00000";
    tWriteReg <= "00000"; 
    tWriteData <= X"FEDCBA98";
    wait for 1 * period;
    assert (tReadData1 = "00000000000000000000000000000000" and tReadData2 = "00000000000000000000000000000000" )
    report "R0 is writable" severity failure;
    report "ALL TESTCASES PASSED";
    std.env.stop;
end process;

end achReg_file_TB;

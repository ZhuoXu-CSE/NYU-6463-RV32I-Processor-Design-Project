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
entity ALU_Results_TB is
--  Port ( );
end ALU_Results_TB;
architecture arcALU_Results_TB of ALU_Results_TB is


component ALU_Results is
    Port ( rs1        : in STD_LOGIC_VECTOR (31 downto 0); 
           rs2        : in STD_LOGIC_VECTOR (31 downto 0);
           BC_Control : in STD_LOGIC_VECTOR (2 downto 0);
           compare    : out STD_LOGIC
         );
end component;

signal rs1,rs2    : STD_LOGIC_VECTOR(31 downto 0);
signal BC_Control : STD_LOGIC_VECTOR (2 downto 0);
signal compare    : STD_LOGIC;
begin

Map_Signals: ALU_Results Port map(rs1        => rs1,
                                rs2        => rs2,
                                BC_Control => BC_Control,
                                compare    => compare
                               );

BC_Test: process
begin

    rs1 <= X"0000000A";
    rs2 <= X"0000000A";
    BC_Control <= "000";
    wait for 10 ns;
    assert (compare = '1')  
    report "test failed for BC_EQ operation" severity failure;
    rs1 <= X"0000000A";
    rs2 <= X"00000004";
    BC_Control <= "000";
    wait for 10 ns;
    assert (compare = '0')  
    report "test failed for BC_EQ operation" severity failure;
    rs1 <= X"0000000A";
    rs2 <= X"00000004";
    BC_Control <= "001";
    wait for 10 ns;
    assert (compare = '1')  
    report "test failed for BC_NE operation" severity failure;
    rs1 <= X"0000000A";
    rs2 <= X"0000000A";
    BC_Control <= "001";
    wait for 10 ns;
    assert (compare = '0')  
    report "test failed for BC_NE operation" severity failure;
    rs1 <= X"FFFFFFFE";
    rs2 <= X"FFFFFFFF";
    BC_Control <= "010";
    wait for 10 ns;
    report "test failed for BC_LT operation" severity failure;
    rs1 <= X"FFFFFFFF";
    rs2 <= X"FFFFFFFE";
    BC_Control <= "010";
    wait for 10 ns;
    assert (compare = '0')  
    report "test failed for BC_LT operation" severity failure;
    rs1 <= X"FFFFFFFE";
    rs2 <= X"FFFFFFFE";
    BC_Control <= "010";
    wait for 10 ns;
    assert (compare = '0')  
    report "test failed for BC_LT operation" severity failure;
    rs1 <= X"FFFFFFFF";
    rs2 <= X"FFFFFFFE";
    BC_Control <= "011";
    wait for 10 ns;
    assert (compare = '1')  
    report "test failed for BC_GE operation" severity failure;
    rs1 <= X"FFFFFFFE";
    rs2 <= X"FFFFFFFE";
    BC_Control <= "011";
    wait for 10 ns;
    assert (compare = '1')  
    report "test failed for BC_GE operation" severity failure;
    rs1 <= X"FFFFFFFE";
    rs2 <= X"FFFFFFFF";
    BC_Control <= "011";
    wait for 10 ns;
    assert (compare = '0')  
    report "test failed for BC_GE operation" severity failure;
    rs1 <= X"00000004";
    rs2 <= X"0000000A";
    BC_Control <= "100";
    wait for 10 ns;
    assert (compare = '1') 
    report "test failed for BC_LTU operation" severity failure;
    rs1 <= X"0000000A";
    rs2 <= X"00000004";
    BC_Control <= "100";
    wait for 10 ns;
    assert (compare = '0')
    report "test failed for BC_LTU operation" severity failure;
    rs1 <= X"0000000A";
    rs2 <= X"0000000A";
    BC_Control <= "100";
    wait for 10 ns;
    assert (compare = '0')  
    report "test failed for BC_LTU operation" severity failure;
    rs1 <= X"0000000A";
    rs2 <= X"00000004";
    BC_Control <= "101";
    wait for 10 ns;
    assert (compare = '1')  
    report "test failed for BC_GEU operation" severity failure;
    rs1 <= X"0000000A";
    rs2 <= X"0000000A";
    BC_Control <= "101";
    wait for 10 ns;
    assert (compare = '1') 
    report "test failed for BC_GEU operation" severity failure;
    rs1 <= X"00000004";
    rs2 <= X"0000000A";
    BC_Control <= "101";
    wait for 10 ns;
    assert (compare = '0')  
    report "test failed for BC_GEU operation" severity failure;
   report "ALL TESTCASES PASSED";
   std.env.stop;

end process;
end arcALU_Results_TB;

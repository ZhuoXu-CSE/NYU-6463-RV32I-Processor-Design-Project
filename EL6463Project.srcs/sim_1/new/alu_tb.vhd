library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_TB is
--  Port ( );
end ALU_TB;

  
architecture ALU_Body_TB of ALU_TB is

component ALU
    Port ( SrcA : in STD_LOGIC_VECTOR (31 downto 0);
           SrcB : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_Control : in STD_LOGIC_VECTOR (3 downto 0);
           ALU_Result : out STD_LOGIC_VECTOR (31 downto 0);
           Flag_Zero : out STD_LOGIC;
           Flag_Negative : out STD_Logic);
end component;
signal A,B,ALU_Rslt : STD_LOGIC_VECTOR(31 downto 0);
signal op : STD_LOGIC_VECTOR (3 downto 0);
signal Flg_Zero, Flg_Neg : STD_LOGIC;

begin

Map_Signals: ALU Port map( SrcA => A,
                                SrcB => B,
                                ALU_Control => op,
                                ALU_Result => ALU_Rslt,
                                Flag_Zero => Flg_Zero,
                                Flag_Negative => Flg_Neg);


ALU_Test: process
begin

    --ADD
    A <= X"0000000A";
    B <= X"00000004";
    op <= "0000";
    wait for 10 ns;
    assert (ALU_Rslt = X"0000000E")  -- expected output
    -- error will be reported if ALU_Rslt is not E.
    report "failed at ADD operation" severity failure;

    --SUB
    A <= X"0000000A";
    B <= X"0000000A";
    op <= "0001";
    wait for 10 ns;    
    assert (ALU_Rslt = X"00000000")  -- expected output
    -- error will be reported if ALU_Rslt is not 0.
    report "failed at SUB operation" severity failure;

    --AND
    A <= X"0000000A";
    B <= X"00000004";
    op <= "1001";
    wait for 10 ns; 
    assert (ALU_Rslt = X"00000000")  -- expected output
    -- error will be reported if ALU_Rslt is not 0.
    report "failed at AND operation" severity failure;

    --OR
    A <= X"0000000A";
    B <= X"00000004";
    op <= "1000";
    wait for 10 ns;
    assert (ALU_Rslt = X"0000000E")  -- expected output
    -- error will be reported if ALU_Rslt is not E.
    report "failed at OR operation" severity failure;

    --XOR
    A <= X"0000000A";
    B <= X"00000004";
    op <= "0101";
    wait for 10 ns; 
    assert (ALU_Rslt = X"0000000E")  -- expected output
    -- error will be reported if ALU_Rslt is not 0000000E.
    report "failed at XOR operation" severity failure;

    --SLL
    A <= X"000000F0";
    B <= X"00000004";
    op <= "0010";
    wait for 10 ns;  
    assert (ALU_Rslt = X"00000F00")  -- expected output
    -- error will be reported if ALU_Rslt is not 00000F00.
    report "failed at SLL operation" severity failure;
    
    --SRL
    A <= X"000000F0";
    B <= X"00000004";
    op <= "0110";
    wait for 10 ns;  
    assert (ALU_Rslt = X"0000000F")  -- expected output
    -- error will be reported if ALU_Rslt is not 0000000F.
    report "failed at SRL operation" severity failure;

    --SRA
    A <= X"000000FA";
    B <= X"00000004";
    op <= "0111";
    wait for 10 ns;  
    assert (ALU_Rslt = X"A000000F")  -- expected output
    -- error will be reported if ALU_Rslt is not A000000F.
    report "failed at SRA operation" severity failure;

    --STLU
    A <= X"0000000E";
    B <= X"0000000F";
    op <= "0100";
    wait for 10 ns;
    assert (Flg_Neg = '1')  -- expected output
    -- error will be reported if Flg_Neg is not 1.
    report "failed at STLU operation" severity failure;

    --STL
    A <= X"FFFFFFFE";
    B <= X"FFFFFFFF";
    op <= "0011";
    wait for 10 ns;
    assert (Flg_Neg = '1')  -- expected output
    -- error will be reported if Flg_Neg is not 1.
    report "failed at STL operation" severity failure;

   report "ALL TESTCASES PASSED";
   std.env.stop;

end process;
end ALU_Body_TB;
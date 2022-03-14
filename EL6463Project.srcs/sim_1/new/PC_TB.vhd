library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity PC_TB is
--  Port ( );
end PC_TB;

architecture pc_tb of PC_TB is
signal t_clk : std_logic := '0';
signal t_rst : std_logic := '1';
signal t_advcounter: STD_LOGIC := '0'; 
signal t_next_addr: STD_LOGIC := '1'; 
signal t_addr_in: STD_LOGIC_VECTOR(31 downto 0) := X"01000000";
signal t_addr_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal t_addr_next: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
dut: entity work.Program_Counter
  Port Map(
    clk => t_clk,
    rst => t_rst, 
    advcounter => t_advcounter, 
    next_addr => t_next_addr, 
    addr_in => t_addr_in,
    addr_out => t_addr_out,
    addr_next => t_addr_next
   );
   
CLK_GEN:process begin 
    t_clk <= '0';
    wait for 5ns;
    t_clk <= '1';
    wait for 5ns;
end process;

Test: process begin
    wait for 40 ns;
    t_advcounter <= '1';
    wait for 60 ns;
    t_addr_in <= X"01000040";
    wait for 20 ns;
    t_next_addr <= '0';
    wait for 10ns;
    t_addr_in <= X"01000020";
    wait for 20ns;
    t_addr_in <= X"01000100";
    wait for 20ns;
    t_next_addr <= '1';
    wait for 40ns;
    t_rst <= '0';
    wait for 2ns;
    t_rst <= '1';
    wait for 30ns;
    t_advcounter <= '0';
    wait for 20ns;
    report("Test passed successfully!");
    std.env.stop;
    
end process;

end pc_tb;

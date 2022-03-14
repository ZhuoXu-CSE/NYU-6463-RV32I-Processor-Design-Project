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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_Counter is
  Port (
    clk : IN STD_LOGIC := '0';
    rst : IN STD_LOGIC := '1'; 
    advcounter: IN STD_LOGIC := '0'; 
    next_addr: IN STD_LOGIC := '1'; 
    addr_in: IN STD_LOGIC_VECTOR(31 downto 0) := X"01000000";
    addr_out: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    addr_next: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
   );
end Program_Counter;

architecture pc_ach of Program_Counter is

signal addr: std_logic_vector(31 downto 0) := X"01000000";

begin

process(rst, clk) begin 
    if(rst='0') then 
        addr <= X"01000000";
    elsif(rising_edge(clk)) then
        if(advcounter = '1') then
            if(next_addr = '1')then
                addr <= std_logic_vector((unsigned(addr))+ 4);
            else
                addr <= addr_in;
            end if;
        end if;
    end if;
end process;

addr_out <= addr;
addr_next <= std_logic_vector((unsigned(addr))+ 4);

end pc_ach;

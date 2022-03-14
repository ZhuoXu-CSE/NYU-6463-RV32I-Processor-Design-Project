----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/10 00:05:45
-- Design Name: 
-- Module Name: Nnumber_mem - Behavioral
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
use std.textio.all;
use ieee.std_logic_textio.all;

entity Nnum_Memory is
  Port ( 
    clk : IN STD_LOGIC := '0'; 
    rst : IN STD_LOGIC := '1'; 
    read_enable: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    addr_in: IN STD_LOGIC_VECTOR((32-1) downto 0) := X"00100000";
    data_out: OUT STD_LOGIC_VECTOR((32-1) downto 0) := (others => '0')
  );
end Nnum_Memory;

architecture nnum_ach of Nnum_Memory is
type nnum is array(0 to 3-1) of std_logic_vector(32-1 downto 0);
impure function nnum_readfile(FileName : STRING) return nnum is
    file FileHandle : TEXT open READ_MODE is FileName;
    variable L : LINE;
    variable W : std_logic_vector(32-1 downto 0);
    variable O : nnum := (others => (others => 'X'));
    
    begin
    
    for i in 0 to 3 - 1 loop
        exit when endfile(FileHandle);
        readline(FileHandle, L);
        hread(L, W);
        for j in 0 to 4-1 loop
            O(i)( ((j+1)*8)-1 downto (j*8)) := W( ((4-j)*8)-1 downto (4-(j+1))*8 );
        end loop;
    end loop;
    
    return O;
    
end function;
signal n_mem: nnum := nnum_readfile("/home/zx1412/EL6463Project/EL6463Project.srcs/sources_1/new/Nnum.mem");
signal row: std_logic_vector(32-1 downto 0) := x"00000000";
signal addr_nmem: std_logic_vector(32-1 downto 0);

begin

addr_nmem <= addr_in and (not X"00100000");
row(32-3 downto 0) <= addr_nmem(32-1 downto 2);

process(rst,clk) begin
    if(rst = '0') then
        data_out <= (others => '0');
    elsif rising_edge(clk) then
        if(addr_nmem < 12) then
            if(read_enable = "111") then
                data_out(31 downto 24) <= n_mem(to_integer(unsigned(row)))( 7 downto  0);
                data_out(23 downto 16) <= n_mem(to_integer(unsigned(row)))(15 downto  8);
                data_out(15 downto  8) <= n_mem(to_integer(unsigned(row)))(23 downto 16);
                data_out( 7 downto  0) <= n_mem(to_integer(unsigned(row)))(31 downto 24);
            
            else
                data_out <= (others => '0');
            
            end if;
            
        else
            data_out <= (others => '0');
            
        end if;
    end if;
end process;

end nnum_ach;
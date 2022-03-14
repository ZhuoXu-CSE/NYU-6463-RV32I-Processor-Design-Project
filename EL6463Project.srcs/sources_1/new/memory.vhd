----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2021 03:57:37 AM
-- Design Name: 
-- Module Name: dmem - Behavioral
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

entity Memory is
  Port ( 
    clk : IN STD_LOGIC := '0';
    rst : IN STD_LOGIC := '1'; 
    
    MEM_WE: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    MEM_RE: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    addr_in: IN STD_LOGIC_VECTOR(31 downto 0) := X"80000000";
    data_in: IN STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    opc_in: in std_logic_vector(9 downto 0);
    data_out: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    instr_in: IN STD_LOGIC_VECTOR(31 downto 0) := (others => '0') 
  );
end Memory;

architecture mem_ach of Memory is

signal dm_data_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal num_data_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal sw_data_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal led_data_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal instr_data_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

component Data_Memory is
  Port ( 
    clk : IN STD_LOGIC := '0';
    rst : IN STD_LOGIC := '1'; 
    w_mode: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    r_mode: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    addr_in: IN STD_LOGIC_VECTOR(31 downto 0) :=  X"80000000";
    din: IN STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    opc_in: in std_logic_vector(9 downto 0);      
    dout: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
  );
end component;

component Nnum_Memory is
  Port ( 
    clk : IN STD_LOGIC := '0';
    rst : IN STD_LOGIC := '1'; 
    read_enable: IN STD_LOGIC_VECTOR(2 downto 0) := "000"; 
    addr_in: IN STD_LOGIC_VECTOR(31 downto 0) := X"00100000";
    data_out: OUT STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
  );
end component;


signal t_addr_in:  STD_LOGIC_VECTOR(31 downto 0) := X"80000000";

begin

t_addr_in <= addr_in;

instr_data_out <= instr_in;


dmem_unit: Data_Memory 
  Port Map( 
    clk => clk,
    rst => rst,
    w_mode => MEM_WE,
    r_mode => MEM_RE,
    addr_in => t_addr_in,
    din => data_in,
    opc_in => opc_in,
    dout => dm_data_out
  );
  
nmem_unit: Nnum_Memory
  Port Map( 
    clk => clk,
    rst => rst,
    read_enable => MEM_RE,
    addr_in => t_addr_in,
    data_out => num_data_out
  );

data_out <= (dm_data_out or num_data_out or sw_data_out or led_data_out or instr_data_out);

        
end mem_ach;
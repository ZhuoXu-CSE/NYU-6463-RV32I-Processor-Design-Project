
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Imm_ext is
    Port (
        imm_in: in std_logic_vector(31 downto 0);  
        imm_out: out std_logic_vector(31 downto 0);
        opc_in: in std_logic_vector(9 downto 0)
    );
end Imm_ext;

architecture behavior of Imm_ext is
    
    signal immlve: std_logic_vector(11 downto 0); 
    signal immty: std_logic_vector(19 downto 0);
    signal temp: std_logic_vector(31 downto 0);
    signal opc: std_logic_vector(9 downto 0);     
    signal wpm: std_logic;
    
begin
    
    opc <= opc_in;
    
    with opc select wpm <= 
        '0' when "0000110111" | 
                 "0000010111" | 
                 "0010010011" | 
                 "1010010011",
        '1' when others; 

    immlve(11 downto 0) <= imm_in(11 downto 0);
    immty(19 downto 0) <= imm_in(19 downto 0);
        
    process(imm_in, opc_in, wpm, temp, immlve, immty) begin
        
        case opc_in(6 downto 0) is
            when "1100111" =>
                if(wpm = '1') then
                    temp <= std_logic_vector(resize(signed(immlve), temp'length));
                else
                    temp <= (others => '0');
                end if;        
            when "0000011" =>
                if(wpm = '1') then
                    temp <= std_logic_vector(resize(signed(immlve), temp'length));
                else
                    temp <= (others => '0');
                end if;      
            when "0010011" => 
                if (wpm = '1') then
                    temp <= std_logic_vector(resize(signed(immlve), temp'length));
                else
                    temp <= std_logic_vector(resize(unsigned(immlve(4 downto 0)), temp'length));
                end if; 
            when "0110111" => 
                temp <= imm_in;
            when "0100011" => 
                if (wpm = '1') then
                    temp <= std_logic_vector(resize(signed(immlve), temp'length)); 
                else
                    temp <= (others => '0');
                end if;
            when "0010111" => 
                temp <= imm_in;
            when "1100011" => 
                if (wpm = '1') then
                    temp <= std_logic_vector(resize(signed(immlve), temp'length));
                else
                    temp <= (others => '0');
                end if;   
            when "1101111" => 
                if (wpm = '1') then
                    temp <= std_logic_vector(resize(signed(immty), temp'length));
                else
                    temp <= (others => '0');
                end if;
            when "0110011" => 
                temp <= (others => '0');  
            when others => temp <= (others => '0');
            
        end case;
        
    end process;

    imm_out <= temp;
    

end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX_INPUT is
    port (
        prueba: in std_logic_vector(2 downto 0);
        Entradas: in std_logic_vector(3 downto 0);
        Q_SEL : out std_logic
    );
end entity MUX_INPUT;
architecture behavioral of MUX_INPUT is
    signal Q_SEL_buffer : std_logic; 
begin
    process(prueba)
    begin
        case prueba is
            when "000" =>
                Q_SEL_buffer<=Entradas(0); -- 
            when "001" =>
                Q_SEL_buffer<=Entradas(1); --
            when "010" =>
                Q_SEL_buffer<=Entradas(2); --
            when "011" =>
                Q_SEL_buffer<=Entradas(3); --
            when "100" => 
                Q_SEL_buffer<='1';
            when others =>
                Q_SEL_buffer<='0';
        end case;
        
    end process ;
    
    Q_SEL <= Q_SEL_buffer;
    
end architecture behavioral;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity REGISTRO is
    port(
        ENTRADA: in std_logic_vector(3 downto 0);
        ENABLE: in std_logic;
        SALIDA: out std_logic_vector(3 downto 0)
    );
end entity REGISTRO;

architecture behavioral of REGISTRO is
    
begin
    
    SALIDA<= ENTRADA when (ENABLE = '0') else "ZZZZ";
    
end architecture behavioral;

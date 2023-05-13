library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity P6 is
    generic(
        ADDR_SIZE: integer := 8;
        INPUT_SIZE: integer := 4;
        OUTPUT_SIZE: integer := 8
    );
    port (
        CLOCK: in std_logic;
        INT_REG: in std_logic_vector(ADDR_SIZE-1 downto 0);
        TRANS_REG: in std_logic_vector(ADDR_SIZE-1 downto 0);
        ENTRADAS: in std_logic_vector(INPUT_SIZE-1 downto 0);
        SALIDAS: out std_logic_vector(OUTPUT_SIZE-1 downto 0)

    );
end entity P6;
architecture behavioral of P6 is
    
begin
    
    
    
end architecture behavioral;
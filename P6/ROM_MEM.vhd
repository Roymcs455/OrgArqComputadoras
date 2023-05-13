library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM_MEM is
    generic(
        STATE_SIZE: integer := 8;
        PRUEBA_SIZE: integer := 2;
        MI_SIZE: integer := 2;
        OUTPUT_SIZE: integer := 4;
    );
    port (
        --entradas
        Estado_presente : in std_logic_vector(STATE_SIZE-1 downto 0);
        PL: in std_logic;
        --salidas
        Prueba: out std_logic_vector(PRUEBA_SIZE-1 downto 0);
        VF : out std_logic;
        liga: out std_logic_vector(STATE_SIZE-1 downto 0);
        salidas : out std_logic_vector(OUTPUT_SIZE-1 downto 0);
    );
end entity ROM_MEM;

architecture behavioral of ROM_MEM is
    signal buffer_ROM : std_logic_vector(
        PRUEBA_SIZE+MI_SIZE+STATE_SIZE+OUTPUT_SIZE --Aquí determinamos el tamaño del buffer de la ROM.
         downto 0);
begin
    
    process(Estado_presente)
    begin
        case Estado_presente is
            when "0000_0000" =>
                buffer_ROM <= "011_1000_0101_0011";
            when others =>
                buffer_ROM <= "000000000000000";
                
        
        end case;
    end process ;
    salidas_V <= buffer_ROM(7 downto 4);
    VF <= buffer_ROM(8);
    liga <= buffer_ROM(11 downto 9);
    prueba <= buffer_ROM(14 downto 12);
    
end architecture behavioral;
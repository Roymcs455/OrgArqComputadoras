library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM_MEM is
    port (
        Estado_presente : std_logic_vector(2 downto 0);
        Prueba: out std_logic_vector(2 downto 0);
        VF : out std_logic;
        liga: out std_logic_vector(2 downto 0);
        salidas_V : out std_logic_vector(3 downto 0);
        salidas_F : out std_logic_vector(3 downto 0)
    );
end entity ROM_MEM;

architecture behavioral of ROM_MEM is
    signal buffer_ROM : std_logic_vector(14 downto 0);
begin
    
    process(Estado_presente)
    begin
        case Estado_presente is
            when "000" =>
                buffer_ROM <= "011100001010011";
            when "001" =>
                buffer_ROM <= "100000001010101";
            when "010" =>
                buffer_ROM <= "010101111111111";
            when "011" =>
                buffer_ROM <= "100110110111011";
            when "100" =>
                buffer_ROM <= "000111010001011";
            when "101" =>
                buffer_ROM <= "001011011111010";
            when "110" =>
                buffer_ROM <= "100010101010101";
            when "111" =>               
                buffer_ROM <= "100100100000000";
            when others =>
                buffer_ROM <= "000000000000000";
                
        
        end case;
    end process ;
    salidas_F <= buffer_ROM(3 downto 0);
    salidas_V <= buffer_ROM(7 downto 4);
    VF <= buffer_ROM(8);
    liga <= buffer_ROM(11 downto 9);
    prueba <= buffer_ROM(14 downto 12);
    
end architecture behavioral;
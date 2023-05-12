library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX_OUTPUT is
    port (
        Q_SEL: in std_logic;
        Salidas_V: in std_logic_vector(3 downto 0);
        Salidas_F: in std_logic_vector(3 downto 0);
        Salida_efectiva: out std_logic_vector(3 downto 0)
    );
end entity MUX_OUTPUT;

architecture behavioral of MUX_OUTPUT is
    signal S_Eff_buffer : std_logic_vector(3 downto 0);
begin
    
    process(Q_SEL)
    begin
        if Q_SEL = '1' then
            S_Eff_buffer <= Salidas_V;
        else
            S_Eff_buffer <= Salidas_F;
        end if;    
    end process ;
    Salida_efectiva<=S_Eff_buffer;
end architecture behavioral;
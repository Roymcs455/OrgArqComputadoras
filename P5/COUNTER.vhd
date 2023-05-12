library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity COUNTER is
    port (
        clk : in std_logic;
        set : in std_logic;
        inc : in std_logic;
        input_state : in std_logic_vector(2 downto 0);
        output_state : out std_logic_vector(2 downto 0)
    );
end COUNTER;

architecture Behavioral of COUNTER is
    signal temp : std_logic_vector(2 downto 0);
begin
    proceso_contador : process(clk, set, inc)
    begin
        if rising_edge(clk) then
            if set='1' then
                temp <= input_state;
            elsif inc='1' then
                temp <= std_logic_vector( unsigned(temp) + 1);
            end if;
        end if;
    end process proceso_contador;

    output_state <= temp;
end Behavioral;
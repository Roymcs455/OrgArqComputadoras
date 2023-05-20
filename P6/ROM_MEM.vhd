library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM_MEM is
    generic(
        STATE_SIZE: integer := 4;
        PRUEBA_SIZE: integer := 2;
        MI_SIZE: integer := 2;
        OUTPUT_SIZE: integer := 6
    );
    port (
        --entradas
        Estado_presente : in std_logic_vector(STATE_SIZE-1 downto 0);
        PL: in std_logic;
        --salidas
        MI: out std_logic_vector(MI_SIZE-1 downto 0);
        Prueba: out std_logic_vector(PRUEBA_SIZE-1 downto 0);
        VF : out std_logic;
        liga: out std_logic_vector(STATE_SIZE-1 downto 0);
        salidas_V : out std_logic_vector(OUTPUT_SIZE-1 downto 0);
        salidas_F : out std_logic_vector(OUTPUT_SIZE-1 downto 0)
    );
end entity ROM_MEM;

architecture behavioral of ROM_MEM is
    signal LIGA_BUFFER : std_logic_vector(STATE_SIZE-1 downto 0);
    signal MI_BUFFER : std_logic_vector(MI_SIZE-1 downto 0);
    signal PRUEBA_BUFFER: std_logic_vector(PRUEBA_SIZE-1 downto 0);
    signal VF_BUFFER: std_logic;
    signal S_V_BUFFER : std_logic_vector(OUTPUT_SIZE-1 downto 0);
    signal S_F_BUFFER : std_logic_vector(OUTPUT_SIZE-1 downto 0);

begin
    
    process(Estado_presente)
    begin
        case Estado_presente is
            when "0000" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "00";
                PRUEBA_BUFFER <= "00" ;
                VF_BUFFER <= '0';
                S_V_BUFFER <= "000001";
                S_F_BUFFER <= "000001";
            when "0001" =>
                LIGA_BUFFER <= "0101";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "00"  ;
                VF_BUFFER <= '0';
                S_V_BUFFER <= "001111";
                S_F_BUFFER <= "001111";
            when "0010" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "00";
                PRUEBA_BUFFER <= "00";
                VF_BUFFER <= '0';
                S_V_BUFFER <= "000011";
                S_F_BUFFER <= "000011";
            when "0011" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "00";
                PRUEBA_BUFFER <= "00" ;
                VF_BUFFER <= '0';
                S_V_BUFFER <= "001010";
                S_F_BUFFER <= "001010";
            when "0100" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "10";
                PRUEBA_BUFFER <= "00" ;
                VF_BUFFER <= '0';
                S_V_BUFFER <= "010000";
                S_F_BUFFER <= "010000";
            when "0101" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "11";
                PRUEBA_BUFFER <= "10" ;
                VF_BUFFER <= '0';
                S_V_BUFFER <= "010000";
                S_F_BUFFER <= "010001";
            when "0110" =>
                LIGA_BUFFER <= "0001";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "11" ;
                VF_BUFFER <= '1';
                S_V_BUFFER <= "100000";
                S_F_BUFFER <= "100000";
            when "0111" =>
                LIGA_BUFFER <= "1010";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "01";
                VF_BUFFER <= '0';
                S_V_BUFFER <= "010010";
                S_F_BUFFER <= "110010";
            when "1000" =>
                LIGA_BUFFER <= "0010";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "11";
                VF_BUFFER <= '1';
                S_V_BUFFER <= "001001";
                S_F_BUFFER <= "001001";
            when "1001" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "11";
                PRUEBA_BUFFER <= "10";
                VF_BUFFER <= '0';
                S_V_BUFFER <= "001010";
                S_F_BUFFER <= "101011";
            when "1010" =>
                LIGA_BUFFER <= "0010";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "11";
                VF_BUFFER <= '1';
                S_V_BUFFER <= "000000";
                S_F_BUFFER <= "000000";
            when "1011" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "10";
                PRUEBA_BUFFER <= "00";
                VF_BUFFER <= '0';
                S_V_BUFFER <= "000100";
                S_F_BUFFER <= "000100";
            when "1100" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "11";
                VF_BUFFER <= '1';
                S_V_BUFFER <= "000100";
                S_F_BUFFER <= "000100";
            when "1101" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "11";
                VF_BUFFER <= '1';
                S_V_BUFFER <= "000100";
                S_F_BUFFER <= "000100";
            when "1110" =>
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "11";
                VF_BUFFER <= '1';
                S_V_BUFFER <= "000100";
                S_F_BUFFER <= "000100";
            when "1111" =>                
                LIGA_BUFFER <= "0000";
                MI_BUFFER <= "01";
                PRUEBA_BUFFER <= "11";
                VF_BUFFER <= '1';
                S_V_BUFFER <= "000000";
                S_F_BUFFER <= "000000";
            when others =>
                PRUEBA_BUFFER <=  "ZZ";
                VF_BUFFER <= 'Z';
                LIGA_BUFFER <= "ZZZZ";
                S_V_BUFFER <= "ZZZZZZ";
                S_F_BUFFER <= "ZZZZZZ";
                
                
        
        end case;
    end process ;
    prueba <= PRUEBA_BUFFER;
    VF <= VF_BUFFER;
    liga <= LIGA_BUFFER when (PL = '0') else "ZZZZ";
    salidas_V <= S_V_BUFFER;
    salidas_F <= S_F_BUFFER;
    MI <= MI_BUFFER;
    
end architecture behavioral;
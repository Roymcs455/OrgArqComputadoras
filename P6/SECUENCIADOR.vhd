library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SECUENCIADOR is
    generic(
        D_WIDTH: integer := 8;
        I_WIDTH: integer := 2        
    );
    port (
        --inputs
        CLOCK: in std_logic;
        D: in std_logic_vector(D_WIDTH-1 downto 0);
        I: in std_logic_vector(I_WIDTH-1 downto 0);
        CC: in std_logic;
        --outputs
        Y: out std_logic_vector(D_WIDTH-1 downto 0);
        PL: out std_logic;
        MAPP: out std_logic;
        VECT: out std_logic
    );
end entity SECUENCIADOR;

architecture behavioral of SECUENCIADOR is
    signal selector: std_logic := '0';
    signal reg_pc: std_logic_vector(D_WIDTH-1 downto 0);
    signal Estado_presente: std_logic_vector(D_WIDTH-1 downto 0);
    signal reg_incr: std_logic_vector(D_WIDTH-1 downto 0);
begin
    LOGICA: process(CC, I)
    begin
        case I is
            when "00" =>
                selector <= '0';
                PL <= '1';
                MAPP <= '1';
                VECT <= '1';
            when "01" =>
                if CC = '1' then
                    selector <= '0';
                    PL <= '1';
                    MAPP <= '1';
                    VECT <= '1';
                else
                    selector <= '1';
                    PL <= '0';
                    MAPP <= '1';
                    VECT <= '1';
                end if;
            when "10" =>
                selector <= '1';
                PL  <= '1';
                MAPP <= '0';
                VECT <= '1';
            when "11" =>
                if CC = '1' then
                    selector <= '0';
                    PL <= '1';
                    MAPP <= '1';
                    VECT <= '1';
                else
                    selector <= '1';
                    PL <= '1';
                    MAPP <= '1';
                    VECT <= '0';
                end if;
            when others =>
            selector <= '1';
            PL <= '1';
            MAPP <= '1';
            VECT <= '1';
        end case;
    end process LOGICA;
    MUX_REG_D: process(selector)
    begin
        if selector = '1' then
            Estado_presente <= D;
        else
            Estado_presente <= reg_pc;
        end if;
    end process MUX_REG_D;
    REG_PC_CONTROLLER: process(CLOCK)
    begin
        if rising_edge(CLOCK) then
            reg_pc <= reg_incr;
        end if;
    end process REG_PC_CONTROLLER;

    REG_INCR_CONTROLLER: process(Estado_presente)
    begin
        reg_incr    <= std_logic_vector( unsigned(Estado_presente) + 1);
    end process REG_INCR_CONTROLLER;
    

    
    
end architecture behavioral;
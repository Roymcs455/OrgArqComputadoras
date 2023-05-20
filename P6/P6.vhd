library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity P6 is
    generic(
        ADDR_SIZE: integer := 4;
        INPUT_SIZE: integer := 4;
        OUTPUT_SIZE: integer := 6
    );
    port (
        CLOCK: in std_logic;
        INT_REG: in std_logic_vector(ADDR_SIZE-1 downto 0);
        TRANS_REG: in std_logic_vector(ADDR_SIZE-1 downto 0);
        ENTRADAS: in std_logic_vector(INPUT_SIZE-1 downto 0);
        SALIDAS: out std_logic_vector(OUTPUT_SIZE-1 downto 0);
        EST_PRES: out std_logic_vector(ADDR_SIZE-1 downto 0);
        MI_OUT : inout std_logic_vector(1 downto 0)

    );
end entity P6;

architecture behavioral of P6 is
    signal D : std_logic_vector(ADDR_SIZE-1 downto 0);
    signal Y: std_logic_vector(ADDR_SIZE-1 downto 0); 
    signal LIGA : std_logic_vector(ADDR_SIZE-1 downto 0);
    signal CC : std_logic;
    signal PL : std_logic;
    signal VECT : std_logic;
    signal MAPP : std_logic;
    signal MI :std_logic_vector(1 downto 0);
    signal PRUEBA : std_logic_vector(1 downto 0);
    signal VF : std_logic;
    signal SALIDAS_V : std_logic_vector(OUTPUT_SIZE-1 downto 0);
    signal SALIDAS_F : std_logic_vector(OUTPUT_SIZE-1 downto 0);
    signal MUX_SIGNAL: std_logic;

    
    --COMPONENTES
    component ROM_MEM is
        generic(
            STATE_SIZE: integer := 4;
            PRUEBA_SIZE: integer := 2;
            MI_SIZE: integer := 2;
            OUTPUT_SIZE: integer := 6
        );
        port(
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
    end component ROM_MEM;

    component SECUENCIADOR is
        generic(
            D_WIDTH: integer := 4;
            I_WIDTH: integer := 2 
        );
        port(
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
    end component SECUENCIADOR;

    component REGISTRO is
        port (
            ENTRADA: in std_logic_vector(3 downto 0);
            ENABLE : in std_logic;
            SALIDA : out std_logic_vector(3 downto 0)
        );
    end component REGISTRO;

begin
    ROM_MEM_INST : ROM_MEM 
    generic map(
        STATE_SIZE=> 4,
        PRUEBA_SIZE =>2,
        MI_SIZE =>2,
        OUTPUT_SIZE=> 6
        )
    port map(
        D,
        PL,
        MI,
        PRUEBA,
        VF,
        Y,
        SALIDAS_V,
        SALIDAS_F
    );

    SEC_INST : SECUENCIADOR
    generic map(
        D_WIDTH=> 4,
        I_WIDTH=> 2
    )
    port map(
        CLOCK,
        D,
        MI,
        CC,
        LIGA,
        PL,
        MAPP,
        VECT
    );
    MUX_ENTRADAS: process(prueba)
    begin
        case prueba is
            when "00" =>
                MUX_SIGNAL <=ENTRADAS(0);--X
            when "01" =>
                MUX_SIGNAL <=ENTRADAS(1);--Y
            when "10" =>
                MUX_SIGNAL <=ENTRADAS(2);--INT
            when "11" =>
                MUX_SIGNAL <='0';-- AUXILIAR
            when others =>
                MUX_SIGNAL <='0';        
        end case;
    end process MUX_ENTRADAS;

    REGISTRO_INTERRUPCION : REGISTRO 
    port map(
        INT_REG,
        VECT,
        D
    );

    REGISTRO_TRANSFORMACION : REGISTRO 
    port map(
        TRANS_REG,
        MAPP,
        D
    );
    REGISTRO_LIGA : REGISTRO
    PORT MAP(
        LIGA,
        PL,
        D
    );

    CC <= MUX_SIGNAL XOR VF;
    SALIDAS <= SALIDAS_V WHEN (CC = '1') else SALIDAS_F;
    EST_PRES <= Y;
    MI_OUT <= mi;
end architecture behavioral;
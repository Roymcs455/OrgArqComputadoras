library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity P5 is
    port (
       CLK : in std_logic; 
       Entradas : in std_logic_vector(3 downto 0); 
       Salida_efectiva: out std_logic_vector(3 downto 0);
       Estado: out std_logic_vector(2 downto 0)
    );
end entity P5;



architecture behavioral of P5 is
    --signals
    signal set_counter : std_logic;
    signal inc_counter : std_logic;
    signal Estado_presente: std_logic_vector(2 downto 0);
    signal prueba : std_logic_vector(2 downto 0);
    signal liga : std_logic_vector(2 downto 0);
    signal VF : std_logic;
    signal salida_V : std_logic_vector(3 downto 0);
    signal salida_F : std_logic_vector(3 downto 0);

    signal Q_SEL : std_logic;
    --Components:
    component COUNTER
        port (
            clk : in std_logic;
            set : in std_logic;
            inc : in std_logic;
            input_state : in std_logic_vector(2 downto 0);
            output_state : out std_logic_vector(2 downto 0)
        );
    end component COUNTER;
    component ROM_MEM 
        port (
            Estado_presente : std_logic_vector(2 downto 0);
            Prueba: out std_logic_vector(2 downto 0);
            VF : out std_logic;
            liga: out std_logic_vector(2 downto 0);
            salidas_V : out std_logic_vector(3 downto 0);
            salidas_F : out std_logic_vector(3 downto 0)
        );
    end component ROM_MEM;

    component MUX_OUTPUT
        port (
            Q_SEL: in std_logic;
            Salidas_V: in std_logic_vector(3 downto 0);
            Salidas_F: in std_logic_vector(3 downto 0);
            Salida_efectiva: out std_logic_vector(3 downto 0)
        );
    end component MUX_OUTPUT;

    component MUX_INPUT
        port (
            prueba: in std_logic_vector(2 downto 0);
            Entradas: in std_logic_vector(3 downto 0);
            Q_SEL : out std_logic
        );
    end component MUX_INPUT;

begin
    COUNTER_INSTANCE : COUNTER
    port map(
        clk => CLK,
        set => set_counter,
        inc => inc_counter,
        input_state => liga,
        output_state => Estado_presente
    );
    ROM_MEM_INSTANCE : ROM_MEM
    port map (
        Estado_presente => Estado_presente,
        prueba => prueba,
        VF => VF,
        liga => liga,
        salidas_V => salida_V,
        salidas_F => salida_F
    );
    MUX_OUTPUT_INSTANCE : MUX_OUTPUT 
        port map(
            Q_SEL => Q_SEL,
            Salidas_V => Salida_V,
            Salidas_F => salida_F,
            Salida_efectiva => Salida_efectiva
        ); 
    MUX_INPUT_INSTANCE : MUX_INPUT
        port map(
            Prueba => prueba,
            Entradas => Entradas,
            Q_SEL => Q_SEL
        );
    process(Q_SEL,VF,set_counter,inc_counter)
    begin

        
    end process ;
    inc_counter <= Q_SEL XOR VF;
    set_counter <= Q_SEL XNOR VF;
    Estado <= Estado_presente;
end architecture behavioral;
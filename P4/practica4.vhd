library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Practica4 is
	port(
		Reset: in std_logic;
		Clock: in std_logic;
		Entradas: in std_logic_vector ( 3 downto 0);
		Salidas: out std_logic_vector (4 downto 0)	
	);
end Practica4;

Architecture behavioral of Practica4 is
	signal divisor_reloj: std_logic:='0';
	signal contador: integer:=1;
	signal liga_main_V : std_logic_vector(2  downto 0 ) :="000";
	signal liga_main_F : std_logic_vector(2  downto 0 ) :="000";
	signal prueba	: std_logic_vector (1 downto 0) := "00";
	signal registro_estado_presente : std_logic_vector(2 downto 0) := "000";
	signal SalidasV : std_logic_vector (4 downto 0) := "00000";
	signal SalidasF : std_logic_vector (4 downto 0) := "00000";
	signal selector_salida : std_logic := '0';
	
	
	component ROM
	port (
		clk_input: 	in std_logic;
		direccion: 	in std_logic_vector	(2 downto 0); 	--Dirección de 3 bits
		-- Output ports
		prueba	: out std_logic_vector	(1 downto 0) := "00";
		ligaV		: out std_logic_vector	(2 downto 0) := "000";
		ligaF		: out std_logic_vector	(2 downto 0) := "000";
		salidasV	: out std_logic_vector	(4 downto 0) := "00000";
		salidasF	: out std_logic_vector	(4 downto 0) := "00000"
	);
	end component ROM;
begin
	ROM_1 : ROM
		port map (
			clk_input => Clock,
			--clk_input <= divisor_reloj,
			direccion => registro_estado_presente,
			prueba => Prueba,
			ligaV => liga_main_V,
			ligaF => liga_main_F,
			salidasV => SalidasV,
			salidasF => SalidasF
		);
		
	
	process(Clock)-- Divisor de reloj
	begin
		if rising_edge(Clock) then
			contador <= contador+1;
			if(contador = 50_000_000) then
				divisor_reloj <= NOT divisor_reloj;
				contador <= 1;
			end if;
		end if;
	end process;


	
	process(Clock, Reset) --Para simulacion
	begin
		if (Reset = '0') then
			registro_estado_presente <= "000";
		elsif rising_edge(Clock) then --Para uso en la tarjeta DE10-lite
		--elsif rising_edge(Clock) then --Para simulacion
			if selector_salida = '1' then
				registro_estado_presente <= liga_main_V;
				Salidas <= salidasV;
			else
				registro_estado_presente <= liga_main_F;
				Salidas <= salidasF;
			end if;
			
			
		end if;
	end process;
	process (prueba)
	begin
		case prueba is
			when "00" => 	--X
				selector_salida <= Entradas(0);
			when "01" =>	--Y
				selector_salida <= Entradas(1);
			when "10" =>	--Z
				selector_salida <= Entradas(2);
			when "11" =>	--W
				selector_salida <= Entradas(3);
			when others =>
				selector_salida <= '0';
		end case;
	end process;

end architecture;
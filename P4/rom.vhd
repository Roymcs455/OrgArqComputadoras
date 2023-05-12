library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ROM is
	port
	(
		-- Input ports
		clk_input: 	in std_logic;
		direccion: 	in std_logic_vector	(2 downto 0); 	--Dirección de 3 bits
		-- Output ports
		prueba	: out std_logic_vector(1 downto 0) := "00";
		ligaV		: out std_logic_vector(2 downto 0) := "000";
		ligaF		: out std_logic_vector(2 downto 0) := "000";		
		salidasV	: out std_logic_vector(4 downto 0) := "00000";
		salidasF	: out std_logic_vector(4 downto 0) := "00000"
		
	);
end ROM;

architecture behavioral of ROM is

begin
	process (direccion)
	begin		
		case direccion is 
			when "000" =>
				prueba 	<= "00";
				ligaV 	<= "001";
				ligaF 	<= "001";
				salidasV <= "00000";
				salidasF <= "00000";
			when "001" =>
				prueba 	<= "10";
				ligaV 	<= "011";
				ligaF 	<= "010";
				salidasV <= "10000";
				salidasF <= "10010";					
			when "010" =>
				prueba 	<= "00";
				ligaV 	<= "100";
				ligaF 	<= "100";
				salidasV <= "00000";
				salidasF <= "00000";
			when "011" =>
				prueba 	<= "11";
				ligaV 	<= "010";
				ligaF 	<= "001";
				salidasV <= "01001";
				salidasF <= "01011";
			when "100" =>
				prueba 	<= "00";
				ligaV 	<= "110";
				ligaF 	<= "101";
				salidasV <= "00111";
				salidasF <= "00110";
			when "101" =>
				prueba 	<= "00";
				ligaV 	<= "100";
				ligaF 	<= "100";
				salidasV <= "00001";
				salidasF <= "00001";
			when "110" =>
				prueba 	<= "01";
				ligaV 	<= "010";
				ligaF 	<= "101";
				salidasV <= "11000";
				salidasF <= "00000";					
			when others =>
				prueba 	<= "00";
				ligaV 	<= "000";
				ligaF 	<= "000";
				salidasV <= "00000";
				salidasF <= "00000";
		end case;
	end process;
end architecture;

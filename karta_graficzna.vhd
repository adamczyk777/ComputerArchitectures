--karta graficzna w VHDL
--Wejścia interfejsu D-SUB (VGA)
--1. Synchronizacja pozioma
--2. Synchronizacja pionowa
--3. Red
--4. Green
--5. Blue

------------------------------------------
--CLK - ma częstotliwość 50 MHz (z czego wynika, że jeden takt trwa 20 ns)
------------------------------------------


entity vga is
    port(
        RESET : in std_logic;
        CLK : in std_logic;
        POZO : in std_logic_vector(10 downto 0);
        PIONO : in std_logic_vector(10 downto 0);
        SPION : out std_logic;
        SPOZ : out std_logic;
        VIDEO : out std_logic_vector(2 dowtn 0)
    );
end vga;
    
    
linia <= "001 010 010 001 001 001 001 001"; --(3x8x8 linii = ilość bitów)
    
architecture arch_vga of vga is
signal x : std_logic_vector(10 downto 0);
signal y : std_logic_vector(10 downto 0);
begin
    SPOZ <= '0' when x > 1305 and x <= 1493 else '1';
    SPION <= '0' when y > 493 and y <= 495 else '1'; -- 16784/31,77 
    VIDEO <= "000" when x > 1258 or y > 480 else
    --rysowanie czerwonego paska pionowego o określonej szerokości 20 pikseli
    --"100" when x > POZO and x <= POZO+20 and y > PIONO and y <= PIONO+20 else
    linia(0 to 2) when x > POZO and x <= POZO+8 and -- trzy początkowe bity z 'linia'
    "010";
    process(CLK, RESET)
    begin
        if(RESET = '1') then
            x <= (others => '0');
            y <= (others => '0');
        elsif(CLK`event and CLK=1) then
            if(x > POZO and x <= POZO+8 and y > PIONO and y <= PIONO+8) then
                linia <= linia(3 to 8*8*3-1)&linia(0 to 2);
            end if;
            x <= x + 1;
            if(x = 1588) then -- 31770/20 = 1588,5 - tyle razy wejdziemy do petli (zaokraglamy do 1589 i odejmujemy 1)
                x <= (others => '0');
                y <= y + 1;
            end if;                
            if(y = 527) then -- 16784/31,77 = 528,29 - tyle razy zmienia sie 'y'
                y <= (others => '0')
            end if;
        end if;
    end process;
end arch_vga;
    

    --Mamy rozdzielczosc 800x600 przy 60Hz odświeżania.
    --W poziomie ma być 800 punktów, w pionie 600 punktów. Mamy to rysować z częstosliwością 60 Hz. Mamy zegar 50 Hz.
    --Czas dla x = 31.77 mikrosekundy. Ile taktów segara 50 Mhz dla 31.77 mikrosekund.
    
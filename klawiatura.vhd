--klawiatura ps2 bez próbkowania
entity PS2 is
    port(reset: in std_logic;
        klw_clk: in std_logic;
        klw_dane: in std_logic;
        dane_wyj: out std_logic_vector(7 downto 0));
end PS2;

architecture arch_PS2 of PS2 is

    signal dane: std_logic_vector(10 downto 0);
    signal licznik: std_logic_vector(8 downto 0);

begin
    process(reset, klw_clk)
    begin
        if(reset = '1') then
            dane <= (others => '0');
            licznik <= (others => '0');
        elsif(rising_edge(klw_clk)) then
            dane <= klw_dane & dane(10 downto 1);
            licznik <= licznik + 1;
            if(licznik=10) then
                licznik <= (others => '0');
                dane_wyj <= dane(9 downto 2);
            end if;
        end if;
    end process;
end arch_PS2 ; -- arch_PS2

-- wersja z probkowaniem:
entity PS2_prob is
    port(reset: in std_logic;
        clk120k: in std_logic;
        klw_clk: in std_logic;
        klw_dane: in std_logic;
        dane_wyj: out std_logic_vector(10 downto 0));
end PS2_prob;

architecture arch_PS2_prob of PS2_prob is

    signal dane: std_logic_vector(10 downto 0);
    signal licznik: std_logic_vector(3 downto 0);
    signal probki_clk: std_logic_vector(4 downto 0);
    signal probki_dane: std_logic_vector(4 downto 0);

begin
    process(clk120k, reset)
    begin
        if(reset = '1') then
            dane <= (others => '0');
            licznik <= (others => '0');
            probki_clk <= (others => '0');
            probki_dane <= (others => '0');
        elsif(rising_edge(clk120k)) then
            probki_clk <= klw_clk & probki_clk(4 downto 1);
            probki_dane <= klw_dane & probki_dane(4 downto 1);
            if(probki_clk(0) = '1' and probki_clk(1) = '1' and probki_clk(2) + probki_clk(3) + probki_clk (4) < 2) then
                licznik <= licznik + 1;
                if(probki_dane(0) + probki_dane(1) + probki_dane(2) + probki_dane(3) + probki_dane(4) > 2) then
                    dane <= '1' & dane(10 downto 1);
                else
                    dane <= '0' & dane(10 downto 1);
                end if;
                if(licznik = 10) then
                    licznik ,+ (others => '0');
                    dane_wyj <= dane(9 downto 2);
                end if;
            end if;
        end if;
    end process;

end arch_PS2_prob ; -- arch_PS2_prob
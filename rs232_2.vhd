-- wersja rs 232 z wykladow\
entity weRS232 is
  port(we:in std_logic;
      96kHz:in std_logic;
      RESET:ins std_logic;
      wy: out std_logic_vector(7 downto 0);
      ZD: out std_logic);
end weRS232;

architecture arch_weRS22 of we_RS232 is
  signal PROBKI: std_logic_vector(6 downto 0); -- nieparzysta liczba probek
  signal DANE: std_logic_vector(7 downto 0);
  signal NR_PROBKI: std_logic_vector(3 downto 0);
  signal NR_BITU: std_logic_vector(3 downto 0);
  signal TRANS: std_logic; -- info czy zostal znaleziony bit startu

begin
  process(RESET, 96kHz)
  begin
    if(RESET = '1') then
      PROBKI <= (others => '0');
      DANE <= (others => '0');
      NR_PROBKI <= (others => '0');
      NR_BITU <= (others => '0');
      TRANS <= '0';
      ZD <= '0';
    elsif(rising_edge(96kHz)) then
      PROBKI <= we & PROBKI(6 downto 1); -- na każdym zboczu narastajacym probkowany
      --jest sygnał wyjsciowy
      if(TRANS='0') then
        if(PROBKI(0)
        +PROBKI(1)
        +PROBKI(2)
        +PROBKI(3)
        +PROBKI(4)
        +PROBKI(5)
        +PROBKI(6) < 3) then
          NR_PROBKI <= (others => '0');
          NR_BITU <= (others => '0');
          TRANS <= '1';
          ZD <= '0';
        end if;
      else
        NR_PROBKI <= NR_PROBKI + 1;
        if((NR_BITU = 0 & NR_PROBKI = 10) or (NR_BITU /=0 & NR_PROBKI=10)) then
          if(PROBKI(0)
          +PROBKI(1)
          +PROBKI(2)
          +PROBKI(3)
          +PROBKI(4)
          +PROBKI(5)
          +PROBKI(6) < 3) then
            DANE <= '1' & DANE(7 downto 1);
          else
            DANE <= '0' & DANE(7 downto 1);
          end if;
          NR_PROBKI <= (others => '0');
          NR_BITU <= NR_BITU + 1;
          if(NR_BITU = 8) then
            wy <= DANE;
            ZD <= '1';
            NR_BITU <= (others => '0');
            TRANS <= '0';
          end if;
        end if;
      end if;
    end if;
  end process;
end arch_weRS22;

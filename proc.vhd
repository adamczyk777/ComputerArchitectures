-- procesorek w vhdl z wykladow
entity proc is
  port(reset: in std_logic;
      clk: in std_logic;
      p_prog_adr: out std_logic_vector(63 downto 0);
      p_prog_dane: in std_logic_vector(63 downto 0);
      p_danych_adr1: out std_logic_vector(63 downto 0);
      p_danych_dane1: in std_logic_vector(63 downto 0);
      p_danych_adr2: out std_logic_vector(63 downto 0);
      p_danych_dane2: in std_logic_vector(63 downto 0);
      p_danych_zapisz: out std_logic);
end proc;

architecture arch_proc of proc is
begin
  signal A, B, C, l_rozk, r_rozk, r_arg,: std_logic_vector(63 downto 0);
  signal cykl: std_logic_vector(3 downto 0):

  process(clk, reset)
  begin
    if(reset = '1') then
      p_prog_adr <= (others => '0');
      p_danych_adr1 <= (others => '0');
      p_danych_adr2 <= (others => '0');
      p_danych_dane2 <= (others => '0');
      p_danych_zapisz <= (others => '0');
      A <= (others => '0');
      B <= (others => '0');
      C <= (others => '0');
      l_rozk <= (others => '0');
      r_rozk <= (others => '0');
      r_arg <= (others => '0');
      cykl <= (others => '0');
    elsif(rising_edge(clk)) then
      cykl = cykl + 1;
      if(cykl = 0) then -- w zerowym cyklu wykonywane jest zawsze to samo
        r_rozk <= p_prog_dane;
        l_rozk <= l_rozk + 1;
        p_prog_adr <= l_rozk + 1;
        p_danych_zapisz <= '0';
      elsif(r_rozk = 1) then -- pam -> A
        if(cykl = 1) then
          p_danych_adr1 <= p_prog_dane; -- na p_prog_dane znajduje sie teraz adres argumentu
        elsif(cykl = 2) then
          l_rozk = l_rozk + 1;
          p_prog_adr <= l_rozk + 1;
          A <= p_danych_dane1;
          cykl <= (others => '0');
        end if;
      elsif(r_rozk = 3) then -- c -> Pam
        if (cykl = 1) then
          p_danych_adr2 <= p_prog_dane;
          p_danych_dane2 <= C;
        end if;
        if(cykl = 2) then 
          l_rozk <= l_rozk + 1;
          p_prog_adr <= l_rozk + 1;
          p_danych_zapisz <= '1';
          cykl <= (others => '0');
        end if;
      elsif(r_rozk = 4) then -- A + B -> C
        C <= A + B;
        cykl <= (others => '0');
      elsif(r_rozk = 8) then
        C <= A(0)) & A(63 downto 1);
        cykl <= (others => '0');
      elsif(r_rozk = 9) then -- skok bezwarunkowy
        if( cykl = 1) then
          r_arg <= p_prog_dane;
        elsif(cykl = 2) then
          p_prog_adr <= r_arg;
          l_rozk <= r_arg;
          cykl <= (others => '0');
        end if;
      elsif(r_rozk = 10) then
        if(cykl = 1) then
          if(C = 0) then
            cykl <= (others => '0');
            l_rozk <= l_rozk + 1;
            p_prog_adr = l_rozk + 1;
          end if;
          r_arg <= p_prog_dane;
        elsif(cykl = 2) then
          l_rozk <= rarg;
          p_prog_adr <= r_arg;
          cykl <= (others => '0');
        end if;
      end if;
    end if;
  end process;
end arch_proc;




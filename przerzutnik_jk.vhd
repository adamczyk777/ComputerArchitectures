-- schemat vhdl przerzutnika JK
entity przerzutnik_jk is
    port(
        clk: in std_logic;
        reset: in std_logic;
        J in std_logic;
        K: in std_logic;
        Q: inout std_logic -- jest inout ponieważ odczytujemy je i zarazem je przypisujemy
    );
end przerzutnik_jk;

architecture arch_przerzutnik_jk of przerzutnik_jk is
    begin
        process(clk, reset)
            if(reset = '1') then 
                Q <= 0;
            elsif(clk'event and clk = '1') then
                if(J = '1' and K = '0') then -- dla stanu J = 1 K = 1 mamy podtrzymanie więc Q<=Q więc go wogole nie piszemy
                    Q <= '1';
                elsif(J = '0' and K = '1') then
                    Q <= '0';
                elsif(J = '1' and K = '1') then
                    Q <= not Q;
                end if;
            end if;
        end process;
    end
end arch_przerzutnik_jk;
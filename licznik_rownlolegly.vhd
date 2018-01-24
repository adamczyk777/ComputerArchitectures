--  prosty 8 bitowy licznik z wejściem równoległym
--  author: Jakub Adamczyk
entity licznik_rown is
    port(
        clk: in std_logic;
        reset: in std_logic;
        tryb: in std_logic; -- tryb 0 jest defaultowym trybem licznika
        we: inout std_logic_vector(7 downto 0);
        wy: inout std_logic_vector(7 downto 0)
    );
end licznik_rown;

architecture arch_licznik_rown of licznik_rown is
    begin
        process(clk, reset)
            if(reset = '1') then
                wy <= (others => '0');
            elsif(clk'event and clk = '1') then 
                if(tryb = '0') then 
                    wy <= wy + 1;
                else
                    wy <= we;
                end if;
            end if;
        end process;
end arch_licznik_rown;
    
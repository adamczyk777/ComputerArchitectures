--rejestr szeregowy w vhdl
entity rejestr_szeregowy is
    port(
        clk: in std_logic;
        reset: in std_logic;
        tryb: in std_logic;
        we: in std_logic;
        wy: inout std_logic
    );
end rejestr_szeregowy;

architecture arch_rejestr_szeregowy of rejestr_szeregowy is
    signal pom: std_logic_vector(63 downto 0);
    begin
        process(clk, reset)
            if(reset = '1') then
                pom <= (others => '0');
            elsif(clk'event and clk = '1') then 
                wy <= pom(0);
                pom <= wej & pom(63 downto 1);
            end if;
        end process;
end arch_rejestr_szeregowy;

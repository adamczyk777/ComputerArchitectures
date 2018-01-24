--kod vhdl rejestru równoległego 64 bitowego
entity rejestr_rown is
    port(
        clk: in std_logic;
        reset: in std_logic;
        tryb: in std_logic;
        we: in std_logic_vector(63 downto 0);
        wy: out std_logic_vector(63 downto 0)
    );
end rejestr_rown;
architecture arch_rejestr_rown of rejestr_rown is
    begin
        process(clk, reset)
            if(reset = '1') then 
                wy <= (others => '0');
            elsif(clk'event and clk = '1') then
                wy <= we;
            end if;
        end process;
end arch_rejestr_rown;
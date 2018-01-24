-- licznik w vhdl
entity licznik is
    port(
        clk: in std_logic;
        reset: in std_logic;
        wy: inout std_logic_vector(3 downto 0)
    );
end licznik;

architecture arch_licznik of licznik is
    begin
        process(clk, reset)
            if(reset = '1') then
                wy <= (others => '0');
            elsif(clk'event and clk = '1') then 
                wy <= wy + 1'
            end if;
        end process;
    end
end arch_licznik;
--karta graficzna z sycnhronizacja 800x600 50Hz
entity vga is
    port(clk50: in std_logic;
        reset: in std_logic;
        xk: in std_logic_vector(10 downto 0);
        yk: in std_logic_vector(9 downto 0);
        vsycn: out std_logic;
        hsync: out std_logic;
        color: out std_logic_vector(2 downto 0));
end vga;

architecture arch_bga of vga is

    signal px:std_logic_vector(10 downto 0);
    signal py:std_logic_vector(9 downto 0);

begin
    process(clk50, reset)
    begin
        if(reset = '1') then
            px <= (others => '0');
            py <= (others => '0');
        elsif(clk50'event and clk50 = '1) then
            px <= px+1;
            if(px=1319) then
                px <= (others => '0');
                py <= py+1;
                if(py = 627) then
                    py <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    hsync <= '0' when px >= 1049 and px < 1209 else '1';
    vsync <= '0' when py >= 600 and px < 604 else '1';
    kolor <= '010' when px >= xk and px < xk+63 and py >= yk and py < yk+ 50 else
        '100' when px < 1000 and py < 600 else
        '000';
end arch_bga ; -- arch_bga
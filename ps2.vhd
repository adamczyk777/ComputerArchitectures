--schemat dla urządzenia wejścia interfejsu ps2
entity ps2 is
    port(
        clk: in std_logic;
        reset: in std_logic;
        DATA: on std_logic;
        klaw: out std_logic_vector(7 downto 0);
        clk150kHz: in std_logic
    );
end ps2;

architecture arch_ps2 of ps2 is
    signal bit_no: std_logic_vector(3 downto 0); --bo liczymy do 10
    signal data: std_logic_vector(10 downto0); -- bo 11 bitów danych
    signal Rclk: std_logic_vector(4 downto 0);
    signal RDATA: std_logic_vector(2 downto 0);
begin
    process(clk150kHz, reset)
    begin
        if(reset = '1') then
            bit_no <= (others => '0');
            data <= (others => '0');
        elsif(clk150kHz'event and clk150kHz = '1') then -- sprawdzamy zbocze narastające
            Rclk <= clk & Rclk(4 downto 1);
            RDATA <= clk & RDATA(4 downto 1);
            if(Rclk = "00011") then
                if(RDATA(0) + RDATA(1) + RDATA(2) > 1) then
                    if(('0' & RDATA(0)) + ('0' + RDATA(1)) + ('0') & RDATA(2) > 1) then
                        data <= '1' & data(10 downto 1);
                    else
                        dane <= '0' & data(10 downto 1);
                    end if;

                    bit_no <= bit_no + 1;
                    if(bit_no = 10) then
                        bit_no <= (others => '0');
                        klaw <= data(9 downto 2); -- dane bez startu i końca
                    end if;
                end if;
            end if;
        end if;
    end process;
end arch_ps2 ; -- arch_ps2
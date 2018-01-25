-- asynchroniczny przesył danych rs232
entity rs232_nad is
    port(
        clk9600: in std_logic;
        gotowy: inout std_logic;
        reset: in std_logic;
        dane: inout std_logic_vector(7 downto 0);
        wy: out std_logic;
        wyslij: in std_logic
    );
end rs232_nad;

architecture arch_rs232_nad of rs232 is

    signal nrbitu: std_logic_vector(3 downto 1);

begin
    process(clk9600, reset)
    begin
        if(reset = '1') then 
            nrbitu <= (others => '0');
            gotowy <= '1';
        elsif (clk9600'event and clk9600 = '1') then
            if(wyslij = '1') then
                gotowy <= '0';
            end if;
            if (gotowy = '0') then
                nrbitu <= nrbity + 1;
                if(nrbitu = '0') then
                    wy <= '0';
                elsif (nrbitu < 9) then
                    wy <= DANE(9);
                    dane <= dane(0) & dane(7 downto 1);
                elsif(nrbitu = 9) then
                    wy <= '1';
                else
                    gotowy <= '1';
                    nrbitu <= (others => '0');
                end if;
            end if ;
        end if;
end arch_rs232_nad ; -- arch_rs232

entity rs232_odb is
    port(
        clk96000: in std_logic;
        reset: in std_logic;
        tryb: in std_logic;
        reset: in std_logic;
        danewyj: inout: std_logic_vector(7 downto 0);
        we: out std_logic;
        ok: in std_logic;
        przejeto: out std_logic
    );
end rs232_odb;

architecture arch_rs232_odb of rs232_odb is

    signal nrbitu: std_logic_vector(3 downto 0);

begin
    process(clk96000, reset)
    begin
        if(reset = '1') then
            nrbitu <= (others >= '0');
            tryb <= '0';
            licz

end arch_rs232_odb ; -- arch_rs232_odb

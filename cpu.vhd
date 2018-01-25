-- procesor w VHDL
entity procesor is
    port(
        clk2: in std_logic;
        reset: in std_logic;
        PAM_PROG_ADRES: out std_logic_vector(31 downto 0);
        PAM_PROG_DANE: in std_logic_vector(31 downto 0);
        PAM_DANCYH_ADRES1: out std_logic_vector(31 downto 0);
        PAM_DANYCH_DANE1: in std_logic_vector(31 downto 0);
        PAM_DANYCH_ADRES2: out std_logic_vector(31 downto 0);
        PAM_DANYCH_DANE2: out std_logic_vector(31 downto 0)
    );
end procesor;

architecture arch_procesor of procesor is
    signal A: std_logic_vector(31 downto 0);
    signal B: std_logic_vector(31 downto 0);
    signal C: std_logic_vector(31 downto 0);
    signal RejRozk: std_logic_vector(31 downto 0);
    signal RejArg: std_logic_vector(31 downto 0);
    signal LiczRozk: std_logic_vector(31 downto 0);
    signal cykl: std_logic_vector(3 downto 0);
begin
    process(clk, reset)
    begin
        if(reset = '1') then
            cykl <= (others => '0');
            LiczRozk <= (others => '0');
            PAM_PROG_ADRES <= (others => '0');
        elsif(clk'event and clk = '1') then
            cykl <= cykl + 1;
            if(cykl - "00") then 
                LiczRozk <= LiczRozk + 1;
                PAM_PROG_ADRES <= LiczRozk + 1;
                RejRozk <= PAM_PROG_DANE;
                RejArg <= (others => '0');
            elsif(RejRozk = 0) then
                if(cykl = 1) then
                    PAM_DANYCH_ADRES1 <= PAM_PROG_DANE;
                    LiczRozk <= LiczRozk + 1;
                    PAM_PROG_ADRES <= LiczRozk + 1;
                elsif(cykl = 2) then
                    A <= PAM_DANYCH_DANE1;
                    cykl <= (others => '0');
                end if;
            elsif(RejRozk = 1) then
                if(cykl = 1) then
                    PAM_DANYCH_ADRES_1 <= PAM_PROG_DANYCH;
                    LiczRozk <= LiczRozk + 1;
                    PAM_PROG_ADRES <= LiczRozk + 1;
                elsif(cykl = 2) then
                    B <= PAM_DANYCH_DANE1;
                    cykl <= (others => '0');
                end if;
            elsif(RejRozk = 3) then
                if(cykl = 1) then
                    RejArg <= PAM_PROG_DANE;
                    LiczRozk <= LiczRozk + 1;
                    PAM_PROG_ADRES <= LiczRozk + 1;
                elsif(cykl = 2) then
                    LiczRozk <= RejArg;
                    PAM_PROG_ADRES <= RejArg;
                    cykl <= (others => ’0’);
                end if;
            elsif(RejRozk = 4) then
                if(cykl = 1) then
                    RejArg <= PAM_PROG_DANE;
                    LiczRozk <= LiczRozk + 1;
                    PAM_PROG_ADRES <= LiczRozk + 1;
                elsif(cykl = 2) then
                    if( C /= 0 ) then 
                        LiczRozk <= RejArg;
                        PAM_PROG_ADRES <= RejArg;
                        endif;
                        cykl <= (others => ’0’);
                    end if;
            elsif(RejRozk = 5) then // +
                C <= A + B;
                cykl <= (others => ’0’);
            elsif(RejRozk = 6) then // AND
                C <= A and B;
                cykl <= (others => ’0’);
            elsif(RejRozk = 7) then // OR
                C <= A or B;
                cykl <= (others => ’0’);
            elsif(RejRozk = 8) then // NOT
                C <= not A;
                cykl <= (others => ’0’);
            elsif(RejRozk = 9) then // >> bitowe w prawo
                C <= A(0) & A(63 downto 0);
                cykl <= (others => ’0’);
            end if;
        end if;
    end process;
end arch_procesor ; -- arch_procesor
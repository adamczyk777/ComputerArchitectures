-- to przyklad dekodera czyniacego cos w stylu aktywacji danego bitu z czterech na wyjsciu mamy wektor wartosci logicznych i mamy też adres który ejst binarną liczbą
entity dekoder is
    port(
        wy: out std_logic_vector(3 downto 0);
        addr: in std_logic_vector(1 downto 0)
    );
end dekoder;

architecture arch_dekoder of dekoder is
    begin
        wy <= "0001" when addr = "00" else
            "0010" when addr = "01" else
            "0100" when addr = "10" else
            "1000";
    end
end arch_dekoder;

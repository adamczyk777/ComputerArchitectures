entity multiplekser is
    port(
        wy: out std_logic; -- wysjcie multipleksera
        we: in std_logic_vector(0 to 3); -- wejscia multipleksera
        addr: in std_logic_vector(1 downto 0); -- szyna adresowa
    );
end multiplekser;

architecture arch_multiplekser of multiplekser is
    begin
        wy <= we(0) when addr = "00" else -- nasze operacje przypisujace na wyjscie dane wejscie w zaleznosci od ustawienia szyny adresowej
            we(1) when addr = "01" else
            we(2) when addr = "10" else
            we(3);
    end
end arch_multiplekser;
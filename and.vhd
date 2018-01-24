entity and is
    port(we0 : in std_logic; -- we0 i we1 wejscia do bramki
        we1 : in std_logic;
        wy : out std_logic --wyjscie bramki jej wybik
    );
end and;

architecture arch_and of and is
    begin
        wy <= we- and we1; -- tutaj operacja logiczna and
    end
end arch_and;
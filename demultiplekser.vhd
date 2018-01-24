-- przyklad prostego demultipleksera
entity demultiplekser is
    port(
        wy: out std_logic_vector(3 downto 0);
        we: in std_logic;
        addr; in std_logic_vector(1 downto 0)
    );
end demultiplekser;

architecture arch_demultiplekser of demultiplekser is
    begin
        wy <= "000" & we when addr = "00" else
            "00" & we & "0" when addr = "01" else
            "0" & we & "00" when addr = "10" else
            we & "000";
    end
end arch_demultiplekser;
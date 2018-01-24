--vhdl do ALU jednostki arytmetyczno logicznej
entity ALU is
    port(
        A: in std_logic_vector(63 downto 0);
        B: in std_logic_vector(63 downto 0);
        C: out std_logic_vector(63 downto 0);
        ster: in std_logic_vector(2 downto 0)
    );
end ALU;

architecture arch_ALU of ALU is
    begin
        C <= A and B when ster = "000" else
        A or B when ster = "001" else
        not A when ster = "010" else
        A + B when ster = "011" else
        A(0) & A(63 downto 1);
end arch_ALU;
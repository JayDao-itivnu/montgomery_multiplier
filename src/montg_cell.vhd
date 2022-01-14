library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity montg_cell is
    generic(
        M: integer := 163
        --constant F: std_logic_vector(M-1 downto 0):= x"001B"; --for M=16 bits
        --constant F: std_logic_vector(M-1 downto 0):= x"0101001B"; --for M=32 bits
        --constant F: std_logic_vector(M-1 downto 0):= x"010100000101001B"; --for M=64 bits
        --constant F: std_logic_vector(M-1 downto 0):= x"0000000000000000010100000101001B"; --for M=128 bits
        --constant F: std_logic_vector(M-1 downto 0):= "000"&x"00000000000000000000000000000000000000C9"; --for M=163
        --constant F: std_logic_vector(M-1 downto 0):= (0=> '1', 74 => '1', others => '0'); --for M=233
        --constant F: std_logic_vector(M-1 downto 0):= (others => '1'); --for M=233
    );
    port (
    c: in std_logic_vector(M-1 downto 0);
    b: in std_logic_vector(M-1 downto 0);
    F: in std_logic_vector(M-1 downto 0);
    a_i: in std_logic;
    new_c: out std_logic_vector(M-1 downto 0)
);
end montg_cell;

architecture rtl of montg_cell is
signal prev_c0: std_logic;
begin

    prev_c0 <= c(0) xor (a_i and b(0));

    datapath: for i in 1 to M-1 generate
        new_c(i-1) <= c(i) xor (a_i and b(i)) xor (F(i) and prev_c0);
    end generate;
    new_c(M-1) <= prev_c0;

end rtl;
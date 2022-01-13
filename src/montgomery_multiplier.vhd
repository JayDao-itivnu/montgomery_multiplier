----------------------------------------------------------------------------
-- Montgomery Multiplier (montgomey_mult.vhd)
--
-- 
-- 
-- Computes the polynomial multiplication x.y.r^-1 mod f in GF(2**m)
-- Implements a sequential cincuit

-- Defines 2 entities (montg_cell and montgomery_mult)
-- 
----------------------------------------------------------------------------
-----------------------------------
--  Montgomery multiplier basic data_path
-----------------------------------
library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity montg_cell is
    generic(
        M: integer := 8;
        F: std_logic_vector(7 downto 0) := "00011101" --for M=8 bits
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

-----------------------------------
-- Montgomery multiplier
-----------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity montgomery_multiplier is
    generic(
        M: integer := 8;
        F: std_logic_vector(7 downto 0) := "00011101" --for M=8 bits
        --constant F: std_logic_vector(M-1 downto 0):= x"001B"; --for M=16 bits
        --constant F: std_logic_vector(M-1 downto 0):= x"0101001B"; --for M=32 bits
        --constant F: std_logic_vector(M-1 downto 0):= x"010100000101001B"; --for M=64 bits
        --constant F: std_logic_vector(M-1 downto 0):= x"0000000000000000010100000101001B"; --for M=128 bits
        --constant F: std_logic_vector(M-1 downto 0):= "000"&x"00000000000000000000000000000000000000C9"; --for M=163
        --constant F: std_logic_vector(M-1 downto 0):= (0=> '1', 74 => '1', others => '0'); --for M=233
        --constant F: std_logic_vector(M-1 downto 0):= (others => '1'); --for M=233
    );
    port (
    a, b: in std_logic_vector (M-1 downto 0);
    clock, reset, start: in std_logic; 
    z: out std_logic_vector (M-1 downto 0);
    done: out std_logic
);
end montgomery_multiplier;

architecture rtl of montgomery_multiplier is

    component montg_cell is
        generic(
            M: integer := 8;
            F: std_logic_vector(7 downto 0) := "00011101" --for M=8 bits
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
            a_i: in std_logic;
            new_c: out std_logic_vector(M-1 downto 0)
        );
    end component montg_cell;

    signal inic, shift_r, ce_c: std_logic;
    signal count: natural range 0 to M;
    type states is range 0 to 3;
    signal current_state: states;
    signal aa, bb, cc, new_c: std_logic_vector (M-1 downto 0);
begin

    data_path: montg_cell 
    generic map (M =>M, F => F)
    port map (C => cc, B => bb, a_i => aa(0), new_c => new_c);
    
    counter: process(reset, clock)
    begin
        if reset = '1' then count <= 0;
        elsif clock' event and clock = '1' then
            if inic = '1' then 
                count <= 0;
            elsif shift_r = '1' then
                count <= count+1; 
            end if;
        end if;
    end process counter;

    sh_register_A: process(clock) --Shift register A
    begin
    if reset = '1' then 
        aa <= (others => '0');
    elsif clock'event and clock = '1' then
        if inic = '1' then
            aa <= a;
        else
            aa <= '0' & aa(M-1 downto 1);
        end if;
    end if;
    end process sh_register_A;
  
    register_B: process(clock)
    begin
        if reset = '1' then 
            bb <= (others => '0');
        elsif clock'event and clock = '1' then
            if inic = '1' then 
                bb <= b; 
            end if;
        end if;
    end process register_B;
  
    register_C: process(inic, clock)
    begin
        if inic = '1' or reset = '1' then 
            cc <= (others => '0');
        elsif clock'event and clock = '1' then
            if ce_c = '1' then 
                cc <= new_c; 
            end if;
        end if;
    end process register_C;
  
    z <= cc;

    control_unit: process(clock, reset, current_state)
    begin
        case current_state is
            when 0 to 1 => inic <= '0'; shift_r <= '0'; done <= '1'; ce_c <= '0';
            when 2 => inic <= '1'; shift_r <= '0'; done <= '0'; ce_c <= '0';
            when 3 => inic <= '0'; shift_r <= '1'; done <= '0'; ce_c <= '1';
        end case;

        if reset = '1' then current_state <= 0;
        elsif clock'event and clock = '1' then
            case current_state is
                when 0 => if start = '0' then current_state <= 1; end if;
                when 1 => if start = '1' then current_state <= 2; end if;
                when 2 => current_state <= 3;
                when 3 => if count = M-1 then current_state <= 0; end if;
            end case;
        end if;
    end process control_unit;

end rtl;

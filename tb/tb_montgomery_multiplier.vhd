library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;
use ieee.std_logic_textio.all;
library std_developerskit;
use std_developerskit.std_iopak.all;
library std;
use std.textio.all;
use std.env.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_montgomery_multiplier IS
END tb_montgomery_multiplier;
 
ARCHITECTURE behavior OF tb_montgomery_multiplier IS 
  constant M: integer := 163;
  constant F: std_logic_vector(162 downto 0) := "000"&x"00000000000000000000000000000000000000C9";
    -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT montgomery_multiplier is
    generic(
   	M: integer := 8
     	F: std_logic_vector(7 downto 0) := "00011101" --for M=8 bits
      --constant F: std_logic_vector(M-1 downto 0):= x"001B"; --for M=16 bits
      --constant F: std_logic_vector(M-1 downto 0):= x"0101001B"; --for M=32 bits
      --constant F: std_logic_vector(M-1 downto 0):= x"010100000101001B"; --for M=64 bits
      --constant F: std_logic_vector(M-1 downto 0):= x"0000000000000000010100000101001B"; --for M=128 bits
      --constant F: std_logic_vector(M-1 downto 0):= "000"&x"00000000000000000000000000000000000000C9"; --for M=163
      --constant F: std_logic_vector(M-1 downto 0):= (0=> '1', 74 => '1', others => '0'); --for M=233
      --constant F: std_logic_vector(M-1 downto 0):= (others => '1'); --for M=233
  --  );
    port (
    a, b: in std_logic_vector (M-1 downto 0);
    clock, reset, start: in std_logic; 
    z: out std_logic_vector (M-1 downto 0);
    done: out std_logic
    );
  END COMPONENT;
  -- inputs
    
  signal clock : std_logic := '0';
  signal reset : std_logic := '1';
  signal a : std_logic_vector(M-1 downto 0) := (others => '0');
  signal b : std_logic_vector(M-1 downto 0) := (others => '0');

  -- Outputs
  signal z_out : std_logic_vector(M-1 downto 0):= (others => '0');
  SIGNAL done : STD_LOGIC:= '0';
  signal data_check: std_logic_vector(M-1 downto 0):= (others => '0');

  -- Clock period definitions
  constant clock_period : time := 100 ns;
  signal start:std_logic:= '0';
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: montgomery_multiplier
  GENERIC MAP(
     M => M,
     F => F
  )
  PORT MAP (
    clock => clock,
    reset => reset,
    a => a,
    b => b,
    z => z_out,
    start => start,
    done => done
    );

  -- Clock process definitions
  clock <= not clock after clock_period / 2;

  
  
  -- Stimulus process
  stim_proc: process
    file infile : text open read_mode is "montgomery_multiplier.txt";
    file infile1: text open write_mode is "check.txt";

    VARIABLE inline : LINE;
    VARIABLE outline : LINE;
    VARIABLE itr_numline : STRING(1 TO 2);  -- Line for iteration 'N='
    VARIABLE a_line : STRING(1 TO 2);           -- line for a 'A='
    VARIABLE b_line : STRING(1 TO 2);       -- Line for b 'B ='
    VARIABLE c_line : STRING(1 to 2);
    VARIABLE iteration_num : INTEGER;       
    VARIABLE a_str : STRING(1 TO 41);
    VARIABLE b_str : STRING(1 TO 41);
    VARIABLE c_str : STRING(1 TO 41);
    VARIABLE exp_c : STD_LOGIC_VECTOR(M-1 DOWNTO 0):= (OTHERS => '0');
	
    VARIABLE number_of_test : integer := 0;
    VARIABLE number_of_success : integer := 0;
    VARIABLE number_of_failure : integer := 0;
	
  begin		
    wait for 1 ns;
    reset <= '0';
    start <= '0';
    WAIT UNTIL (clock'EVENT AND clock ='1');
    reset <= '1';
    write(outline, string'("Tables Known Answer Tests"));
    writeline(output, outline);
    write(outline, string'("-------------------------"));
    while(not endfile(infile)) loop
      wait until rising_edge(clock);
      wait until rising_edge(clock);
      readline(infile, inline);
      read(inline, itr_numline);
      read(inline, iteration_num);
      readline(infile, inline);
      read(inline, a_line);
      read(inline, a_str);
      readline(infile, inline);
      read(inline, b_line);
      read(inline, b_str);
      readline(infile, inline);
      read(inline, c_line);
      read(inline, c_str);
      WAIT UNTIL (clock'EVENT AND clock ='1');
      wait for 4 ns;
      a <= to_StdLogicVector(From_HexString(a_str))(M downto 1);
      b <= to_StdLogicVector(From_HexString(b_str))(M downto 1);
      exp_c := to_StdLogicVector(From_HexString(c_str))(M downto 1);
      WAIT UNTIL (clock'EVENT AND clock='1');
      wait for 4 ns;
      reset <= '0';
      WAIT UNTIL (clock'EVENT AND clock='1');
      wait for 4 ns;
      start <= '1';     
      WAIT UNTIL (clock'EVENT AND clock ='1');
      wait for 4 ns;
      start <= '0';
      WAIT UNTIL done ='1';
      wait for 4 ns;
      data_check <= z_out;
      WAIT FOR 2*clock_period;  -- 2* clock_period
      
      write(outline, string'("Test Vector Number - "));
      write(outline, iteration_num);
      writeline(output, outline);
      write(outline, string'("Result: "));
      if (data_check = exp_c) then
        write(outline, string'("OK"));
        number_of_success := number_of_success + 1;
      else
        write(outline, string'("Error"));
        number_of_failure := number_of_failure + 1;
      end if;
      writeline(output, outline);
      number_of_test := number_of_test + 1;	
      
      writeline(infile1, inline);
      write(inline, itr_numline);
      write(inline, iteration_num);
      writeline(infile1, inline);
      write(inline, a_line);
      write(inline, a_str);
      writeline(infile1, inline);
      write(inline, b_line);
      write(inline, b_str);
      writeline(infile1, inline);
      write(inline, c_line);
      write(inline, exp_c);
   end loop;

    write(outline, string'("=============== Summary ==========================="));
    writeline(output, outline);
    write(outline, string'("Number of inputs: "));
    write(outline, number_of_test);
    writeline(output, outline);
    write(outline, string'("Number of test passed: "));
    write(outline, number_of_success);
    writeline(output, outline);
    write(outline, string'("Number of test failed: "));
    write(outline, number_of_failure);
    writeline(output, outline);
    write(outline, string'("==================================================="));
    writeline(output, outline);

    finish(2);
  end process;

END;

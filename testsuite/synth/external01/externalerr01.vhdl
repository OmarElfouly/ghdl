library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity externalerr01_sub is
  port (clk : std_logic;
        rst : std_logic;
        a : std_logic_vector(7 downto 0);
        o : out std_logic_vector(7 downto 0));
end externalerr01_sub;

architecture behav of externalerr01_sub is
  signal accum : std_logic_vector(7 downto 0);
begin
  process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        accum <= (others => '0');
      else
        accum <= std_logic_vector(unsigned(accum) + unsigned(a));
      end if;
    end if;
  end process;

  process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        o <= (others => '0');
      else
        o <= accum;
      end if;
    end if;
  end process;
end behav;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity externalerr01 is
  port (clk : std_logic;
        rst : std_logic;
        a : std_logic_vector(7 downto 0);
        accum : out std_logic_vector(7 downto 0);
        o : out std_logic_vector(7 downto 0));
end externalerr01;

architecture behav of externalerr01 is
begin
  dut : entity work.externalerr01_sub
    port map (clk => clk,
              rst => rst,
              a => a,
              o => o);
  accum <= << signal .externalerr01.dut.accum : bit_vector(7 downto 0) >>;
end behav;

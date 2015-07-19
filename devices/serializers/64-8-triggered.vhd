library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity serializer is
  port(
    clk    : in std_logic;
    input  : in std_logic_vector(0 to 512);
    output : out std_logic_vector(0 to 63)
  );
end serializer;

architecture Behavioral of serializer is
  alias reset : std_logic is input(0);
  alias vector  : std_logic_vector(0 to 511) is input(1 to 512);
  
begin

process(clk)
  variable state : std_logic_vector (0 to 2) := "000";
  variable text  : std_logic_vector (0 to 511) := (others => '0');
begin

  if clk'event AND clk = '1' then
    if reset = '1' then
      text := vector;
      output <= text(0 to 63);
      state := "001";
    else
      if (state = "000") then
        output <= text(0 to 63);
        state := "001";
      elsif (state = "001") then
        output <= text(64 to 127);
        state := "010"; 
      elsif (state = "010") then
        output <= text(128 to 191); 
        state := "011";
      elsif (state = "011") then
        output <= text(192 to 255);
        state := "100";
      elsif (state = "100") then
        output <= text(256 to 319);
        state := "101";
      elsif (state = "101") then
        output <= text(320 to 383);
        state := "110";
      elsif (state = "110") then
        output <= text(384 to 447);
        state := "111";
      else
        output <= text(448 to 511);
      end if;
    end if;
  end if;
end process;

end Behavioral;

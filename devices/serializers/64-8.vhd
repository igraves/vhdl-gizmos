library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity serialize is
  port(
    clk : in std_logic;
    vector : in std_logic_vector(0 to 511);
    output : out std_logic_vector(0 to 63)
  );
end serialize;

architecture Behavioral of serialize is

begin

  dev : process(clk)
    variable state : std_logic_vector (0 to 2) := "000";
    variable text : std_logic_vector(0 to 447);
  begin
  
    if clk'event AND clk = '1' then
      if state = "000" then
        text := vector(64 to 511);
        output <= vector(0 to 63); 
        state := "001";
      elsif state = "001" then
        output <= text(0 to 63);
        state := "010";
      elsif state = "010" then
        output <= text(64 to 127);
        state := "011";
      elsif state = "011" then
        output <= text(128 to 191);
        state := "100";
      elsif state = "100" then
         output <= text(192 to 255);
        state := "101";
      elsif state = "101" then
         output <= text(256 to 319);
        state := "110";
      elsif state = "110" then
        output <= text(320 to 383);
        state := "111";
      else
        output <= text(384 to 447);
        state := "000";
      end if;
      
    end if;
  end process;

end Behavioral;

library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.all;
use UNISIM.vcomponents.all;

entity eightdiv is
  port(
    clk : in std_logic;
    clk_out : out std_logic;
    clkdiv_out : out std_logic
  );
end eightdiv;

architecture Behavioral of eightdiv is
  constant low : std_logic := '0';
  constant high : std_logic := '1';
begin
-- DCM_CLKGEN: Frequency Aligned Digital Clock Manager
-- Spartan-6
-- Xilinx HDL Libraries Guide, version 13.1

DCM_CLKGEN_inst : DCM_CLKGEN
  generic map (
    CLKFXDV_DIVIDE => 8, -- CLKFXDV divide value (2, 4, 8, 16, 32)
    CLKFX_DIVIDE => 2, -- Divide value - D - (1-256)
    --CLKFX_MD_MAX => 0.0, -- Specify maximum M/D ratio for timing anlysis
    CLKFX_MULTIPLY => 2, -- Multiply value - M - (2-256)
    CLKIN_PERIOD => 10.0, -- Input clock period specified in nS
    SPREAD_SPECTRUM => "NONE", -- Spread Spectrum mode "NONE", "CENTER_LOW_SPREAD", "CENTER_HIGH_SPREAD",
    -- "VIDEO_LINK_M0", "VIDEO_LINK_M1" or "VIDEO_LINK_M2"
    STARTUP_WAIT => FALSE -- Delay config DONE until DCM_CLKGEN LOCKED (TRUE/FALSE)
    )
  port map (
    CLKFX => clk_out, -- 1-bit output: Generated clock output
    --CLKFX180 => CLKFX180, -- 1-bit output: Generated clock output 180 degree out of phase from CLKFX.
    CLKFXDV => clkdiv_out, -- 1-bit output: Divided clock output
    --LOCKED => LOCKED, -- 1-bit output: Locked output
    --PROGDONE => PROGDONE, -- 1-bit output: Active high output to indicate the successful re-programming
    --STATUS => STATUS, -- 2-bit output: DCM_CLKGEN status
    CLKIN => clk, -- 1-bit input: Input clock
    FREEZEDCM => low, -- 1-bit input: Prevents frequency adjustments to input clock
    PROGCLK => low, -- 1-bit input: Clock input for M/D reconfiguration
    PROGDATA => low, -- 1-bit input: Serial data input for M/D reconfiguration
    PROGEN => low, -- 1-bit input: Active high program enable
    RST => low -- 1-bit input: Reset input pin
  );
end Behavioral;



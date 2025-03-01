library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use NUMERIC_STD for numeric operations

entity SimpleBankLocker is
    Port (
        clk         : in  STD_LOGIC;                -- Clock signal
        reset       : in  STD_LOGIC;                -- Reset signal
        code_in     : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit code input
        unlock      : in  STD_LOGIC;                -- Unlock signal
        lock        : in  STD_LOGIC;                -- Lock signal
        locker_open : out STD_LOGIC                 -- Locker status output
    );
end SimpleBankLocker;

architecture Behav of SimpleBankLocker is
    signal stored_code : STD_LOGIC_VECTOR(1 downto 0) := "10"; -- Example code (2-bit)
    signal locker_state : STD_LOGIC := '0';                   -- '0' = Locked, '1' = Unlocked
begin

    process(clk, reset)
    begin
        if reset = '1' then
            locker_state <= '0'; -- Reset to locked state
            locker_open <= '0';  -- Ensure locker is closed
        elsif rising_edge(clk) then
            if lock = '1' then
                locker_state <= '0'; -- Lock the locker
                locker_open <= '0';  -- Ensure locker is closed
            elsif unlock = '1' then
                if code_in = stored_code then
                    locker_state <= '1'; -- Unlock the locker
                    locker_open <= '1';  -- Locker is now open
                else
                    locker_open <= '0';  -- Incorrect code, keep locker closed
                end if;
            end if;
        end if;
    end process;

end Behav;

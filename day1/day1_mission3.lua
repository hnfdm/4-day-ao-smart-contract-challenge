-- Title: Lua Loops - Space Mission Edition
-- Description: Use loops to manage a spaceship’s tasks!

-- 1. While loop: Fueling up
local fuel = 0
while fuel < 10 do
    fuel = fuel + 2              -- Add 2 units of fuel each cycle
end
-- fuel = 10 (0 → 2 → 4 → 6 → 8 → 10; 5 cycles)

-- 2. Numeric for loop with step: Countdown to launch
local countdown = ""
for t = 10, 1, -1 do             -- Count from 10 to 1, step -1
    countdown = countdown .. t .. " "
end
-- countdown = "10 9 8 7 6 5 4 3 2 1 "

-- 3. Generic for (ipairs) loop: Checking crew list
local crew = {"Pilot", "Engineer", "Navigator"}
local crew_rollcall = ""
for i, member in ipairs(crew) do  -- ipairs for numbered lists
    crew_rollcall = crew_rollcall .. i .. ": " .. member .. ", "
end
-- crew_rollcall = "1: Pilot, 2: Engineer, 3: Navigator, "

-- 4. Nested loop bonus: Scanning sectors
local sectors_scanned = 0
for x = 1, 3 do                  -- 3 rows
    for y = 1, 2 do              -- 2 columns per row
        sectors_scanned = sectors_scanned + 1
    end
end
-- sectors_scanned = 6 (3 rows * 2 columns)

return {fuel = fuel, countdown = countdown, crew_rollcall = crew_rollcall, sectors_scanned = sectors_scanned}
-- Title: Lua Functions and Error Handling - Space Repair Edition
-- Description: Functions to fix a ship, with error handling for emergencies!

-- 1. Function with multiple returns
function get_ship_status(energy, hull)
    return energy > 0, hull > 50  -- Returns two booleans
end

-- 2. Anonymous function with a twist
local repair_cost = function(parts, urgency)
    if urgency then
        return parts * 2  -- Double cost if urgent
    else
        return parts * 1
    end
end

-- 3. Error handling with custom checks
function fix_reactor(power_level)
    assert(power_level >= 0, "Power level cannot be negative!")
    assert(power_level <= 100, "Reactor overload detected!")
    return power_level * 0.9  -- 90% efficiency after fix
end

-- 4. Testing with pcall and handling outcomes
local has_power, hull_ok = get_ship_status(10, 30)  -- true, false
local cost = repair_cost(5, true)                   -- 10 (urgent repair)

local status1, outcome1 = pcall(fix_reactor, -5)    -- Fails: negative power
local status2, outcome2 = pcall(fix_reactor, 150)   -- Fails: overload
local status3, outcome3 = pcall(fix_reactor, 50)    -- Succeeds: 45

-- 5. Process results
local report = ""
if not status1 then
    report = report .. "Reactor fix 1 failed: " .. outcome1 .. ". "
end
if not status2 then
    report = report .. "Reactor fix 2 failed: " .. outcome2 .. ". "
end
if status3 then
    report = report .. "Reactor fixed! Power at: " .. outcome3
end

return {has_power = has_power, hull_ok = hull_ok, cost = cost, report = report}
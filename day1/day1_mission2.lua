-- Title: Lua Conditional Logic - Adventure Edition
-- Description: Use if-else to decide a character’s fate!

local health = 25
local gold = 10

-- 1. Nested if-else: Check health status
local status
if health > 50 then
    status = "You're thriving!"
else
    if health > 20 then
        status = "You're hanging in there."
    elseif health > 0 then
        status = "You're barely alive!"
    else
        status = "Game over, buddy."
    end
end

-- 2. Multiple conditions with elseif: Can you buy a potion?
local shop_message
if gold >= 20 then
    shop_message = "You buy a potion and feel refreshed!"
elseif gold ~= 0 and gold >= 10 then
    shop_message = "You can afford a small heal."
elseif gold == 0 then
    shop_message = "You're broke—better find some gold!"
else
    shop_message = "How do you have negative gold?!"
end

-- 3. Combining conditions with logic operators
local adventure_tip
if health > 0 and gold < 15 then
    adventure_tip = "Stay cautious—low on gold and barely alive."
elseif health <= 0 or gold <= 0 then
    adventure_tip = "Time to restart your quest."
else
    adventure_tip = "Keep exploring, adventurer!"
end

-- Return all results in a table
return {status, shop_message, adventure_tip}
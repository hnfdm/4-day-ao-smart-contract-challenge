-- Title: Lua Variables and Basic Syntax - Extended Edition
-- Description: More fun with variables, math, and strings!

-- 1. Numbers and arithmetic
local x = 15          -- A local variable with value 15
local y = x - 7       -- Subtract 7 from x; y becomes 8
local z = y % 3       -- Modulus: remainder of 8 divided by 3 is 2

-- 2. Using variables in calculations
local total = x + y * z  -- Order of operations: 15 + (8 * 2) = 15 + 16 = 31

-- 3. Strings and concatenation with a twist
local user = "Explorer"
local message = "Welcome, " .. user .. "!"  -- "Welcome, Explorer!"
local score = "Your score is: " .. total    -- Convert total to string automatically: "Your score is: 31"

-- 4. Output with a little flair
return message .. " " .. score  -- Combines to "Welcome, Explorer! Your score is: 31"
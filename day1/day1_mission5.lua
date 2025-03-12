-- Title: Lua Tables - Space Colony Edition
-- Description: Use tables to manage a colony’s data!

-- 1. Array table with mixed types
local resources = {"water", 100, "oxygen", 50}
local total_items = #resources  -- 4 (counts numeric indices)

-- 2. Dictionary table with dynamic updates
local colony = {
    name = "Mars Base",
    population = 150,
    founded = 2045
}
colony.status = "Operational"  -- Add a new field

-- 3. Nested tables with deeper structure
colony.departments = {
    engineering = {workers = 30, tools = {"drill", "welder"}},
    science = {workers = 20, tools = {"scanner", "labkit"}}
}

-- 4. Table manipulation: Adding to an array
table.insert(colony.departments.engineering.tools, "hammer")
-- Now engineering.tools = {"drill", "welder", "hammer"}

-- 5. Iterating and calculating
local total_workers = 0
for dept, info in pairs(colony.departments) do
    total_workers = total_workers + info.workers
end

-- 6. Custom array iteration with ipairs
local resource_list = ""
for i, item in ipairs(resources) do
    resource_list = resource_list .. tostring(item) .. " "
end

-- Return the colony data with some extras
return {
    colony = colony,
    total_items = total_items,
    total_workers = total_workers,
    resource_list = resource_list
}
-- Title: Interacting with Other Processes
-- Description: Learn how one AO process can send messages to another.

local targetId = "m4uxntlVv-0JAaZaRhur9cI7yZVGhztq1HTd4NMFwlY"
Send({ Target = targetId, Data = "ping" })
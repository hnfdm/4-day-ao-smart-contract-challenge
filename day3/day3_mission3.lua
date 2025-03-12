-- Title: Implementing Owner-Only Actions
-- Description: Restrict certain contract functions to the contract's owner for security.

-- AO processes have an "Owner" by default – typically the wallet that launched the process. 
-- You can get this via the global variable `Owner` in your contrac ([FAQ | Cookbook](https://cookbook_ao.g8way.io/guides/aos/faq.html#:~:text=Understanding%20Process%20Ownership))】.

-- Let's add an admin-only "reset" command to our ping counter contract, which resets PingCount to 0.
Handlers.add(
    "reset_counter",
    Handlers.utils.hasMatchingData("reset"),    -- trigger on messages with data "reset"
    function(msg)
        if msg.From == Owner then
            PingCount = 0
            ao.send({ Target = msg.From, Data = "PingCount reset to 0" })
        else
            ao.send({ Target = msg.From, Data = "Unauthorized: Only owner can reset." })
        end
    end
)

Send({ Target = ao.id, Data = "reset" })
-- "Data": "Unauthorized: Only owner can reset.",
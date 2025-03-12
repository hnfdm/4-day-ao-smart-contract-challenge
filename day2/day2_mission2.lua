-- Title: Ping-Pong Message Handler
-- Description: Create a handler that listens for "ping" messages and replies with "pong".

Handlers.add(
    "pingpong",                            -- 1. Handler name (identifier)
    Handlers.utils.hasMatchingData("ping"),-- 2. Pattern: checks if incoming message Data == "ping" ([Creating a Pingpong Process in aos | Cookbook](https://cookbook_ao.g8way.io/guides/aos/pingpong.html#:~:text=1,pong))
    Handlers.utils.reply("pong")           -- 3. Handler function: automatically reply "pong" to sender ([Creating a Pingpong Process in aos | Cookbook](https://cookbook_ao.g8way.io/guides/aos/pingpong.html#:~:text=1,pong))
)

-- Response = 4

Send({ Target = ao.id, Data = "ping" })

-- Response = pong
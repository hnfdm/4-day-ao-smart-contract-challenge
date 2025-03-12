-- Title: Enhanced Token Info and Balance Handlers
-- Description: Improved handlers with logo, formatting, and owner-only access for all balances.

-- Assume initialized elsewhere
if not Balances then Balances = { [ao.id] = 2000000 } end
if not Name then Name = "AirdropASC" end
if not Ticker then Ticker = "AASC" end
if not Denomination then Denomination = 0 end
if not Owner then Owner = ao.id end
if not Logo then Logo = "SUGf4xy4q1Z_AuWmD0snomHxSkOaNjCCCXqDmJKzK-s" end

-- 1. Info Handler: Include logo and better formatting
Handlers.add(
    "info",
    Handlers.utils.hasMatchingTag("Action", "Info"),
    function(msg)
        ao.send({
            Target = msg.From,
            Data   = "Token Info:\n" ..
                     "Name: " .. Name .. "\n" ..
                     "Ticker: " .. Ticker .. "\n" ..
                     "Denomination: " .. tostring(Denomination) .. "\n" ..
                     "Owner: " .. Owner .. "\n" ..
                     "Logo: " .. (Logo or "None") .. "\n" ..
                     "Total Supply: " .. tostring(Balances[Owner] or 0)
        })
    end
)

-- 2. Balance Handler: Add error checking and readable response
Handlers.add(
    "balance",
    Handlers.utils.hasMatchingTag("Action", "Balance"),
    function(msg)
        local target = msg.Tags.Target or msg.From
        local bal = Balances[target] or 0
        ao.send({
            Target = msg.From,
            Data   = "Balance Query:\n" ..
                     "Account: " .. target .. "\n" ..
                     "Balance: " .. tostring(bal) .. " " .. Ticker
        })
    end
)

-- 3. Balances Handler: Restrict to owner and include summary
Handlers.add(
    "all_balances",
    Handlers.utils.hasMatchingTag("Action", "Balances"),
    function(msg)
        if msg.From ~= Owner then
            ao.send({
                Target = msg.From,
                Data   = "Error: Only the owner can view all balances."
            })
            return
        end
        local total = 0
        for _, bal in pairs(Balances) do total = total + bal end
        ao.send({
            Target = msg.From,
            Data   = "All Balances:\n" ..
                     "JSON: " .. require('json').encode(Balances) .. "\n" ..
                     "Total Circulating: " .. tostring(total) .. " " .. Ticker
        })
    end
)
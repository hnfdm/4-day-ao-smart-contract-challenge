-- Title: Enhanced Token Contract Testing
-- Description: Automated tests for token contract features.

-- Assume token.lua is loaded with initialization and handlers
-- .load token.lua (run this in AO console first)

-- Helper function to send and check response
local function sendAndCheck(action, tags, checkFn)
    Send({ Target = ao.id, Tags = tags })
    ao.wait(1)  -- Wait briefly for response (adjust as needed)
    local resp = Inbox[#Inbox]
    print("Test " .. action .. ":")
    checkFn(resp)
end

-- Test suite
print("Starting Token Contract Tests...")

-- 1. Test Info Query
sendAndCheck("Info", { Action = "Info" }, function(resp)
    assert(resp.Tags.Name == "AirdropASC", "Name mismatch")
    assert(resp.Tags.Ticker == "AASC", "Ticker mismatch")
    print("  Info OK: " .. resp.Tags.Name .. ", " .. resp.Tags.Ticker)
end)

-- 2. Test Initial Balance
sendAndCheck("Owner Balance", { Action = "Balance" }, function(resp)
    local bal = tonumber(resp.Tags.Balance)
    assert(bal == 2000000, "Initial balance should be 2000000")
    print("  Owner Balance: " .. bal)
end)

-- 3. Test Transfer
--local otherId = "<OTHER_PROCESS_OR_WALLET_ID>"  -- Replace with real ID
local otherId = "rRHlKRdjTCyheS9cxHclo2evArRXxlwGO1NjlDRtGYs"
sendAndCheck("Transfer 5000", { Action = "Transfer", Recipient = otherId, Quantity = "5000" }, function(resp)
    assert(resp.Tags.Action == "DebitNotice", "Expected DebitNotice")
    print("  Transfer OK: DebitNotice sent")
end)

-- Verify balances post-transfer
sendAndCheck("Recipient Balance", { Action = "Balance", Target = otherId }, function(resp)
    assert(tonumber(resp.Tags.Balance) == 5000, "Recipient balance should be 5000")
    print("  Recipient Balance: " .. resp.Tags.Balance)
end)
sendAndCheck("Owner Balance Post-Transfer", { Action = "Balance" }, function(resp)
    assert(tonumber(resp.Tags.Balance) == 1995000, "Owner balance should be 1995000")
    print("  Owner Balance: " .. resp.Tags.Balance)
end)

-- 4. Test Insufficient Balance
sendAndCheck("Insufficient Transfer", { Action = "Transfer", Recipient = otherId, Quantity = "999999999" }, function(resp)
    assert(resp.Tags.Action == "Transfer-Error", "Expected Transfer-Error")
    print("  Insufficient Balance OK: " .. resp.Tags.Error)
end)

-- 5. Test Minting
sendAndCheck("Mint 10000", { Action = "Mint", Quantity = "10000" }, function(resp)
    -- Note: Original handler doesn't send a success response; assume balance check suffices
    Send({ Target = ao.id, Tags = { Action = "Balance" } })
    ao.wait(1)
    local balResp = Inbox[#Inbox]
    assert(tonumber(balResp.Tags.Balance) == 2005000, "Balance should be 2005000 after mint")
    print("  Mint OK: New Balance " .. balResp.Tags.Balance)
end)

-- 6. Test Balances Dump
sendAndCheck("All Balances", { Action = "Balances" }, function(resp)
    local json = require('json').decode(resp.Data)
    assert(json[ao.id] == 2005000, "Owner balance in dump incorrect")
    assert(json[otherId] == 5000, "Recipient balance in dump incorrect")
    print("  Balances OK: " .. resp.Data)
end)

print("Tests Complete!")
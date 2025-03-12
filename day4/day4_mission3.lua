-- Title: Enhanced Token Transfer Handler
-- Description: Transfer tokens with denomination, limits, and detailed responses.

-- Assume initialized elsewhere
if not Balances then Balances = { [ao.id] = 2000000 } end
if not Name then Name = "AirdropASC" end
if not Ticker then Ticker = "AASC" end
if not Denomination then Denomination = 2 end  -- 2 decimal places
if not Owner then Owner = ao.id end

Handlers.add(
    "transfer",
    Handlers.utils.hasMatchingTag("Action", "Transfer"),
    function(msg)
        -- Input validation
        assert(type(msg.Tags.Recipient) == "string", "Recipient is required!")
        assert(type(msg.Tags.Quantity) == "string", "Quantity is required!")
        local qty_raw = tonumber(msg.Tags.Quantity)
        assert(qty_raw and qty_raw > 0, "Quantity must be a positive number!")

        -- Adjust for denomination (e.g., 1.23 with Denomination=2 becomes 123 units)
        local qty = math.floor(qty_raw * 10^Denomination)
        assert(qty <= 1000000 * 10^Denomination, "Transfer exceeds max limit of 1M " .. Ticker)

        local sender = msg.From
        local recipient = msg.Tags.Recipient

        -- Initialize balances if needed
        Balances[sender] = Balances[sender] or 0
        Balances[recipient] = Balances[recipient] or 0

        -- Check and perform transfer
        if Balances[sender] >= qty then
            Balances[sender] = Balances[sender] - qty
            Balances[recipient] = Balances[recipient] + qty

            -- Human-readable amount (e.g., 123 → "1.23" with Denomination=2)
            local qty_display = string.format("%." .. Denomination .. "f", qty / 10^Denomination)

            -- Notify both parties
            ao.send({
                Target = sender,
                Data = "Transferred " .. qty_display .. " " .. Ticker .. " to " .. recipient
            })
            ao.send({
                Target = recipient,
                Data = "Received " .. qty_display .. " " .. Ticker .. " from " .. sender
            })
        else
            ao.send({
                Target = sender,
                Data = "Transfer failed: Insufficient balance (" .. 
                       tostring(Balances[sender] / 10^Denomination) .. " " .. Ticker .. " available)"
            })
        end
    end
)
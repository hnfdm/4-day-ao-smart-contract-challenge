-- Title: Enhanced Token Minting Handler
-- Description: Mint tokens with limits, denomination, and detailed responses.

-- Assume initialized elsewhere
if not Balances then Balances = { [ao.id] = 2000000 } end
if not Name then Name = "AirdropASC" end
if not Ticker then Ticker = "AASC" end
if not Denomination then Denomination = 2 end  -- 2 decimal places
if not Owner then Owner = ao.id end
if not TotalSupplyCap then TotalSupplyCap = 10000000 * 10^Denomination end  -- 10M token cap
if not TotalMinted then TotalMinted = Balances[Owner] or 0 end  -- Track minted amount

Handlers.add(
    "mint",
    Handlers.utils.hasMatchingTag("Action", "Mint"),
    function(msg, env)
        -- Input validation
        assert(type(msg.Tags.Quantity) == "string", "Quantity is required!")
        local qty_raw = tonumber(msg.Tags.Quantity)
        assert(qty_raw and qty_raw > 0, "Quantity must be a positive number!")

        -- Adjust for denomination (e.g., 1.23 becomes 123 units)
        local qty = math.floor(qty_raw * 10^Denomination)

        if msg.From == Owner then
            -- Check supply cap
            local new_total = TotalMinted + qty
            assert(new_total <= TotalSupplyCap, "Minting " .. qty_raw .. " " .. Ticker .. 
                  " exceeds supply cap of " .. (TotalSupplyCap / 10^Denomination) .. " " .. Ticker)

            -- Mint the tokens
            Balances[Owner] = (Balances[Owner] or 0) + qty
            TotalMinted = new_total

            -- Readable amount (e.g., 123 → "1.23")
            local qty_display = string.format("%." .. Denomination .. "f", qty / 10^Denomination)

            -- Notify owner
            ao.send({
                Target = Owner,
                Data = "Minted " .. qty_display .. " " .. Ticker .. ". Total supply now: " .. 
                       string.format("%." .. Denomination .. "f", TotalMinted / 10^Denomination)
            })
        else
            ao.send({
                Target = msg.From,
                Data = "Minting failed: Only the owner (" .. Owner .. ") can mint " .. Ticker .. " tokens!"
            })
        end
    end
)
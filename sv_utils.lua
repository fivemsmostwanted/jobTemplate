RegisterNetEvent("job_template:initializeFramework", function()
    print("[INFO] Server-side initialization started.")
    -- meh
end)

RegisterNetEvent("AddItem:Ox", function(item, count)
    local playerId = source
    local invId = "player_" .. playerId

    if exports.ox_inventory:CanCarryItem(invId, item, count) then
        local success, response = exports.ox_inventory:AddItem(invId, item, count)

        if not success then
            print("[ERROR] Failed to add item to inventory: " .. response)
            return
        end
        print("[INFO] Successfully added " .. count .. " " .. item .. " to player inventory.")
    else
        print("[ERROR] Player cannot carry the item.")
    end
end)

RegisterNetEvent("RemoveItem:Ox", function(item, count)
    local playerId = source
    local invId = "player_" .. playerId 
    local success, response = exports.ox_inventory:RemoveItem(invId, item, count)

    if not success then
        print("[ERROR] Failed to remove item from inventory: " .. response)
        return
    end
    print("[INFO] Successfully removed " .. count .. " " .. item .. " from player inventory.")
end)


RegisterNetEvent("AddItem:Qb", function(item, count)
    local playerId = source
    local canAdd, reason = exports['qb-inventory']:CanAddItem(playerId, item, count)

    if canAdd then
        local success = exports['qb-inventory']:AddItem(playerId, item, count, false, false, 'Added item')

        if success then
            print("[INFO] Successfully added " .. count .. " " .. item .. " to player inventory.")
        else
            print("[ERROR] Failed to add " .. count .. " " .. item .. " to inventory.")
        end
    else
        print("[ERROR] Cannot add " .. count .. " of item " .. item .. ". Reason: " .. reason)
    end
end)

RegisterNetEvent("RemoveItem:Qb", function(item, count)
    local playerId = source
    local success = exports['qb-inventory']:RemoveItem(playerId, item, count, false, 'Removed item')

    if not success then
        print("[ERROR] Failed to remove " .. count .. " of " .. item .. " from inventory.")
        return
    end
    print("[INFO] Successfully removed " .. count .. " " .. item .. " from player inventory.")
end)
local inventorySystem

RegisterNetEvent("job_template:inventoryReady", function(detectedInventory)
    inventorySystem = detectedInventory

    if inventorySystem == "ox_inventory" then
        print("[INFO] Using ox_inventory.")
    elseif inventorySystem == "qb-inventory" then
        print("[INFO] Using qb-inventory.")
    else
        inventorySystem = nil
        print("[ERROR] Unsupported or no inventory system detected. Check your configuration.")
    end
end)

--- Adds an item to the player's inventory.
--- @param item string The item to add.
--- @param count number The quantity of the item to add.
function AddItemToInventory(item, count)
    if inventorySystem == "ox_inventory" then
        TriggerServerEvent("ox_inventory:addItem", item, count)
    elseif inventorySystem == "qb-inventory" then
        TriggerServerEvent("inventory:server:AddItem", item, count)
    else
        print("[ERROR] No inventory system active. Cannot add items.")
    end
end

--- Removes an item from the player's inventory.
--- @param item string The item to remove.
--- @param count number The quantity of the item to remove.
function RemoveItemFromInventory(item, count)
    if inventorySystem == "ox_inventory" then
        TriggerServerEvent("ox_inventory:removeItem", item, count)
    elseif inventorySystem == "qb-inventory" then
        TriggerServerEvent("inventory:server:RemoveItem", item, count)
    else
        print("[ERROR] No inventory system active. Cannot remove items.")
    end
end


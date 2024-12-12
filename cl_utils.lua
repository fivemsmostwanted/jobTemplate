local function detectFramework()
    if GetResourceState("qb-core") == "started" then
        return "qb-core"
    end
    if GetResourceState("es_extended") == "started" then
        return "esx"
    end
    return nil
end

local function detectInventory()
    if GetResourceState("ox_inventory") == "started" and exports["ox_inventory"] then
        return "ox_inventory"
    end
    if GetResourceState("qb-inventory") == "started" and exports["qb-inventory"] then
        return "qb-inventory"
    end
    return nil
end

local function detectInteract()
    if GetResourceState("ox_target") == "started" and exports["ox_target"] then
        return "ox_target"
    end
    if GetResourceState("qb-target") == "started" and exports["qb-target"] then
        return "qb-target"
    end
    return nil
end

local function initializeDetection()
    local framework = Config.Utility.framework == "auto" and detectFramework() or Config.Utility.framework
    local inventory = Config.Utility.inventory == "auto" and detectInventory() or Config.Utility.inventory
    local interact = Config.Utility.interact == "auto" and detectInteract() or Config.Utility.interact

    if not framework then
        print("[ERROR] No framework detected. Ensure qb-core or es_extended is installed and running.")
    else
        print("[INFO] Detected Framework: " .. framework)
        TriggerEvent("job_template:frameworkReady", framework)
    end

    if not inventory then
        print("[ERROR] No inventory system detected. Ensure ox_inventory or qb-inventory is installed and running.")
    else
        print("[INFO] Detected Inventory System: " .. inventory)
        TriggerEvent("job_template:inventoryReady", inventory)
    end

    if not interact then
        print("[ERROR] No interaction system detected. Ensure ox_target or qb-target is installed and running.")
    else
        print("[INFO] Detected Interaction System: " .. interact)
        TriggerEvent("job_template:interactReady", interact)
    end
end

CreateThread(function()
    local signs = {
        { model = 'prop_sign_road_01a', event = "qb-signrobbery:client:StopSign" },
        { model = 'prop_sign_road_05a', event = "qb-signrobbery:client:WalkingManSign" },
        { model = 'prop_sign_road_03e', event = "qb-signrobbery:client:DontBlockIntersectionSign" },
        { model = 'prop_sign_road_03m', event = "qb-signrobbery:client:UTurnSign" },
        { model = 'prop_sign_road_04a', event = "qb-signrobbery:client:NoParkingSign" },
        { model = 'prop_sign_road_05e', event = "qb-signrobbery:client:LeftTurnSign" },
        { model = 'prop_sign_road_05f', event = "qb-signrobbery:client:RightTurnSign" },
        { model = 'prop_sign_road_restriction_10', event = "qb-signrobbery:client:NoTrespassingSign" },
        { model = 'prop_sign_road_02a', event = "qb-signrobbery:client:YieldSign" }
    }

    for _, sign in ipairs(signs) do
        AddModelTarget(sign.model, {
            options = {
                {
                    type = 'client',
                    event = sign.event,
                    icon = 'fas fa-user-secret',
                    label = 'Steal Sign',
                }
            },
            distance = 4.0
        })
    end
end)

-- Command to test the menu (ox_lib)
RegisterCommand('testcontext', function()
    local testMenu = {}

    testMenu[#testMenu + 1] = {
        title = 'Option 1',
        description = 'This is option 1',
        icon = 'check',
        onSelect = function()
            print("Option 1 selected!")
        end
    }

    testMenu[#testMenu + 1] = {
        title = 'Option 2',
        description = 'This is option 2',
        icon = 'times',
        onSelect = function()
            print("Option 2 selected!")
        end
    }

    local menuData = {
        id = 'test_menu',  -- Unique menu ID
        title = 'Test Menu',  -- Menu Title
        position = 'top-right',  -- Position of the menu
        options = testMenu  -- Dynamic options
    }

    OpenMenu(menuData)
end)

AddEventHandler("onClientResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        initializeDetection()
    end
end)

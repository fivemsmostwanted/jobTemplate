local menuSystem

RegisterNetEvent("job_template:frameworkReady", function(detectedFramework)
    menuSystem = detectedFramework
    print("[DEBUG] Framework detected: " .. tostring(menuSystem))

    if exports.ox_lib then
        print("[INFO] Using ox_lib for menus.")
        menuSystem = "ox_lib"
    elseif menuSystem == "qb-core" then
        if exports["qb-menu"] then
            print("[INFO] Using qb-menu for menus.")
        else
            print("[ERROR] qb-menu is not available. Falling back to ox_lib.")
            menuSystem = "ox_lib"
        end
    else
        menuSystem = nil
        print("[ERROR] Unsupported or no menu system detected. Check your configuration.")
    end
end)

-- No idea if this works for qb-menu
function OpenMenu(menuData)
    if exports.ox_lib then
        exports.ox_lib:registerContext({
            id = menuData.id,           -- Unique menu ID
            title = menuData.title,     -- Menu Title
            position = menuData.position,  -- Position of the menu
            options = menuData.options  -- Menu options
        })
        exports.ox_lib:showContext(menuData.id)
        print("[DEBUG] Showing menu with ox_lib.")
        return
    end

    if exports["qb-menu"] then
        exports["qb-menu"]:openMenu(menuData.options)
        print("[DEBUG] Showing menu with qb-menu.")
        return
    end

    print("[ERROR] No menu system available to open the menu.")
end

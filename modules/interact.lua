local interactSystem

RegisterNetEvent("job_template:interactReady", function(detectedInteract)
    interactSystem = detectedInteract

    if interactSystem == "ox_target" then
        print("[INFO] Using ox_target for interactions.")
    elseif interactSystem == "qb-target" then
        print("[INFO] Using qb-target for interactions.")
    else
        interactSystem = nil
        print("[ERROR] Unsupported or no interaction system detected. Check your configuration.")
    end
end)

--- Adds a model target to either ox_target or qb-target.
--- @param model string|table The model(s) to make targetable.
--- @param options table The options for target interactions.
--- If using ox_target, options should include `options` as a sub-table.
--- If using qb-target, options can directly be passed as-is.
function AddModelTarget(model, options)
    if interactSystem == "ox_target" then
        if type(options) == "table" and options.options then
            exports.ox_target:addModel(model, options.options)
        else
            exports.ox_target:addModel(model, options)
        end
    elseif interactSystem == "qb-target" then
        exports['qb-target']:AddTargetModel(model, options)
    end
end

--- Removes model target options from either ox_target or qb-target.
--- @param model string|table The model(s) to remove target options from.
--- @param optionNames string|string[] The names of the options to remove.
function RemoveModelTarget(model, optionNames)
    if interactSystem == "ox_target" then
        exports.ox_target:removeModel(model, optionNames)
    elseif interactSystem == "qb-target" then
        exports['qb-target']:RemoveTargetModel(model, optionNames)
    end
end

--- Adds a box zone to either ox_target or qb-target.
--- @param name string A unique name for the box zone (for qb-target).
--- @param center vector3 The center coordinates of the box zone.
--- @param length number The length of the box zone.
--- @param width number The width of the box zone.
--- @param options table The configuration options for the box zone.
--- @param targetOptions table The target interaction options for the zone.
function AddBoxZone(name, center, length, width, options, targetOptions)
    if interactSystem == "ox_target" then
        exports.ox_target:addBoxZone({
            coords = center,
            size = {length, width},
            rotation = options.rotation or 0,
            debug = options.debug or false,
            options = targetOptions
        })
    elseif interactSystem == "qb-target" then
        exports['qb-target']:AddBoxZone(name, center, length, width, options, targetOptions)
    end
end
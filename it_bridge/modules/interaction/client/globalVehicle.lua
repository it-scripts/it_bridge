local globalVehicleTargets = {}

--- Add a global vehicle interaction.
--- @param options table Options for the global vehicle interaction.
--- @return table The names of the options.
function it.addGlobalVehicle(options)

    if it.interaction == Interactions.NONE then
        it.print.error("[addGlobalVehicle] - No interaction type set.")
        return {}
    end

    if it.interaction == Interactions.OX then
        local oxOptions = {}
        local optionNames = {}
        for _, optionData in pairs(options) do
            table.insert(oxOptions, {
                label = optionData.label,
                name = optionData.label,
                icon = optionData.icon,
                items = optionData.items,
                groups = optionData.groups,
                canInteract = function(entity, distance, _, _, _)
                    if optionData.canInteract then
                        return optionData.canInteract(entity, distance)
                    end
                end,
                onSelect = function(data)
                    optionData.onSelect(data.entity)
                end,
                distance = options.distance,
            })
            table.insert(optionNames, optionData.name)
        end
        exports.ox_target:addGlobalVehicle(oxOptions)
        return optionNames
    end

    if it.interaction == Interactions.QB then
        local qbOptions = {}
        local optionNames = {}
        for _, optionData in pairs(options) do
            table.insert(qbOptions, {
                label = optionData.label,
                icon = optionData.icon,
                item = optionData.items[1],
                job = optionData.job,
                canInteract = function(entity, distance)
                    if optionData.canInteract then
                        return optionData.canInteract(entity, distance, _)
                    end
                end,
                action = function(entity)
                    optionData.onSelect(entity)
                end,
                distance = options.distance,
            })
            table.insert(optionNames, optionData.label)
        end
        exports[Interactions.QB]:AddTargetModel({
            options = qbOptions,
            distance = options.distance,
        })
        return optionNames
    end

    it.print.error("[addGlobalVehicle] - Invalid interaction type.")
    return {}
end

--- Remove a global vehicle interaction.
--- @param options table Options for the global vehicle interaction.
function it.removeGlobalVehicle(options)

    if it.interaction == Interactions.NONE then
        it.print.error("[removeGlobalVehicle] - No interaction type set.")
        return
    end

    if it.interaction == Interactions.OX then
        exports.ox_target:removeGlobalVehicle(options)
    end

    if it.interaction == Interactions.QB then
        exports[Interactions.QB]:RemoveGlobalVehicle(options)
    end
end

exports("AddGlobalVehicle", function(options)
    local callerResource = GetInvokingResource()

    local optionNames = ExtractOptionNames(options)
    if #optionNames == 0 then
        it.print.error("[AddGlobalVehicle] - No options found.")
        return
    end

    for _, optionName in pairs(optionNames) do
        if globalVehicleTargets[callerResource] and globalVehicleTargets[callerResource][optionName] then
            it.print.error("[AddGlobalVehicle] - GlobalVehicle option", optionName, "already exists in resource", callerResource)
            return
        end
    end

    local addedOptions = it.addGlobalVehicle(options)
    globalVehicleTargets[callerResource] = globalVehicleTargets[callerResource] or {}
    for _, optionName in pairs(addedOptions) do
        globalVehicleTargets[callerResource][optionName] = true
    end
end)

exports("RemoveGlobalVehicle", function(options)
    local callerResource = GetInvokingResource()

    if type(options) == "string" then
        options = {options}
    end

    for _, optionName in pairs(options) do
        if not globalVehicleTargets[callerResource] or not globalVehicleTargets[callerResource][optionName] then
            it.print.error("[RemoveGlobalVehicle] - GlobalVehicle option", optionName, "does not exist in resource", callerResource)
            return
        end
    end

    for _, optionName in pairs(options) do
        it.removeGlobalVehicle(optionName)
        globalVehicleTargets[callerResource][optionName] = nil
    end
end)
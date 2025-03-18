local globalePedTargets = {}

function it.addGlobalPed(options)
    if it.interaction == Interactions.NONE then
        it.print.error("No interaction type set.")
        return
    end

    if it.interaction == Interactions.OX then
        local oxOptions = {}
        local optionNames = {}
        for _, optionData in pairs(options) do
            table.insert(oxOptions, {
                label = optionData.label,
                name = optionData.name,
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
        exports.ox_target:addGlobalPed(oxOptions)
        return optionNames
    end

    if it.interaction == Interactions.QB then
        local qbOptions = {}
        local optionNames = {}
        for _, optionData in pairs(options) do
            table.insert(qbOptions, {
                label = optionData.label,
                icon = optionData.icon,
                item = optionData.items and optionData.items[1] or nil,
                job = optionData.job,
                canInteract = function(entity, distance)
                    if optionData.canInteract then
                        return optionData.canInteract(entity, distance, _)
                    end
                end,
                action = function(entity)
                    optionData.onSelect(entity)
                end,
            })
            table.insert(optionNames, optionData.label)
        end
        exports[Interactions.QB]:AddGlobalPed({
            options = qbOptions,
            distance = options.distance,
        })
        return optionNames
    end
end

function it.removeGlobalPed(options)

    if it.interaction == Interactions.NONE then
        it.print.error("[removeGlobalPed] - No interaction type set.")
        return
    end

    if it.interaction == Interactions.OX then
        exports.ox_target:removeGlobalPed(options)
    end

    if it.interaction == Interactions.QB then
        exports[Interactions.QB]:RemoveGlobalPed(options)
    end
end

exports("AddGlobalPed", function(options)
    local callerResource = GetInvokingResource()

    local optionNames = ExtractOptionNames(options)
    if #optionNames == 0 then
        it.print.error("[AddGlobalPed] - No options found.")
        return
    end

    for _, optionName in pairs(optionNames) do
        if globalePedTargets[optionName] and globalePedTargets[optionName][optionName] then
            if Config.Debug then
                it.print.warn("[AddGlobalPed] - GlobalPed option", optionName, "already exists in resource", callerResource)
                it.print.debug("If you want to hide this message set Config.Debug to false.")
            end
            return nil
        end
    end

    local addedOptions = it.addGlobalPed(options)
    if addedOptions then
        globalePedTargets[callerResource] = globalePedTargets[callerResource] or {}
        for _, optionName in pairs(addedOptions) do
            globalePedTargets[callerResource][optionName] = true
        end
    end

    return addedOptions
end)

exports("RemoveGlobalPed", function(options)
    local callerResource = GetInvokingResource()

    if type(options) == "string" then
        options = {options}
    end

    for _, optionName in pairs(options) do
        if not globalePedTargets[callerResource] or not globalePedTargets[callerResource][optionName] then
            if Config.Debug then
                it.print.warn("[RemoveGlobalPed] - GlobalPed option", optionName, "does not exist in resource", callerResource)
                it.print.debug("If you want to hide this message set Config.Debug to false.")
            end
            return false
        end
    end

    for _, optionName in pairs(options) do
        it.removeGlobalPed(optionName)
        globalePedTargets[callerResource][optionName] = nil
    end
    return true
end)
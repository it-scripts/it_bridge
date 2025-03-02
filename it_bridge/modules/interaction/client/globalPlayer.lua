local globalPlayerTargets = {}

--- Add a global player interaction.
---@param options table Options for the global player interaction.
---@return table The names of the options.
function it.addGlobalPlayer(options)

    if it.interaction == Interactions.NONE then
        it.print.error("[addGlobalPlayer] - No interaction type set.")
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
        exports.ox_target:addGlobalPlayer(oxOptions)
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
                action = function(entity)
                    optionData.onInteract(entity)
                end,
                canInteract = function(entity, distance, _)
                    if optionData.canInteract then
                        return optionData.canInteract(entity, distance)
                    end
                end,
            })
            table.insert(optionNames, optionData.label)
        end
        exports[Interactions.QB]:AddGlobalPlayer({
            options = qbOptions,
            distance = options.distance,
        })
        return optionNames
    end

    it.print.error("[addGlobalPlayer] - Unable to add global player interaction.")
    return {}
end

--- Remove a global player interaction.
--- @param options table | string  Options for the global player interaction.
function it.removeGlobalPlayer(options)

    if it.interaction == Interactions.NONE then
        it.print.error("[addGlobalPlayer] - No interaction type set.")
        return
    end

    if it.interaction == Interactions.OX then
        exports.ox_target:RemoveGlobalPlayer(options)
    end

    if it.interaction == Interactions.QB then
        exports[Interactions.QB]:RemoveGlobalPlayer(options)
    end
end


exports('AddGlobalPlayer', function(options)
    local callerResource = GetInvokingResource()

    local optionNames = ExtractOptionNames(options)
    for _, optionName in pairs(optionNames) do
        if globalPlayerTargets[callerResource] and globalPlayerTargets[callerResource][optionName] then
            lib.print.warn("[addGlobalPlayer] - GlobalPlayer option", optionName, "already exists for resource", callerResource)
            return
        end
    end

    local addedOptions = it.addGlobalPlayer(options)
    globalPlayerTargets[callerResource] = globalPlayerTargets[callerResource] or {}
    for _, optionName in pairs(addedOptions) do
        globalPlayerTargets[callerResource][optionName] = true
    end
end)

exports('RemoveGlobalPlayer', function(callerResource, options)
    if type(options) == "string" then
        options = {options}
    end

    for _, optionName in pairs(options) do
        if not globalPlayerTargets[callerResource] or not globalPlayerTargets[callerResource][optionName] then
            lib.print.warn("[addGlobalPlayer] - GlobalPlayer option", optionName, "does not exist for resource", callerResource)
            return
        end
    end

    for _, optionName in pairs(options) do
        it.removeGlobalPlayer(optionName)
        globalPlayerTargets[callerResource][optionName] = nil
    end
end)
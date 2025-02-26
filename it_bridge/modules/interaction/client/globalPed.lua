local globalePeds = {}

function it.createGlobalPed(options)
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
                canInteract = function(entity, distance, coords, name, bone)
                    if optionData.canOxInteract then
                        return optionData.canOxInteract(entity, distance, coords, name, bone)
                    end
                end,
                onSelect = function(data)
                    optionData.onOxSelect(data)
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
                item = optionData.items[1],
                job = optionData.job,
                action = function(entity)
                    optionData.onQbInteract(entity)
                end,
                canInteract = function(entity, distance, data)
                    if optionData.canQbInteract then
                        return optionData.canQbInteract(entity, distance, data)
                    end
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

function it.removeGlobalPed(callerResource)
    if it.interaction == Interactions.OX then
        local removeOptions = globalePeds[callerResource]
        for _, option in pairs(removeOptions) do
            exports.ox_target:removeGlobalPed(option)
        end
    end

    if it.interaction == Interactions.QB then
        local removeOptions = globalePeds[callerResource]
        for _, option in pairs(removeOptions) do
            exports.ox_target:removeGlobalPed(option)
        end
    end
end

exports("CreateGlobalPed", function(options)
    local callerResource = GetInvokingResource()

    -- Check of targetModel already exists for this resource
    if globalePeds[callerResource] then
        it.print.warn("TargetModel already exists for resource: " .. callerResource)
        return
    end

    local target = it.createGlobalPed(options)
    globalePeds[callerResource] = target
    return target
end)

exports("RemoveGlobalPed", function()
    local callerResource = GetInvokingResource()

    if not globalePeds[callerResource] then
        it.print.warn("TargetModel does not exist for resource: " .. callerResource)
        return
    end

    it.removeGlobalPed(callerResource)
    globalePeds[callerResource] = nil
end)
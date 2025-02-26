local targetModels = {}

function it.createTargetModel(model, options)

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
        exports.ox_target:addModel(model, oxOptions)
        return optionNames
    end

    if it.interaction == Interactions.QB then
        local qbOptions = {}
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
        end
        exports[Interactions.QB]:AddTargetModel(model, {
            options = qbOptions,
            distance = options.distance,
        })
        return model
    end
end

function it.removeTargetModel(model, callerResource)
    if it.interaction == Interactions.OX then
        local removeOptions = targetModels[callerResource].model
        for _, option in pairs(removeOptions) do
            exports.ox_target:removeModel(model, option)
        end
    end

    if it.interaction == Interactions.QB then
        exports[Interactions.QB]:RemoveTargetModel(model)
    end
end

exports("CreateTargetModel", function(model, targetData)
    local callerResource = GetInvokingResource()

    -- Check of targetModel already exists for this resource
    if targetModels[callerResource].model then
        it.print.warn("TargetModel already exists for resource: " .. callerResource)
        return
    end

    local target = it.createTargetModel(model, targetData)
    targetModels[callerResource].model = target
    return target
end)

exports("RemoveTargetModel", function(model)
    local callerResource = GetInvokingResource()

    if not targetModels[callerResource].model then
        it.print.warn("TargetModel does not exist for resource: " .. callerResource)
        return
    end

    it.removeTargetModel(model, callerResource)
    targetModels[callerResource].model = nil
end)
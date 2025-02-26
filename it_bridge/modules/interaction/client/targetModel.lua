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
        local optionLabels = {}
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
            table.insert(optionLabels, optionData.label)
        end
        exports[Interactions.QB]:AddTargetModel(model, {
            options = qbOptions,
            distance = options.distance,
        })
        return optionLabels
    end
end

function it.removeTargetModel(targetModel, callerResource)
    if it.interaction == Interactions.OX then
        local removeOptions = targetModels[callerResource][targetModel]
        for _, option in pairs(removeOptions) do
            exports.ox_target:removeModel(targetModel, option)
        end
    end

    if it.interaction == Interactions.QB then
        local removeOptions = targetModels[callerResource][targetModel]
        for _, option in pairs(removeOptions) do
            exports[Interactions.QB]:RemoveTargetModel(targetModel, option)
        end
    end
end

exports("CreateTargetModel", function(targetModel, targetData)
    local callerResource = GetInvokingResource()

    -- Check of targetModel already exists for this resource
    if targetModels[callerResource] and targetModels[callerResource].model then
        it.print.warn("TargetModel already exists for resource: " .. callerResource)
        return
    end

    local target = it.createTargetModel(targetModel, targetData)
    targetModels[callerResource] = targetModels[callerResource] or {}
    targetModels[callerResource][targetModel] = target
    return target
end)

exports("RemoveTargetModel", function(targetModel)
    local callerResource = GetInvokingResource()

    if not targetModels[callerResource] or not targetModels[callerResource][targetModel] then
        it.print.warn("TargetModel does not exist for resource: " .. callerResource)
        return
    end

    it.removeTargetModel(targetModel, callerResource)
    targetModels[callerResource].model = nil
end)

exports('RemoveTargetModelOption', function(targetModel, targetOption)
    local callerResource = GetInvokingResource()

    if not targetModels[callerResource] or not targetModels[callerResource][targetModel] then
        it.print.warn("TargetModel does not exist for resource: " .. callerResource)
        return
    end

    if it.interaction == Interactions.OX then
        for _, option in pairs(targetModels[callerResource][targetModel]) do
            if option == targetOption then
                table.remove(targetModels[callerResource][targetModel], targetOption)
                exports.ox_target:removeModel(targetModel, targetOption)
                return
            end
            it.print.warn("Option does not exist for targetModel: " .. targetModel)
        end
    end

    if it.interaction == Interactions.QB then
        for _, option in pairs(targetModels[callerResource][targetModel]) do
            if option == targetOption then
                table.remove(targetModels[callerResource][targetModel], targetOption)
                exports[Interactions.QB]:RemoveTargetModel(targetModel, targetOption)
                return
            end
            it.print.warn("Option does not exist for targetModel: " .. targetModel)
        end
    end
end)
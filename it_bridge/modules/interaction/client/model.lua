local modelTargets = {}


function it.addTargetModel(models, options)

    if it.interaction == Interactions.NONE then
        it.print.error("[addModel] - No interaction type set.")
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
        exports.ox_target:addModel(models, oxOptions)
        return optionNames
    end

    if it.interaction == Interactions.QB then
        local qbOptions = {}
        local optionLabels = {}
        for _, optionData in pairs(options) do
            table.insert(qbOptions, {
                label = optionData.label,
                icon = optionData.icon,
                item = optionData.items and optionData.items[1] or nil,
                job = optionData.job,
                action = function(entity)
                    optionData.onSelect(entity)
                end,
                canInteract = function(entity, distance, _)
                    if optionData.canInteract then
                        return optionData.canInteract(entity, distance)
                    end
                end,
            })
            table.insert(optionLabels, optionData.label)
        end
        exports[Interactions.QB]:AddTargetModel(models, {
            options = qbOptions,
            distance = options.distance,
        })
        return optionLabels
    end
end

function it.removeTargetModel(models, options)

    if it.interaction == Interactions.NONE then
        it.print.error("[removeModel] - No interaction type set.")
        return
    end

    if it.interaction == Interactions.OX then
        exports.ox_target:removeModel(models, options)
    end

    if it.interaction == Interactions.QB then
        exports[Interactions.QB]:RemoveTargetModel(models)
    end
end

exports('AddTargetModel', function(models, options)
    local callerResource = GetInvokingResource()

    local optionNames = ExtractOptionNames(options)
    if #optionNames == 0 then
        it.print.error("[AddTargetModel] - No options found.")
        return
    end

    if type(models) == 'string' then
        models = {models}
    end

    for _, model in pairs(models) do
        for _, optionName in pairs(optionNames) do
            if modelTargets[callerResource] and modelTargets[callerResource][model] and modelTargets[callerResource][model][optionName] then
                if Config.Debug then
                    it.print.warn("[AddTargetModel] - Model option", optionName, "already exists for model", model, "in resource", callerResource)
                    it.print.debug("If you want to hide this message set Config.Debug to false.")
                end
                return nil
            end
        end
    end

    local addedOptions = it.addTargetModel(models, options)
    modelTargets[callerResource] = modelTargets[callerResource] or {}
    for _, model in pairs(models) do
        modelTargets[callerResource][model] = modelTargets[callerResource][model] or {}
        for _, optionName in pairs(addedOptions) do
            modelTargets[callerResource][model][optionName] = true
        end
    end

    return addedOptions
end)

exports('RemoveTargetModel', function(models, options)
    local callerResource = GetInvokingResource()

    if type(models) == 'string' then
        models = {models}
    end

    if type(options) == 'string' then
        options = {options}
    end

    for _, model in pairs(models) do
        for _, optionName in pairs(options) do
            if not modelTargets[callerResource] or not modelTargets[callerResource][model] or not modelTargets[callerResource][model][optionName] then
                if Config.Debug then
                    it.print.warn("[RemoveTargetModel] - Model option", optionName, "does not exist for model", model, "in resource", callerResource)
                    it.print.debug("If you want to hide this message set Config.Debug to false.")
                end
                return false
            end
        end
    end

    for _, model in pairs(models) do
        it.removeTargetModel(model, options)
        for _, optionName in pairs(options) do
            modelTargets[callerResource][model][optionName] = nil
        end
    end
    return true
end)

local entityTargets = {}

function it.addTargetEntity(entities, options)
    if it.interaction == Interactions.NONE then
        it.print.error("[addEntity] - No interaction type set.")
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
        exports.ox_target:addEntity(entities, oxOptions)
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
        exports[Interactions.QB]:AddTargetEntity(entities, {
            options = qbOptions,
            distance = options.distance,
        })
        return optionLabels
    end
end

function it.removeTargetEntity(entities, options)
    if it.interaction == Interactions.NONE then
        it.print.error("[removeEntity] - No interaction type set.")
        return
    end

    if it.interaction == Interactions.OX then
        exports.ox_target:removeEntity(entities, options)
    end

    if it.interaction == Interactions.QB then
        exports[Interactions.QB]:RemoveTargetEntity(entities)
    end
end

exports('AddTargetEntity', function(entities, options)
    local callerResource = GetInvokingResource()
    local optionNames = ExtractOptionNames(options)

    if #optionNames == 0 then
        it.print.error("[AddTargetEntity] - No options found.")
        return
    end

    if type(entities) == 'number' then
        entities = {entities}
    end

    for _, entity in pairs(entities) do
        for _, optionName in pairs(optionNames) do
            if entityTargets[callerResource]
                and entityTargets[callerResource][entity]
                and entityTargets[callerResource][entity][optionName] then
                it.print.error("[AddTargetEntity] - Entity option", optionName, "already exists for entity", entity, "in resource", callerResource)
                return nil
            end
        end
    end

    local addedOptions = it.addTargetEntity(entities, options)
    entityTargets[callerResource] = entityTargets[callerResource] or {}
    for _, entity in pairs(entities) do
        entityTargets[callerResource][entity] = entityTargets[callerResource][entity] or {}
        for _, optionName in pairs(addedOptions) do
            entityTargets[callerResource][entity][optionName] = true
        end
    end

    return addedOptions
end)

exports('RemoveTargetEntity', function(entities, options)
    local callerResource = GetInvokingResource()

    if type(entities) == 'number' then
        entities = {entities}
    end

    if type(options) == 'string' then
        options = {options}
    end

    for _, entity in pairs(entities) do
        for _, optionName in pairs(options) do
            if not entityTargets[callerResource]
                or not entityTargets[callerResource][entity]
                or not entityTargets[callerResource][entity][optionName] then
                it.print.error("[RemoveTargetEntity] - Entity option", optionName, "does not exist for entity", entity, "in resource", callerResource)
                return false
            end
        end
    end

    for _, entity in pairs(entities) do
        it.removeTargetEntity(entity, options)
        for _, optionName in pairs(options) do
            entityTargets[callerResource][entity][optionName] = nil
        end
    end
    return true
end)
function it.createBoxZone(targetData, options)
    if it.interaction == Interactions.OX then
        local oxOptions = {}
        for _, optionData in pairs(options) do
            table.insert(oxOptions, {
                label = optionData.label,
                icon = optionData.icon,
                onSelect = optionData.onSelect,
                distance = optionData.distance,

                groups = optionData.groups or nil,
                items = optionData.items or nil,
            })
        end

        local boxZone = exports.ox_target:addBoxZone({
            coords = vector3(targetData.coords.x, targetData.coords.y, targetData.coords.z + (targetData.size.z / 2)),
            size = targetData.size,
            rotation = (targetData.rotation + targetData.zoneRotation),
            debug = targetData.debug,
            drawSprite = targetData.drawSprite,
            options = oxOptions,
            distance = targetData.interactDistance,
        })
        return boxZone
    end

    if it.interaction == Interactions.QB then
        local qbOptions = {}
        for _, optionData in pairs(options) do
            table.insert(qbOptions, {
                label = optionData.label,
                icon = optionData.icon,
                action = optionData.action,
                job = optionData.job,
                item = optionData.item,
            })
        end

        local boxZone = exports['qb-target']:AddBoxZone(targetData.id, vector3(targetData.coords.x, targetData.coords.y, targetData.coords.z), targetData.size.x, targetData.size.y, {
            name = targetData.name,
            heading = targetData.rotation,
            debugPoly = targetData.debug,
            minZ = targetData.coords.z - targetData.size.z / 2,
            maxZ = targetData.coords.z + targetData.size.z / 2,
        }, {
            options = qbOptions,
            distance = targetData.interactDistance,
        })
        return boxZone
    end
end

return it.createBoxZone
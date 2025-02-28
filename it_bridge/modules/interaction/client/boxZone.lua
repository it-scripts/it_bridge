local boxZones = {}


function it.createBoxZone(options, boxData)

    if it.interaction == Interactions.NONE then
        it.print.error("No interaction type set.")
        return
    end

    if it.interaction == Interactions.OX then

        local oxOptions = {}
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
        end
        local boxZone = exports.ox_target:addBoxZone({
            coords = boxData.coords,
            size = boxData.size,
            rotation = boxData.rotation,
            debug = boxData.debug,
            drawSprite = boxData.drawSprite,
            options = oxOptions,
            distance = options.distance,
        })
        return boxZone
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
        exports[Interactions.QB]:AddBoxZone(boxData.id, boxData.coords, boxData.size.x, boxData.size.y, {
            name = boxData.id,
            heading = boxData.rotation,
            debugPoly = boxData.debug,
            maxZ = boxData.maxZ,
            minZ = boxData.minZ,
        }, {
            options = qbOptions,
            distance = options.distance,
        })
        return boxData.id
    end
end


function it.removeBoxZone(zoneId)

    if it.interaction == Interactions.OX then
        exports.ox_target:removeZone(zoneId)
    end

    if it.interaction == Interactions.QB then
        exports[Interactions.QB]:RemoveZone(zoneId)
    end

end

exports("CreateBoxZone", function(options, boxData)
    local callerResource = GetInvokingResource()

    -- Check of boxZone already exists for this resource
    if boxZones[callerResource].boxData.id then
        it.print.warn("BoxZone already exists for resource: " .. callerResource)
        return
    end

    local zone = it.createBoxZone(options, boxData)
    boxZones[callerResource].zoneData.id = zone
    return zone
end)

exports("RemoveBoxZone", function(boxId)
    local callerResource = GetInvokingResource()

    -- Check if boxZone exists
    if not boxZones[callerResource].boxId then
        it.print.warn("BoxZone does not exist for resource: " .. callerResource)
        return
    end

    it.removeBoxZone(boxId)
    boxZones[callerResource].zoneData.id = nil
end)
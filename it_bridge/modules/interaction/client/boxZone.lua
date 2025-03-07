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
                item = optionData.items and optionData.items[1] or nil,
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
        end

        local boxName = boxData.id or math.random(10000, 99999)

        exports[Interactions.QB]:AddBoxZone(boxData.id, boxData.coords, boxData.size.x, boxData.size.y, {
            name = boxName,
            heading = boxData.rotation,
            debugPoly = boxData.debug,
            maxZ = boxData.maxZ,
            minZ = boxData.minZ,
        }, {
            options = qbOptions,
            distance = options.distance,
        })
        return boxName
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

exports("CreateBoxZone", function(boxData, options)
    local callerResource = GetInvokingResource()

    local zone = it.createBoxZone(options, boxData)
    if not boxZones[callerResource] then
        boxZones[callerResource] = {}
    end
    boxZones[callerResource][zone] = true
    return zone
end)

exports("RemoveBoxZone", function(boxId)
    local callerResource = GetInvokingResource()

    -- Check if boxZone exists
    if not boxZones[callerResource] 
        or not boxZones[callerResource][boxId] then
        it.print.error("[RemoveBoxZone] - BoxZone with id:", boxId, "does not exist for resource: ", callerResource)
        return false
    end

    it.removeBoxZone(boxId)
    boxZones[callerResource][boxId] = nil
    return true
end)
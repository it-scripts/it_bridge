function it.getPlayerByCitizenId(citizenId)
    if it.framework == Framework.ESX then
        local xPlayer = CoreObject.GetPlayerFromIdentifier(citizenId)
        if xPlayer then
            return xPlayer
        end
    end

    if it.framework == Framework.QBCore then
        local player = exports['qb-core']:GetPlayerByCitizenId(citizenId)
        if player then
            return player
        end
    end

    if it.framework == Framework.QBOX then
        local player = exports.qbx_core:GetPlayerByCitizenId(citizenId)
        if player then
            return player
        end
    end

    if it.framework == Framework.NDCore then
        local players = it.getPlayers()
        if players then
            for _, player in ipairs(players) do
                if player.getData('identifier') == citizenId then
                    return player
                end
            end
        end
    end

    it.print.error("Failed to get player from citizen id: " .. citizenId)
    return nil
end

exports('getPlayerByCitizenId', function(citizenId)
    return it.getPlayerByCitizenId(citizenId)
end)
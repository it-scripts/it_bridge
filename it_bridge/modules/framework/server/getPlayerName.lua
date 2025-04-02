function it.getPlayerName(source)

    local player = it.getPlayer(source)
    if not player then
        it.print.error("Failed to get player name: " .. player)
        return
    end

    if it.framework == Framework.ESX then
        local playerName = player.getName()
        if playerName then
            return playerName
        end
    end

    if it.framework == Framework.QBCore then
        local playerName = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
        if playerName then
            return playerName
        end
    end

    if it.framework == Framework.QBOX then
        local playerName = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
        if playerName then
            return playerName
        end
    end

    if it.framework == Framework.NDCore then
        local playerName = player.getData('firstname') .. ' ' .. player.getData('lastname')
        if playerName then
            return playerName
        end
    end

    it.print.error("Failed to get player name from player: " .. player)
    return nil
end

lib.callback.register('it_bridge:callback:getPlayerName', function(source)
    return it.getPlayerName(source)
end)

exports('GetPlayerName', function(player)
    return it.getPlayerName(player)
end)
function it.getCitizenId(source)
    local Player = it.getPlayer(source)

    if not Player then
        it.print.error("Failed to get player from source: " .. source)
        return
    end

    if it.framework == Framework.ESX then
        local citizenId = Player.getIdentifier()
        if citizenId then
            return citizenId
        end
    end

    if it.framework == Framework.QBCore then
        local citizenId = Player.PlayerData.citizenid
        if citizenId then
            return citizenId
        end
    end

    if it.framework == Framework.QBOX then
        local citizenId = Player.PlayerData.citizenid
        if citizenId then
            return citizenId
        end
    end

    if it.framework == Framework.NDCore then
        local citizenId = Player.getData('identifier')
        if citizenId then
            return citizenId
        end
    end

    it.print.error("Failed to get citizen id from player: " .. source)
    return nil
end

exports('GetCitizenId', function(source)
    return it.getCitizenId(source)
end)
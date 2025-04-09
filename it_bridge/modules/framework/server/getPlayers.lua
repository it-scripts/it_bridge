--- Get all players from the server
---@return table | nil players players object
function it.getPlayers()

    if it.framework == Framework.ESX then
        local players = CoreObject.GetPlayers()
        if players then
            return players
        end
    end

    if it.framework == Framework.QBCore then
        local players = CoreObject.Functions.GetPlayers()
        if players then
            return players
        end
    end

    if it.framework == Framework.QBOX then
        local players = exports.qbx_core:GetPlayersData()
        if players then
            return players
        end
    end

    if it.framework == Framework.NDCore then
        local players = exports['ND_Core']:getPlayers()
        --local players = CoreObject.getPlayers()
        if players then
            return players
        end
    end

    it.print.error("Failed to get players")
    return nil
end

exports('GetPlayers', function()
    return it.getPlayers()
end)
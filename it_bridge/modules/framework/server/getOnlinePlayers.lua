---
---@return table | nil onlinePlayers 
function it.getOnlinePlayers()
    local onlinePlayerData = {}

    if it.framework == Framework.ESX then
        local onlinePlayersESX = CoreObject.GetExtendedPlayers()
        for _, player in pairs(onlinePlayersESX) do
            local currentPlayerData = it.getPlayerData(player.source)
            if currentPlayerData then
                table.insert(onlinePlayerData, currentPlayerData)
            end
        end
    elseif it.framework == Framework.QBCore then
        local onlinePlayersQBCore = CoreObject.Functions.GetQBPlayers()
        for playerId, _ in pairs(onlinePlayersQBCore) do
            local currentPlayerData = it.getPlayerData(playerId)
            if currentPlayerData then
                table.insert(onlinePlayerData, currentPlayerData)
            end
        end
    elseif it.framework == Framework.QBOX then
        local onlinePlayersQBOX = exports.qbx_core:GetQBPlayers()
        for playerId, _ in pairs(onlinePlayersQBOX) do
            local currentPlayerData = it.getPlayerData(playerId)
            if currentPlayerData then
                table.insert(onlinePlayerData, currentPlayerData)
            end
        end
    elseif it.framework == Framework.NDCore then
        local onlinePlayersNDCore =  exports["ND_Core"]:getPlayers()
        for playerId, _ in pairs(onlinePlayersNDCore) do
            local currentPlayerData = it.getPlayerData(playerId)
            if currentPlayerData then
                table.insert(onlinePlayerData, currentPlayerData)
            end
        end
    else
        it.print.error("Unsupported framework: " .. tostring(it.framework))
        return nil
    end

    return onlinePlayerData
end

exports('GetOnlinePlayers', function()
    return it.getOnlinePlayers()
end)
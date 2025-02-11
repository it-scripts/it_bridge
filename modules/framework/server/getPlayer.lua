--- Get player from source
---@param source number The player source
---@return table | nil playerData  player object
function it.getPlayer(source)

    if it.framework == Framework.ESX then
        local xPlayer = CoreObject.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer
        end
    end

    if it.framework == Framework.QBCore then
        local player = exports['qb-core']:GetPlayer(source)
        if player then
            return player
        end
    end

    if it.framework == Framework.QBOX then
        local player = exports.qbx_core:GetPlayer(source)
        if player then
            return player
        end
    end

    if it.framework == Framework.NDCore then
        local player = CoreObject.getPlayer(source)
        if player then
            return player
        end
    end

    it.print.error("Failed to get player from source: " .. source)
    return nil
end

return it.getPlayer
function it.removeMoney(source, moneyType, amount, reason)
    if not reason then reason = "Money removed by it_lib" end

    local Player = it.getPlayer(source)
    if not Player then
        it.print.error("Failed to get player from source: " .. source)
        return
    end

    if not MoneyTypes[moneyType] then
        it.print.error("Invalid money type: " .. moneyType)
        return
    end

    if it.framework == Framework.ESX then
        local moneyType = MoneyTypes[moneyType][Framework.ESX]
        local currentMoney = Player.getAccount(moneyType).money
        Player.removeAccountMoney(moneyType, amount)
        local newMoney = Player.getAccount(moneyType).money
        if currentMoney == newMoney then
            it.print.error("Failed to remove money from player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBCore then
        local moneyType = MoneyTypes[moneyType][Framework.QBCore]
        local success = Player.Functions.RemoveMoney(moneyType, amount)
        if not success then
            it.print.error("Failed to remove money from player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBOX then
        local moneyType = MoneyTypes[moneyType][Framework.QBOX]
        local success = exports.qbx_core:RemoveMoney(source, moneyType, amount, reason)
        if not success then
            it.print.error("Failed to remove money from player: " .. source)
            return false
        end
    end

    if it.framework == Framework.NDCore then
        local moneyType = MoneyTypes[moneyType][Framework.NDCore]
        local success = Player.removeMoney(moneyType, amount, reason)
        if not success then
            it.print.error("Failed to remove money from player: " .. source)
            return false
        end
    end

    return true
end

exports('removeMoney', it.removeMoney)
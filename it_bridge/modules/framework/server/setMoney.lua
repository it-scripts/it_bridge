function it.setMoney(source, moneyType, amount, reason)

    if not reason then reason = "Money added by it_bridge" end

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
        Player.setAccountMoney(moneyType, amount)
        local newMoney = Player.getAccount(moneyType).money
        if currentMoney == newMoney then
            it.print.error("Failed to set money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBCore then
        local moneyType = MoneyTypes[moneyType][Framework.QBCore]
        local success = Player.Functions.SetMoney(moneyType, amount)
        if not success then
            it.print.error("Failed to set money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBOX then
        local moneyType = MoneyTypes[moneyType][Framework.QBOX]
        local success = exports.qbx_core:SetMoney(source, moneyType, amount, reason)
        if not success then
            it.print.error("Failed to set money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.NDCore then
        lib.print.error("NDCore does not support setting money")
        return false
    end

    return true
end

exports('SetMoney', function(source, moneyType, amount, reason)
    return it.setMoney(source, moneyType, amount, reason)
end)
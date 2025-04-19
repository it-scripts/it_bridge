function it.addMoney(source, moneyType, amount, reason)
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
        Player.addAccountMoney(moneyType, amount)
        local newMoney = Player.getAccount(moneyType).money
        if currentMoney == newMoney then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBCore then
        local moneyType = MoneyTypes[moneyType][Framework.QBCore]
        local success = Player.Functions.AddMoney(moneyType, amount, reason)
        if not success then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBOX then
        local moneyType = MoneyTypes[moneyType][Framework.QBOX]
        local success = exports.qbx_core:AddMoney(source, moneyType, amount, reason)
        if not success then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.NDCore then
        local moneyType = MoneyTypes[moneyType][Framework.NDCore]
        local success = Player.addMoney(moneyType, amount, reason)
        if not success then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    return true
end

exports('AddMoney', function(source, moneyType, amount, reason)
    return it.addMoney(source, moneyType, amount, reason)
end)
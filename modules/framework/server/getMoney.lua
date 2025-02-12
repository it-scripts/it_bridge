function it.getMoney(source, moneyType)
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
        local amount = Player.getAccount(moneyType).money
        if amount then
            return amount
        end
    end

    if it.framework == Framework.QBCore then
        local moneyType = MoneyTypes[moneyType][Framework.QBCore]
        local amount = Player.Functions.GetMoney(moneyType)
        if amount then
            return amount
        end
    end

    if it.framework == Framework.QBOX then
        local moneyType = MoneyTypes[moneyType][Framework.QBOX]
        local amount = exports.qbx_core:GetMoney(source, moneyType)
        if amount then
            return amount
        end
    end

    if it.framework == Framework.NDCore then
        local moneyType = MoneyTypes[moneyType][Framework.NDCore]
        local amount = Player.getData(moneyType)
        if amount then
            return amount
        end
    end

    it.print.error("Failed to get money from player: " .. source)
    return 0
end

exports('getMoney', it.getMoney)
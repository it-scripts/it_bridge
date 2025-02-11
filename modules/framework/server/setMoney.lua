function it.setMoney(source, moneyType, amount, reason)

    if not reason then reason = "Money added by it_lib" end

    local Player = it.getPlayer(source)
    if not Player then
        it.print.error("Failed to get player from source: " .. source)
        return
    end

    local moneyTypes = {
        ['cash'] = {
            [Framework.ESX] = 'money',
            [Framework.QBCore] = 'cash',
            [Framework.QBOX] = 'cash',
            [Framework.NDCore] = 'cash'
        },
        ['bank'] = {
            [Framework.ESX] = 'bank',
            [Framework.QBCore] = 'bank',
            [Framework.QBOX] = 'bank',
            [Framework.NDCore] = 'bank'
        },
        ['black_money'] = {
            [Framework.ESX] = 'black_money',
            [Framework.QBCore] = 'crypto',
            [Framework.QBOX] = 'crypto',
            [Framework.NDCore] = nil
        }
    }

    if not moneyTypes[moneyType] then
        it.print.error("Invalid money type: " .. moneyType)
        return
    end

    if it.framework == Framework.ESX then
        local moneyType = moneyTypes[moneyType][Framework.ESX]
        local currentMoney = Player.getAccount(moneyType).money
        Player.setAccountMoney(moneyType, amount)
        local newMoney = Player.getAccount(moneyType).money
        if currentMoney == newMoney then
            it.print.error("Failed to set money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBCore then
        local moneyType = moneyTypes[moneyType][Framework.QBCore]
        local success = Player.Functions.SetMoney(moneyType, amount)
        if not success then
            it.print.error("Failed to set money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBOX then
        local moneyType = moneyTypes[moneyType][Framework.QBOX]
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

return it.setMoney
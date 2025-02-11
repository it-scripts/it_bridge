function it.addMoney(source, moneyType, amount, reason)
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
        Player.addAccountMoney(moneyType, amount)
        local newMoney = Player.getAccount(moneyType).money
        if currentMoney == newMoney then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBCore then
        local moneyType = moneyTypes[moneyType][Framework.QBCore]
        local success = Player.Functions.AddMoney(moneyType, amount, reason)
        if not success then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.QBOX then
        local moneyType = moneyTypes[moneyType][Framework.QBOX]
        local success = exports.qbx_core:AddMoney(source, moneyType, amount, reason)
        if not success then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    if it.framework == Framework.NDCore then
        local moneyType = moneyTypes[moneyType][Framework.NDCore]
        local success = Player.addMoney(moneyType, amount, reason)
        if not success then
            it.print.error("Failed to add money to player: " .. source)
            return false
        end
    end

    return true
end

return it.addMoney
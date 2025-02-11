function it.getMoney(source, moneyType)
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
        local amount = Player.getAccount(moneyType).money
        if amount then
            return amount
        end
    end

    if it.framework == Framework.QBCore then
        local moneyType = moneyTypes[moneyType][Framework.QBCore]
        local amount = Player.Functions.GetMoney(moneyType)
        if amount then
            return amount
        end
    end

    if it.framework == Framework.QBOX then
        local moneyType = moneyTypes[moneyType][Framework.QBOX]
        local amount = exports.qbx_core:GetMoney(source, moneyType)
        if amount then
            return amount
        end
    end

    if it.framework == Framework.NDCore then
        local moneyType = moneyTypes[moneyType][Framework.NDCore]
        local amount = Player.getData(moneyType)
        if amount then
            return amount
        end
    end

    it.print.error("Failed to get money from player: " .. source)
    return 0
end

return it.getMoney
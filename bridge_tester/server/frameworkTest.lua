lib.addCommand('bridgeTestFramework', {
    help = 'Test Bridge Framework exports',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
        {
            name = 'money',
            type = 'number',
            help = 'Amount of money the player have',
        },
        {
            name = 'bank',
            type = 'number',
            help = 'Amount of bank money the player have',
        },
        {
            name = 'blackMoney',
            type = 'number',
            help = 'Amount of blackMoney the player have',
        },

    },
}, function(source, args, raw)
    local target = args.target
    local money = args.money
    local bank = args.bank
    local blackMoney = args.blackMoney

    local framework = exports.it_bridge:GetServerFramework()

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    lib.print.info('-------------- Start Framework Test --------------')

    lib.print.info('Testing Inventory Functions with:')
    lib.print.info('Framework:', framework)

    lib.print.info('-----')
    lib.print.info('Step [0] - Get Player')
    local player = exports.it_bridge:GetPlayer(target)
    if player then
        lib.print.info('Step [0.1] - ✅ Success')
    else
        lib.print.error('Step [0.1] - ❌ Failed - Player not found')
        return
    end

    if framework == 'es_extended' then
        local account = player.getAccount('bank')
        if account.money == bank then
            lib.print.info('Step [0.2] - ✅ Success')
        else
            lib.print.error('Step [0.2] - ❌ Failed - Bank money: ', account.money, 'Expected bank money: ', bank)
            return
        end
    end

    if framework == 'qb-core' then
        local amount = player.Functions.GetMoney('bank')
        if amount == bank then
            lib.print.info('Step [0.2] - ✅ Success')
        else
            lib.print.error('Step [0.2] - ❌ Failed - Bank money: ', amount, 'Expected bank money: ', bank)
            return
        end
    end

    if framework == 'qbx_core' then
        local citId = exports.it_bridge:GetCitizenId(target)
        local amount = exports.qbx_core:GetMoney(citId, 'bank')
        if amount == bank then
            lib.print.info('Step [0.2] - ✅ Success')
        else
            lib.print.error('Step [0.2] - ❌ Failed - Bank money: ', amount, 'Expected bank money: ', bank)
            return
        end
    end

    if framework == 'ND_Core' then
        local amount = player.getData('bank')
        if amount == bank then
            lib.print.info('Step [0.2] - ✅ Success')
        else
            lib.print.error('Step [0.2] - ❌ Failed - Bank money: ', amount, 'Expected bank money: ', bank)
            return
        end
    end

    Wait(1000)

    lib.print.info('Step [1] - Get Player Money')
    local moneyAmount = exports.it_bridge:GetMoney(target, 'cash')
    if moneyAmount == money then
        lib.print.info('Step [1.1] - ✅ Success')
    else
        lib.print.error('Step [1.1] - ❌ Failed - Money: ', moneyAmount, 'Expected money: ', money)
        return
    end
    local bankAmount = exports.it_bridge:GetMoney(target, 'bank')
    if bankAmount == bank then
        lib.print.info('Step [1.2] - ✅ Success')
    else
        lib.print.error('Step [1.2] - ❌ Failed - Bank: ', bankAmount, 'Expected bank: ', bank)
        return
    end

    local blackMoneyAmount = exports.it_bridge:GetMoney(target, 'black_money')
    if blackMoneyAmount == blackMoney then
        lib.print.info('Step [1.3] - ✅ Success')
    else
        if framework ~= 'ND_Core' then
            lib.print.error('Step [1.3] - ❌ Failed - Black Money: ', blackMoneyAmount, 'Expected black money: ', blackMoney)
            return
        else
            lib.print.info('Step [4.1] - ⭕️ Skipping')
        end
    end

    Wait(1000)

    lib.print.info('Step [2] - Add Money to Player')
    local moneyToAdd = math.random(1, 1000)
    local success = exports.it_bridge:AddMoney(target, 'cash', moneyToAdd, 'Test')
    if success then
        lib.print.info('Step [2.1] - ✅ Success')
    else
        lib.print.error('Step [2.1] - ❌ Failed')
        return
    end

    local newMoney = exports.it_bridge:GetMoney(target, 'cash')
    if newMoney == money + moneyToAdd then
        lib.print.info('Step [2.2] - ✅ Success')
    else
        lib.print.error('Step [2.2] - ❌ Failed - New money: ', newMoney, 'Expected money: ', money + moneyToAdd)
        return
    end

    local bankToAdd = math.random(1, 1000)
    local success = exports.it_bridge:AddMoney(target, 'bank', bankToAdd, 'Test')
    if success then
        lib.print.info('Step [2.3] - ✅ Success')
    else
        lib.print.error('Step [2.3] - ❌ Failed')
        return
    end

    local newBank = exports.it_bridge:GetMoney(target, 'bank')
    if newBank == bank + bankToAdd then
        lib.print.info('Step [2.4] - ✅ Success')
    else
        lib.print.error('Step [2.4] - ❌ Failed - New bank: ', newBank, 'Expected bank: ', bank + bankToAdd)
        return
    end

    local blackMoneyToAdd = math.random(1, 1000)
    local success = exports.it_bridge:AddMoney(target, 'black_money', blackMoneyToAdd, 'Test')
    if success then
        lib.print.info('Step [2.5] - ✅ Success')
    else
        if framework ~= 'ND_Core' then
            lib.print.error('Step [2.5] - ❌ Failed')
            return
        else
            lib.print.info('Step [4.1] - ⭕️ Skipping')
        end
    end

    local newBlackMoney = exports.it_bridge:GetMoney(target, 'black_money')
    if newBlackMoney == blackMoney + blackMoneyToAdd then
        lib.print.info('Step [2.6] - ✅ Success')
    else
        if framework ~= 'ND_Core' then
            lib.print.error('Step [2.6] - ❌ Failed - New black money: ', newBlackMoney, 'Expected black money: ', blackMoney + blackMoneyToAdd)
            return
        else
            lib.print.info('Step [4.1] - ⭕️ Skipping')
        end
    end

    Wait(1000)

    lib.print.info('Step [3] - Remove Money from Player')
    local moneyToRemove = math.random(1, moneyToAdd)
    local success = exports.it_bridge:RemoveMoney(target, 'cash', moneyToRemove, 'Test')
    if success then
        lib.print.info('Step [3.1] - ✅ Success')
    else
        lib.print.error('Step [3.1] - ❌ Failed')
        return
    end

    local newMoney = exports.it_bridge:GetMoney(target, 'cash')
    if newMoney == (money + moneyToAdd) - moneyToRemove then
        lib.print.info('Step [3.2] - ✅ Success')
    else
        lib.print.error('Step [3.2] - ❌ Failed - New money: ', newMoney, 'Expected money: ', money + moneyToAdd - moneyToRemove)
        return
    end

    -- Remove the money we added
    local success = exports.it_bridge:RemoveMoney(target, 'cash', moneyToAdd - moneyToRemove, 'Test')
    if success then
        lib.print.info('Step [3.3] - ✅ Success')
    else
        lib.print.error('Step [3.3] - ❌ Failed')
        return
    end

    local bankToRemove = math.random(1, bankToAdd)
    local success = exports.it_bridge:RemoveMoney(target, 'bank', bankToRemove, 'Test')
    if success then
        lib.print.info('Step [3.4] - ✅ Success')
    else
        lib.print.error('Step [3.4] - ❌ Failed')
        return
    end

    local newBank = exports.it_bridge:GetMoney(target, 'bank')
    if newBank == (bank + bankToAdd) - bankToRemove then
        lib.print.info('Step [3.5] - ✅ Success')
    else
        lib.print.error('Step [3.5] - ❌ Failed - New bank: ', newBank, 'Expected bank: ', bank + bankToAdd - bankToRemove)
        return
    end

    -- Remove the bank we added
    local success = exports.it_bridge:RemoveMoney(target, 'bank', bankToAdd - bankToRemove, 'Test')
    if success then
        lib.print.info('Step [3.6] - ✅ Success')
    else
        lib.print.error('Step [3.6] - ❌ Failed')
        return
    end

    local blackMoneyToRemove = math.random(1, blackMoneyToAdd)
    local success = exports.it_bridge:RemoveMoney(target, 'black_money', blackMoneyToRemove, 'Test')
    if success then
        lib.print.info('Step [3.7] - ✅ Success')
    else
        if framework ~= 'ND_Core' then
            lib.print.error('Step [3.7] - ❌ Failed')
            return
        else
            lib.print.info('Step [4.1] - ⭕️ Skipping')
        end
    end

    local newBlackMoney = exports.it_bridge:GetMoney(target, 'black_money')
    if newBlackMoney == (blackMoney + blackMoneyToAdd) - blackMoneyToRemove then
        lib.print.info('Step [3.8] - ✅ Success')
    else
        if framework ~= 'ND_Core' then
            lib.print.error('Step [3.8] - ❌ Failed - New black money: ', newBlackMoney, 'Expected black money: ', blackMoney + blackMoneyToAdd - blackMoneyToRemove)
            return
        else
            lib.print.info('Step [4.1] - ⭕️ Skipping')
        end
    end

    -- Remove the black money we added
    local success = exports.it_bridge:RemoveMoney(target, 'black_money', blackMoneyToAdd - blackMoneyToRemove, 'Test')
    if success then
        lib.print.info('Step [3.9] - ✅ Success')
    else
        if framework ~= 'ND_Core' then
            lib.print.error('Step [3.9] - ❌ Failed')
            return
        else
            lib.print.info('Step [4.1] - ⭕️ Skipping')
        end
    end

    Wait(1000)

    lib.print.info('Step [4] - Set Money to Player')
    if framework == 'ND_Core' then
        lib.print.info('Step [4] - ⭕️ Skipping')
    else
        local success = exports.it_bridge:SetMoney(target, 'cash', moneyToAdd, 'Test')
        if success then
            lib.print.info('Step [4.1] - ✅ Success')
        else
            lib.print.error('Step [4.1] - ❌ Failed')
            return
        end

        local newMoney = exports.it_bridge:GetMoney(target, 'cash')
        if newMoney == moneyToAdd then
            lib.print.info('Step [4.2] - ✅ Success')
        else
            lib.print.error('Step [4.2] - ❌ Failed - New money: ', newMoney, 'Expected money: ', moneyToAdd)
            return
        end

        local success = exports.it_bridge:SetMoney(target, 'cash', money, 'Test')
        if success then
            lib.print.info('Step [4.3] - ✅ Success')
        else
            if framework ~= 'ND_Core' then
                lib.print.error('Step [4.3] - ❌ Failed')
                return
            else
                lib.print.info('Step [4.3] - ⭕️ Skipping')
            end
        end

        local success = exports.it_bridge:SetMoney(target, 'bank', bankToAdd, 'Test')
        if success then
            lib.print.info('Step [4.4] - ✅ Success')
        else
            lib.print.error('Step [4.4] - ❌ Failed')
            return
        end

        local newBank = exports.it_bridge:GetMoney(target, 'bank')
        if newBank == bankToAdd then
            lib.print.info('Step [4.5] - ✅ Success')
        else
            lib.print.error('Step [4.5] - ❌ Failed - New bank: ', newBank, 'Expected bank: ', bankToAdd)
            return
        end

        -- Set the bank back to the original amount
        local success = exports.it_bridge:SetMoney(target, 'bank', bank, 'Test')
        if success then
            lib.print.info('Step [4.6] - ✅ Success')
        else
            lib.print.error('Step [4.6] - ❌ Failed')
            return
        end

        local success = exports.it_bridge:SetMoney(target, 'black_money', blackMoneyToAdd, 'Test')
        if success then
            lib.print.info('Step [4.7] - ✅ Success')
        else
            if framework ~= 'ND_Core' then
                lib.print.error('Step [4.7] - ❌ Failed')
                return
            end
        end

        local newBlackMoney = exports.it_bridge:GetMoney(target, 'black_money')
        if newBlackMoney == blackMoneyToAdd then
            lib.print.info('Step [4.8] - ✅ Success')
        else
            if framework ~= 'ND_Core' then
                lib.print.error('Step [4.8] - ❌ Failed - New black money: ', newBlackMoney, 'Expected black money: ', blackMoneyToAdd)
                return
            end
        end

        -- Set the black money back to the original amount
        local success = exports.it_bridge:SetMoney(target, 'black_money', blackMoney, 'Test')
        if success then
            lib.print.info('Step [4.9] - ✅ Success')
        else
            if framework ~= 'ND_Core' then
                lib.print.error('Step [4.9] - ❌ Failed')
                return
            end
        end
    end
    

    Wait(1000)
    lib.print.info('[5] - Get Player Name')
    local playerName = exports.it_bridge:GetPlayerName(player)
    if playerName then
        lib.print.info('Step [5.1] - ✅ Success')
    else
        lib.print.error('Step [5.1] - ❌ Failed')
        return
    end

    if framework == 'es_extended' then
        if player.getName() == playerName then
            lib.print.info('Step [5.2] - ✅ Success')
        else
            lib.print.error('Step [5.2] - ❌ Failed - Player name: ', player.getName(), 'Expected player name: ', playerName)
            return
        end
    end

    if framework == 'qb-core' then
        if player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname == playerName then
            lib.print.info('Step [5.2] - ✅ Success')
        else
            lib.print.error('Step [5.2] - ❌ Failed - Player name: ', player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname, 'Expected player name: ', playerName)
            return
        end
    end

    if framework == 'qbx_core' then
        if player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname == playerName then
            lib.print.info('Step [5.2] - ✅ Success')
        else
            lib.print.error('Step [5.2] - ❌ Failed - Player name: ', player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname, 'Expected player name: ', playerName)
            return
        end
    end

    if framework == 'ND_Core' then
        if player.getData('firstname') .. ' ' .. player.getData('lastname') == playerName then
            lib.print.info('Step [5.2] - ✅ Success')
        else
            lib.print.error('Step [5.2] - ❌ Failed - Player name: ', player.getData('firstname') .. ' ' .. player.getData('lastname'), 'Expected player name: ', playerName)
            return
        end
    end

    Wait(1000)

    lib.print.info('Step [6] - Get Player Job')
    local playerJob = exports.it_bridge:GetPlayerJob(player)
    if playerJob then
        lib.print.info('Step [6.1] - ✅ Success')
    else
        lib.print.error('Step [6.1] - ❌ Failed')
        return
    end

    if framework == 'es_extended' then
        if player.getJob().name == playerJob.name then
            lib.print.info('Step [6.2] - ✅ Success')
        else
            lib.print.error('Step [6.2] - ❌ Failed - Player job: ', player.getJob().name, 'Expected player job: ', playerJob)
            return
        end
    end

    if framework == 'qb-core' then
        if player.PlayerData.job.name == playerJob.name then
            lib.print.info('Step [6.2] - ✅ Success')
        else
            lib.print.error('Step [6.2] - ❌ Failed - Player job: ', player.PlayerData.job.name, 'Expected player job: ', playerJob)
            return
        end
    end

    if framework == 'qbx_core' then
        if player.PlayerData.job.name == playerJob.name then
            lib.print.info('Step [6.2] - ✅ Success')
        else
            lib.print.error('Step [6.2] - ❌ Failed - Player job: ', player.PlayerData.job.name, 'Expected player job: ', playerJob)
            return
        end
    end

    if framework == 'ND_Core' then
        if player.job == playerJob.name then
            lib.print.info('Step [6.2] - ✅ Success')
        else
            lib.print.error('Step [6.2] - ❌ Failed - Player job: ', player.job, 'Expected player job: ', playerJob)
            return
        end
    end

    lib.print.info('-------------- End Framework Test --------------')
end)
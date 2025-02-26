lib.addCommand('testBridgeServer', {
    help = 'testBridgeServer',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        }
    },
}, function(source, args, raw)
    if source ~= 0 then
        return
    end

    local target = args.target
    if not target then
        return
    end

    lib.print.info('Start executing bridge test')

    local framework = exports.it_bridge:GetServerFramework()
    lib.print.info('Framework', framework)

    local inventory = exports.it_bridge:GetServerInventory()
    lib.print.info('Inventory', inventory)

    local interaction = exports.it_bridge:GetServerInteraction()
    lib.print.info('Interaction', interaction)

    local notify = exports.it_bridge:GetServerNotify()
    lib.print.info('Notify', notify)

    local textUI = exports.it_bridge:GetServerTextUI()
    lib.print.info('TextUI', textUI)

    local menu = exports.it_bridge:GetServerMenu()
    lib.print.info('Menu', menu)

    local dispatch = exports.it_bridge:GetServerDisptach()
    lib.print.info('Dispatch', dispatch)



    lib.print.info('Testing SendNotification export')
    exports.it_bridge:SendNotification(target, 'Send Success Test', 'Test message', 5000, 'Success', false)
    exports.it_bridge:SendNotification(target, 'Send Info Test', 'Test message', 5000, 'Info', false)
    exports.it_bridge:SendNotification(target, 'Send Warning Test', 'Test message', 5000, 'Warning', false)
    exports.it_bridge:SendNotification(target, 'Send Error Test', 'Test message', 5000, 'Error', false)
    lib.print.info('Testing SendNotification export done')

    Wait(5000)

    lib.print.info('Testing Inventory exports')
    lib.print.info('Testing canCarryItem export')
    local canCarryItem = exports.it_bridge:CanCarryItem(target, 'test_item')
    lib.print.info('canCarryItem: ' .. tostring(canCarryItem))
    
    Wait(5000)

    lib.print.info('Testing getItemCount export')
    local itemCount = exports.it_bridge:GetItemCount(target, 'test_item')
    lib.print.info('itemCount: ' .. tostring(itemCount))

    Wait(5000)

    lib.print.info('Testing getItemLabel export')
    local itemLabel = exports.it_bridge:GetItemLabel('test_item')
    lib.print.info('itemLabel: ' .. itemLabel)
    lib.print.info('Testing Inventory exports done')

    Wait(5000)

    lib.print.info('Testing giveItem export')
    local giveItem = exports.it_bridge:GiveItem(target, 'test_item', 1, nil)
    lib.print.info('giveItem: ' .. tostring(giveItem))
    lib.print.info('Testing giveItem export done')

    Wait(5000)

    lib.print.info('Testing hasItem export')
    local hasItem = exports.it_bridge:HasItem(target, 'test_item', 1, nil)
    lib.print.info('hasItem: ' .. tostring(hasItem))
    lib.print.info('Testing hasItem export done')

    Wait(5000)

    lib.print.info('Testing removeItem export')
    local removeItem = exports.it_bridge:RemoveItem(target, 'test_item', 1, nil)
    lib.print.info('removeItem: ' .. tostring(removeItem))
    lib.print.info('Testing removeItem export done')
    lib.print.info('End Inventory test')

    Wait(5000)

    lib.print.info('Start bridge Framework test')
    lib.print.info('Testing AddMoney export')
    local addMoney = exports.it_bridge:AddMoney(target, 'cash', 1000, 'Test')
    lib.print.info('addMoney: ' .. tostring(addMoney))
    local addMoney = exports.it_bridge:AddMoney(target, 'bank', 1000, 'Test')
    lib.print.info('addMoney: ' .. tostring(addMoney))
    local addMoney = exports.it_bridge:AddMoney(target, 'black_money', 1000, 'Test')
    lib.print.info('addMoney: ' .. tostring(addMoney))
    lib.print.info('Testing AddMoney export done')

    Wait(5000)

    lib.print.info('Testing getCitizenId export')
    local citizenId = exports.it_bridge:GetCitizenId(target)
    lib.print.info('citizenId: ' .. citizenId)
    lib.print.info('Testing getCitizenId export done')

    lib.print.info('Testing getMoney export')
    local getMoney = exports.it_bridge:GetMoney(target, 'cash')
    lib.print.info('getMoney: ' .. tostring(getMoney))
    local getMoney = exports.it_bridge:GetMoney(target, 'bank')
    lib.print.info('getMoney: ' .. tostring(getMoney))
    local getMoney = exports.it_bridge:GetMoney(target, 'black_money')
    lib.print.info('getMoney: ' .. tostring(getMoney))
    lib.print.info('Testing getMoney export done')

    Wait(5000)
    lib.print.info('Testing getPlayer export')
    local player = exports.it_bridge:GetPlayer(target)
    lib.print.info('player: ', player)
    lib.print.info('Testing getPlayer export done')

    Wait(5000)

    lib.print.info('Testing getPlayerByCitizenId export')
    local playerByCitizenId = exports.it_bridge:GetPlayerByCitizenId(citizenId)
    lib.print.info('playerByCitizenId: ', playerByCitizenId)
    lib.print.info('Testing getPlayerByCitizenId export done')

    Wait(5000)

    lib.print.info('Testing getPlayerJob export')
    local playerJob = exports.it_bridge:GetPlayerJob(player)
    lib.print.info('playerJob: ', playerJob)
    lib.print.info('Testing getPlayerJob export done')

    Wait(5000)

    lib.print.info('Testing getPlayerName export')
    local playerName = exports.it_bridge:GetPlayerName(player)
    lib.print.info('playerName: ' .. tostring(playerName))
    lib.print.info('Testing getPlayerName export done')

    Wait(5000)

    lib.print.info('Testing removeMoney export')
    local removeMoney = exports.it_bridge:RemoveMoney(target, 'cash', 1000, 'Test')
    lib.print.info('removeMoney: ' .. tostring(removeMoney))
    local removeMoney = exports.it_bridge:RemoveMoney(target, 'bank', 1000, 'Test')
    lib.print.info('removeMoney: ' .. tostring(removeMoney))
    local removeMoney = exports.it_bridge:RemoveMoney(target, 'black_money', 1000, 'Test')
    lib.print.info('removeMoney: ' .. tostring(removeMoney))
    lib.print.info('Testing removeMoney export done')

    Wait(5000)

    lib.print.info('Testing setMoney export')
    local setMoney = exports.it_bridge:SetMoney(target, 'cash', 1000, 'Test')
    lib.print.info('setMoney: ' .. tostring(setMoney))
    local setMoney = exports.it_bridge:SetMoney(target, 'bank', 1000, 'Test')
    lib.print.info('setMoney: ' .. tostring(setMoney))
    local setMoney = exports.it_bridge:SetMoney(target, 'black_money', 1000, 'Test')
    lib.print.info('setMoney: ' .. tostring(setMoney))
    lib.print.info('Testing setMoney export done')

    lib.print.info('End bridge Framework test')
    lib.print.info('End executing bridge test')
end)
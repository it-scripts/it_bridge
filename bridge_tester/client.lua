RegisterCommand("testBridgeClient", function(source, args, rawCommand)
   -- Trigger all client exports here

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
    exports.it_bridge:SendNotification('Send Success Test', 'Test message', 5000, 'Success', false)
    Wait(1000)
    exports.it_bridge:SendNotification('Send Info Test', 'Test message', 5000, 'Info', false)
    Wait(1000)
    exports.it_bridge:SendNotification('Send Warning Test', 'Test message', 5000, 'Warning', false)
    Wait(1000)
    exports.it_bridge:SendNotification('Send Error Test', 'Test message', 5000, 'Error', false)
    lib.print.info('Testing SendNotification export done')

    Wait(5000)

    lib.print.info('Testing Inventory exports')
    lib.print.info('Testing canCarryItem export')
    local canCarryItem = exports.it_bridge:CanCarryItem('test_item')
    lib.print.info('canCarryItem: ' .. tostring(canCarryItem))

    Wait(5000)

    lib.print.info('Testing getItemCount export')
    local itemCount = exports.it_bridge:GetItemCount('test_item')
    lib.print.info('itemCount: ' .. tostring(itemCount))

    Wait(5000)

    lib.print.info('Testing getItemLabel export')
    local itemLabel = exports.it_bridge:GetItemLabel('test_item')
    lib.print.info('itemLabel: ' .. itemLabel)
    lib.print.info('Testing getItemLabel exports done')

    Wait(5000)

    lib.print.info('Testing giveItem export')
    local giveItem = exports.it_bridge:GiveItem('test_item', 1, nil)
    lib.print.info('giveItem: ' .. tostring(giveItem))
    lib.print.info('Testing giveItem export done')

    Wait(5000)

    lib.print.info('Testing hasItem export')
    local hasItem = exports.it_bridge:HasItem('test_item', 1, nil)
    lib.print.info('hasItem: ' .. tostring(hasItem))
    lib.print.info('Testing hasItem export done')

    Wait(5000)

    lib.print.info('Testing removeItem export')
    local removeItem = exports.it_bridge:RemoveItem('test_item', 1, nil)
    lib.print.info('removeItem: ' .. tostring(removeItem))
    lib.print.info('Testing removeItem export done')

    lib.print.info('End executing bridge test')
end, false)


RegisterCommand('testBridgeDisptach', function(source, args, rawCommand)
    lib.print.info('Start executing bridge test')

    local dispatch = exports.it_bridge:GetServerDisptach()
    lib.print.info('Dispatch', dispatch)

    lib.print.info('Testing dispatch export')

    local playerCoords = GetEntityCoords(PlayerPedId())
    exports.it_bridge:SendDisptach({
        jobs = { 'police' },
        coords = playerCoords,
        title = 'Test Dispatch',
        message = 'Test Dispatch Message',
        job = 'police',
        callCode = {
            code = '10-4',
            snippet = '10-4',
        },
        blip = {
            sprite = 1,
            scale = 1.0,
            colour = 1,
            flashes = false,
            text = 'Test Dispatch',
            time = 5000,
            radius = 100.0,
        }
    })
    lib.print.info('Testing dispatch export done')

    lib.print.info('End executing bridge test')
end, false)
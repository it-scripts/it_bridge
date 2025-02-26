lib.addCommand('bridgeTestInventory', {
    help = 'Test Bridge Inventory exports',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
        {
            name = 'item',
            type = 'string',
            help = 'Name of the item to test functions',
        },
    },
}, function(source, args, raw)
    local target = args.target
    local item = args.item

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    local checkItemCount = 0
    local currentItemCount = 0

    lib.print.info('-------------- Start Inventory Test --------------')

    lib.print.info('Testing Inventory Functions with:')
    lib.print.info('Framework:', exports.it_bridge:GetServerFramework())
    lib.print.info('Inventory:', exports.it_bridge:GetServerInventory())

    lib.print.info('-----')

    lib.print.info('Step [0] - Check if player can carry item')
    local canCarryItem = exports.it_bridge:CanCarryItem(target, item)
    if canCarryItem then
        lib.print.info('Step [0.1] - ✅ Success')
    else
        lib.print.error('Step [0.1] - ❌ Failed - Player can not carry item')
        return
    end

    lib.print.info('Step [1] - Get current item count')
    currentItemCount = exports.it_bridge:GetItemCount(target, item)
    if currentItemCount and checkItemCount == currentItemCount then
        lib.print.info('Step [1.1] - ✅ Success')
    else
        lib.print.error('Step [1.1] - ❌ Failed - Current item count: ', currentItemCount, 'Expected item count: ', checkItemCount)
        return
    end

    Wait(1000)

    lib.print.info('Step [2] - Give item to player')
    local amountToAdd = math.random(5, 10)
    local success = exports.it_bridge:GiveItem(target, item, amountToAdd, nil)
    if success then
        lib.print.info('Step [2.1] - ✅ Success (Player received item)')
    else
        lib.print.error('Step [2.1] - ❌ Failed')
        return
    end
    currentItemCount = exports.it_bridge:GetItemCount(target, item)
    if currentItemCount and currentItemCount == amountToAdd then
        lib.print.info('Step [2.2] - ✅ Success (Item count is correct)')
    else
        lib.print.error('Step [2.2] - ❌ Failed - Current item count: ', currentItemCount, 'Expected item count: ', amountToAdd)
        return
    end

    Wait(1000)

    lib.print.info('Step [3] - Has player item')
    local hasItem = exports.it_bridge:HasItem(target, item)
    if hasItem then
        lib.print.info('Step [3.1] - ✅ Success')
    else
        lib.print.error('Step [3.1] - ❌ Failed - Player does not have item')
        return
    end

    hasItem = exports.it_bridge:HasItem(target, item, amountToAdd)
    if hasItem then
        lib.print.info('Step [3.2] - ✅ Success')
    else
        lib.print.error('Step [3.2] - ❌ Failed - Player does not have item with correct amount')
        return
    end

    Wait(1000)

    lib.print.info('Step [4] - Remove item from player')
    local amountToRemove = math.random(1, amountToAdd - 1)
    local success = exports.it_bridge:RemoveItem(target, item, amountToRemove, nil)
    if success then
        lib.print.info('Step [4.1] - ✅ Success (Player removed item)')
    else
        lib.print.error('Step [4.1] - ❌ Failed')
        return
    end

    currentItemCount = exports.it_bridge:GetItemCount(target, item)
    if currentItemCount and currentItemCount == amountToAdd - amountToRemove then
        lib.print.info('Step [4.2] - ✅ Success (Item count is correct)')
    else
        lib.print.error('Step [4.2] - ❌ Failed - Current item count: ', currentItemCount, 'Expected item count: ', amountToAdd - amountToRemove)
        return
    end

    local success = exports.it_bridge:RemoveItem(target, item, amountToAdd - amountToRemove, nil)
    if success then
        lib.print.info('Step [4.3] - ✅ Success (Player removed item)')
    else
        lib.print.error('Step [4.3] - ❌ Failed')
        return
    end

    currentItemCount = exports.it_bridge:GetItemCount(target, item)
    if currentItemCount and currentItemCount == 0 then
        lib.print.info('Step [4.4] - ✅ Success (Item count is correct)')
    else
        lib.print.error('Step [4.4] - ❌ Failed - Current item count: ', currentItemCount, 'Expected item count: 0')
        return
    end

    Wait(1000)
    lib.print.info('Step [5] - Get item label')
    local itemLabel = exports.it_bridge:GetItemLabel(item)
    if itemLabel and itemLabel ~= item then
        lib.print.info('Step [5.1] - ✅ Success')
    else
        lib.print.error('Step [5.1] - ❌ Failed - Item label: ', itemLabel, 'is equal to item name: ', item)
        return
    end

    lib.print.info('-------------- End Inventory Test --------------')
end)
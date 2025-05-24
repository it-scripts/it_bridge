function it.canCarryItems(src, itemList)

    if it.inventory == Inventories.OX then
        local totalWeight = 0
        for item, amount in pairs(itemList) do
            local itemData = ox_inventory:Items(item)
            if itemData then
                totalWeight = totalWeight + (itemData.weight * amount)
                if Config.Debug then
                    lib.print.info('Item: ' .. item .. ' Weight: ' .. itemData.weight .. ' Amount: ' .. amount)
                    lib.print.info('Total Weight: ' .. totalWeight)
                end
            end
        end
        local canCarry, _ = ox_inventory:CanCarryWeight(src, totalWeight)
        return canCarry
    end

    if it.inventory == Inventories.ORIGEN then
        local playerInventoryData = exports.origen_inventory:getInventory(src)
        local currentMaxWeight = playerInventoryData.maxWeight
        local currentWeight = playerInventoryData.weight
        local totalWeight = 0
        for item, amount in pairs(itemList) do
            local itemData = exports.origen_inventory:Items(item)
            if itemData then
                totalWeight = totalWeight + (itemData.weight * amount)
                if Config.Debug then
                    lib.print.info('Item: ' .. item .. ' Weight: ' .. itemData.weight .. ' Amount: ' .. amount)
                    lib.print.info('Total Weight: ' .. totalWeight)
                end
            end
        end
        if currentWeight + totalWeight <= currentMaxWeight then
            return true
        else
            return false
        end
    end

    if it.inventory == Inventories.CODEM then
        -- TODO: Check if the play can carry the item
        return true
    end

    if it.inventory == Inventories.QB then
        local freeWeight = exports['qb-inventory']:GetFreeWeight(src)
        local totalWeight = 0
        for item, amount in pairs(itemList) do
            local itemData = CoreObject.Shared.Items[item:lower()]
            if itemData then
                totalWeight = totalWeight + (itemData.weight * amount)
            else
                it.print.error('[canCarryItem] - No itemData Found!')
                return true
            end
        end
        if freeWeight >= totalWeight then
            return true
        else
            return false
        end
    end

    if it.inventory == Inventories.PS then
        local Player = CoreObject.Functions.GetPlayer(source)
        -- Get Config Table from the ps-inventory config.lua file
        local psConfigFile = LoadResourceFile('ps-inventory', 'config.lua')
        local psConfig = json.decode(psConfigFile)
        
        local inventory, items
        if Player then
            inventory = {
                maxWeight = psConfig.defaultWeight,
                slots = psConfig.defaultSlots,
            }
            items = Player.PlayerData.items
        end

        if not inventory then
            it.print.error('[canCarryItem] - Unable to load the player inventory. Please contact the developer.')
            return true
        end

        local totalWeight = 0
        for item, amount in pairs(itemList) do
            local currentItemData = CoreObject.Shared.Items[item:lower()]
            if currentItemData then
                totalWeight = totalWeight + (currentItemData.weight * amount)
            else
                it.print.error('[canCarryItem] - No itemData Found for item!', item)
                return true
            end
        end


        local inventoryWeight = exports['ps-inventory']:GetTotalWeight(items) + totalWeight
        if inventoryWeight > inventory.maxWeight then
            return false
        end
        return true
    end

    if it.inventory == Inventories.RC2 then
        local Player = CoreObject.Functions.GetPlayer(source)
        -- Get Config Table from the ps-inventory config.lua file
        local rc2ConfigFile = LoadResourceFile('Rc2-inventory', 'config.lua')
        local rc2Config = json.decode(rc2ConfigFile)
        
        local inventory, items
        if Player then
            inventory = {
                maxWeight = rc2Config.MaxInventoryWeight,
                slots = rc2Config.MaxInventorySlots,
            }
            items = Player.PlayerData.items
        end

        if not inventory then
            it.print.error('[canCarryItem] - Unable to load the player inventory. Please contact the developer.')
            return true
        end

        local totalWeight = 0
        for item, amount in pairs(itemList) do
            local currentItemData = CoreObject.Shared.Items[item:lower()]
            if currentItemData then
                totalWeight = totalWeight + (currentItemData.weight * amount)
            else
                it.print.error('[canCarryItem] - No itemData Found for item!', item)
                return true
            end
        end


        local inventoryWeight = exports['Rc2-inventory']:GetTotalWeight(items) + totalWeight
        if inventoryWeight > inventory.maxWeight then
            return false
        end
        return true
    end

    if it.inventory == Inventories.ESX then
        local xPlayer = it.getPlayer(src)
        local currentWeight = xPlayer.getWeight()
        local totalWeight = 0
        for item, amount in pairs(itemList) do
            -- Get item from the database
            MySQL.Async.fetchAll('SELECT * FROM items WHERE name = @name', {
                ['@name'] = item
            }, function(itemData)
                if itemData[1] then
                    totalWeight = totalWeight + (itemData[1].weight * amount)
                end
            end)
        end
        if currentWeight + totalWeight <= CoreObject.GetConfig().MaxWeight then
            return true
        else
            return false
        end
    end
end

lib.callback.register('it_bridge:callback:canCarryItems', function(source, itemList)
    return it.canCarryItems(source, itemList)
end)

exports('CanCarryItems', function(source, itemList)

    -- Check if the itemList table has the format 
    -- ['itemName'] = amount

    if type(itemList) ~= 'table' then
        it.print.error('[CanCarryItems] - itemList is not a table!')
        return false
    end
    for item, amount in pairs(itemList) do
        if type(item) ~= 'string' or type(amount) ~= 'number' then
            it.print.error('[CanCarryItems] - Table format need to be: [itemName] = amount')
            return false
        end
    end

    return it.canCarryItems(source, itemList)
end)
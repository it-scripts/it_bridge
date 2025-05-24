--- Get the item count of a specific item in the player's inventory.
---@param source number: The player's server ID.
---@param item string: The item name.
---@return boolean: If the player can carry the item.
function it.canCarryItem(source, item, amount)

    if not amount then amount = 1 end

    if it.inventory == Inventories.ESX then
        local Player = CoreObject.GetPlayerFromId(source)
        if not Player then
            it.print.error('[canCarryItem] - Unable to load the player. Please contact the developer.')
            return false
        end
        local canCarryItem = Player.canCarryItem(item, amount)
        if canCarryItem then return true else return false end
    end

    if it.inventory == Inventories.QB then
        local canCarryItem = exports['qb-inventory']:CanAddItem(source, item, amount)
        if canCarryItem then return true else return false end
    end

    if it.inventory == Inventories.PS then
        local Player = CoreObject.Functions.GetPlayer(source)
        local itemData = CoreObject.Shared.Items[item:lower()]
        if not itemData then it.print.error('[canCarryItem] - No itemData Found!') return true end

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

        local weight = itemData.weight * amount
        local totalWeight = exports['ps-inventory']:GetTotalWeight(items) + weight
        if totalWeight > inventory.maxWeight then
            return false
        end
        return true
    end

    if it.inventory == Inventories.RC2 then
        local Player = CoreObject.Functions.GetPlayer(source)
        local itemData = CoreObject.Shared.Items[item:lower()]
        if not itemData then it.print.error('[canCarryItem] - No itemData Found!') return true end

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

        local weight = itemData.weight * amount
        local totalWeight = exports['Rc2-inventory']:GetTotalWeight(items) + weight
        if totalWeight > inventory.maxWeight then
            return false
        end
        return true
    end

    if it.inventory == Inventories.QS then
        local canCarryItem = exports['qs-inventory']:CanCarryItem(source, item, amount)
        if canCarryItem then return true else return false end
    end

    if it.inventory == Inventories.OX then
        local canCarryItem = ox_inventory:CanCarryItem(source, item, amount, nil)
        if canCarryItem then return true else return false end
    end

    if it.inventory == Inventories.CODEM then
        -- TODO: Add the function to check if the player can carry the item
        return true
    end

    if it.inventory == Inventories.ORIGEN then
        local canCarryItem = origen_inventory:CanCarryItem(source, item, amount)
        if canCarryItem then return true else return false end
    end

    it.print.error('[canCarryItem] - There was an issue checking if the player can carry the item:'..item)
    return false
end

lib.callback.register('it_bridge:callback:canCarryItem', function(source, item, amount)
    return it.canCarryItem(source, item, amount)
end)

exports('CanCarryItem', function(source, item, amount)
    return it.canCarryItem(source, item, amount)
end)
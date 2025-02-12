--- Get the item count of a specific item in the player's inventory.
---@param source number: The player's server ID.
---@param item string: The item name.
---@return boolean: If the player can carry the item.
function it.canCarryItem(source, item, amount)

    if not amount then amount = 1 end

    if it.inventory == Inventories.ESX then
        local Player = CoreObject.GetPlayerFromId(source)
        if not Player then
            it.print.warn('[canCarryItem] - Unable to load the player. Please contact the developer.')
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
        local canCarryItem = exports['ps-inventory']:CanAddItem(source, item, amount)
        if canCarryItem then return true else return false end
    end

    if it.inventory == Inventories.QS then
        local canCarryItem = exports['qs-inventory']:CanCarryItem(source, item, amount)
        if canCarryItem then return true else return false end
    end

    if it.inventory == Inventories.OX then
        local canCarryItem = ox_inventory.CanCarryItem(source, item, amount)
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

lib.callback.register('it_lib:callback:canCarryItem', function(source, item, amount)
    return it.canCarryItem(source, item, amount)
end)

exports('canCarryItem', function(source, item, amount)
    return it.canCarryItem(source, item, amount)
end)
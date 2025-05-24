--- Remove the item from the player's inventory.
---@param source number: The player's server ID.
---@param item string: The item name.
---@param amount number: The amount of the item.
---@param metadata table | nil: The metadata of the item.
---@return boolean
function it.removeItem(source, item, amount, metadata)
    if not amount then amount = 1 end

    if it.inventory == Inventories.ESX then
        local Player = CoreObject.GetPlayerFromId(source)
        local original_amount = Player.getInventoryItem(item)?.count
        Player.removeInventoryItem(item, amount, metadata or {})
        local new_amount = Player.getInventoryItem(item)?.count
        if new_amount <= original_amount - amount then
            return true
        end
    end

    if it.inventory == Inventories.QB then
        return exports['qb-inventory']:RemoveItem(source, item, amount)
    end

    if it.inventory == Inventories.RC2 then
        return exports['ps-inventory']:RemoveItem(source, item, amount)
    end

    if it.inventory == Inventories.PS then
        return exports['Rc2-inventory']:RemoveItem(source, item, amount)
    end

    if it.inventory == Inventories.QS then
        local currentItemCount = it.getItemCount(source, item, metadata or {})
        exports['qs-inventory']:RemoveItem(source, item, amount, metadata or {})
        local newCount = it.getItemCount(source, item, metadata)
        if newCount <= currentItemCount - amount then
            return true
        end
    end

    if it.inventory == Inventories.OX then
        local removed, _ = ox_inventory:RemoveItem(source, item, amount, metadata or nil)
        return removed
    end

    if it.inventory == Inventories.CODEM then
        local currentItemCount = it.getItemCount(source, item, metadata or nil)
        exports['codem-inventory']:RemoveItem(source, item, amount)
        local newCount = it.getItemCount(source, item, metadata or nil)
        if newCount <= currentItemCount - amount then
            return true
        end
    end

    if it.inventory == Inventories.ORIGEN then
        local success, _ = origen_inventory:removeItem(source, item, amount, metadata or {})
        return success
    end

    it.print.error('[removeItem] - There was an issue removing the item:'..item)
    return false
end

lib.callback.register('it_bridge:callback:removeItem', function(source, item, amount, metadata)
    return it.removeItem(source, item, amount, metadata)
end)

exports('RemoveItem', function(source, item, amount, metadata)
    return it.removeItem(source, item, amount, metadata)
end)
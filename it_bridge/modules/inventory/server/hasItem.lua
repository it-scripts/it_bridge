--- Check if the player has the item in the inventory.
---@param source number: The player's server ID.
---@param item string: The item name.
---@param amount number | nil : The amount of the item.
---@return boolean: If the player has the item.
function it.hasItem(source, item, amount, metadata)
    if not amount then amount = 1 end
    if not metadata then metadata = nil end

    if it.inventory == Inventories.ESX then
        local Player = CoreObject.GetPlayerFromId(source)
        if not Player then
            it.print.error('[hasItem] - Unable to load the player. Please contact the developer.')
            return false
        end
		local esxItem = Player.getInventoryItem(item)
        if esxItem then
            if esxItem.count >= amount then return true else return false end
        end
    end
    
    if it.inventory == Inventories.QB then
        local hasItem = exports['qb-inventory']:HasItem(source, item, amount)
        if hasItem then return true else return false end
    end

    if it.inventory == Inventories.PS then
        local hasItem = exports['ps-inventory']:HasItem(source, item, amount)
        if hasItem then return true else return false end
    end

    if it.inventory == Inventories.RC2 then
        local hasItem = exports['Rc2-inventory']:HasItem(source, item, amount)
        if hasItem then return true else return false end
    end

    if it.inventory == Inventories.QS then
        local totalAmount = exports['qs-inventory']:GetItemTotalAmount(source, item)
        if totalAmount  then
            if totalAmount >= amount then return true else return false end
        end
        lib.print.error('[hasItem] - Unable to get the item total amount. Please contact the developer.')
        return false
    end

    if it.inventory == Inventories.OX then
        local count = ox_inventory:GetItem(source, item, metadata or nil, true)
        if count then
            if count >= amount then return true else return false end
        end
        it.print.error('[hasItem] - Unable to get the item data. Please contact the developer.')
        return false
    end

    if it.inventory == Inventories.CODEM then
        local hasItem = exports['codem-inventory']:GetItemsTotalAmount(source, item)
        if hasItem then
            if hasItem >= amount then return true else return false end
        end
        it.print.error('[hasItem] - Unable to get the item total amount. Please contact the developer.')
        return false
    end

    if it.inventory == Inventories.ORIGEN then
        local itemCount = origen_inventory:getItemCount(source, item, metadata or nil, true)
        if itemCount then
            if itemCount >= amount then return true else return false end
        end
        it.print.error('[hasItem] - Unable to get the item data. Please contact the developer.')
    end

    it.print.error('[hasItem] - The inventory is not supported.')
    return false
end

lib.callback.register('it_bridge:callback:hasItem', function(source, item, amount, medatadata)
    return it.hasItem(source, item, amount, medatadata)
end)

exports('HasItem', function(source, item, amount, metadata)
    return it.hasItem(source, item, amount, metadata)
end)
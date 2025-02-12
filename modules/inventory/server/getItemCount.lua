--- Get the item count of a specific item in the player's inventory.
---@param source number: The player's server ID.
---@param item string: The item name.
---@param metadata table | nil: The metadata of the item.
---@return number: The amount of the item.
function it.getItemCount(source, item, metadata)
    if it.inventory == Inventories.ESX then
        local Player = CoreObject.GetPlayerFromId(source)
        if not Player then
            it.print.warn('[getItemCount] - Unable to load the player. Please contact the developer.')
            return 0
        end
        local esxItem = Player.getInventoryItem(item)
        if esxItem then
            return esxItem.count else return 0
        end
    end

    if it.inventory == Inventories.QB then
        local itemCount = exports['qb-inventory']:GetItemCount(source, item)
        if itemCount then return itemCount end
    end

    if it.inventory == Inventories.PS then
        local itemCount = exports['ps-inventory']:GetItemCount(source, item)
        if itemCount then return itemCount end
    end

    if it.inventory == Inventories.QS then
        local itemCount = exports['qs-inventory']:GetItemTotalAmount(source, item)
        if itemCount then return itemCount end
    end

    if it.inventory == Inventories.OX then
        local itemData = ox_inventory.GetItem(source, item, metadata or nil, true)
        if itemData then return itemData.amount end
    end

    if it.inventory == Inventories.CODEM then
        local itemCount = exports['codem-inventory']:GetItemsTotalAmount(source, item)
        if itemCount then return itemCount else return 0 end
    end

    if it.inventory == Inventories.ORIGEN then
        local itemCount = origen_inventory:getItemCount(source, item, metadata or nil, true)
        if itemCount then return itemCount else return 0 end
    end


    it.print.error('[getItemCount] - There was an issue getting the item count for the item:'..item)
    return 0
end

lib.callback.register('it_bridge:callback:getItemCount', function(source, item, metadata)
    return it.getItemCount(source, item, metadata)
end)

exports('getItemCount', function(source, item, metadata)
    return it.getItemCount(source, item, metadata)
end)
--- Give the player an item.
---@param source number: The player's server ID.
---@param item string: The item name.
---@param amount number: The amount of the item.
---@param metadata table | nil: The metadata of the item.
---@return boolean: If the item was given to the player.
function it.giveItem(source, item, amount, metadata)
    if not amount then amount = 1 end

    if it.inventory == Inventories.ESX then
        local Player = CoreObject.GetPlayerFromId(source)
        local original_amount = Player.getInventoryItem(item)?.count
		Player.addInventoryItem(item, amount, metadata or {})
        local new_amount = Player.getInventoryItem(item)?.count
        if new_amount >= original_amount + amount then
            return true
        end
    end

    if it.inventory == Inventories.QB then
        return exports['qb-inventory']:AddItem(source, item, amount, false, false, 'Item added by it_bridge')
    end

    if it.inventory == Inventories.PS then
        return exports['ps-inventory']:AddItem(source, item, amount, false, false, 'Item added by it_bridge')
    end

    if it.inventory == Inventories.RC2 then
        return exports['Rc2-inventory']:AddItem(source, item, amount, nil, nil)
    end

    if it.inventory == Inventories.QS then
        local currentItemCount = it.getItemCount(source, item, metadata or {})
        exports['qs-inventory']:AddItem(source, item, amount, nil, metadata or {})
        local newCount = it.getItemCount(source, item, metadata)
        if newCount >= currentItemCount + amount then
            return true
        end
    end

    if it.inventory == Inventories.OX then
        local added, _ = ox_inventory:AddItem(source, item, amount, metadata or nil)
        return added
    end

    if it.inventory == Inventories.TGIANN then
        local added = exports["tgiann-inventory"]:AddItem(source, item, amount, nil, metadata)
        return added
    end

    if it.inventory == Inventories.CODEM then
        local currentItemCount = it.getItemCount(source, item, metadata or nil)
        exports['codem-inventory']:AddItem(source, item, amount, metadata or nil)
        local newCount = it.getItemCount(source, item, metadata or nil)
        if newCount >= currentItemCount + amount then
            return true
        end
    end

    if it.inventory == Inventories.ORIGEN then
        local success, _ = origen_inventory:addItem(source, item, amount, metadata or {}, false, true)
        return success
    end

    it.print.error('[giveItem] - There was an issue giving the item:'..item)
    return false
end

lib.callback.register('it_bridge:callback:giveItem', function(source, item, amount, metadata)
    return it.giveItem(source, item, amount, metadata)
end)

exports('GiveItem', function(source, item, amount, metadata)
    return it.giveItem(source, item, amount, metadata)
end)
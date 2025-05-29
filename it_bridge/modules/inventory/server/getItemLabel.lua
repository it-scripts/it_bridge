--- Get the item label of a specific item.
--- @param itemName string: The item name.
--- @return string | nil: The item label.
function it.getItemLabel(itemName)
    
    if it.inventory == Inventories.ESX then
        local itemLabel = CoreObject.GetItemLabel(itemName)
        if itemLabel then return itemLabel end
    end

    if it.inventory == Inventories.QB then
        local item = CoreObject.Shared.Items[itemName]
        if item then return item.label end
    end

    if it.inventory == Inventories.PS or it.inventory == Inventories.RC2 then
        local item = CoreObject.Shared.Items[itemName]
        if item then return item.label end
    end

    if it.inventory == Inventories.QS then
        local itemList = exports['qs-inventory']:GetItemList()
        for name, data in pairs(itemList) do
            if name == itemName then
                return data.label
            end
        end
    end

    if it.inventory == Inventories.OX then
        local item = ox_inventory:Items(itemName)
        if item then
            return item.label
        end
    end

    if it.inventory == Inventories.TGIANN then
        local itemLabel = exports["tgiann-inventory"]:GetItemLabel(itemName)
        return itemLabel or itemName
    end

    if it.inventory == Inventories.CODEM then
        local itemLabel = exports['codem-inventory']:GetItemLabel(itemName)
        if itemLabel then return itemLabel end
    end

    if it.inventory == Inventories.ORIGEN then
        local item = origen_inventory:Items(itemName)
        if item then return item.label end
    end

    it.print.error('[getItemLabel] - There was an issue getting the item label for the item:'..itemName)
    return itemName
end

lib.callback.register('it_bridge:callback:getItemLabel', function(_, itemName)
    return it.getItemLabel(itemName)
end)

exports('GetItemLabel', function(itemName)
    return it.getItemLabel(itemName)
end)
---@param item string: The item name.
---@return boolean: If the player can carry the item.
function it.canCarryItem(itemList)
    return lib.callback.await('it_bridge:callback:canCarryItem', false, itemList)
end

exports('CanCarryItems', function(itemList)
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

    return it.canCarryItem(itemList)
end)
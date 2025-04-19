---@param item string: The item name.
---@return boolean: If the player can carry the item.
function it.canCarryItem(item, amount)
    return lib.callback.await('it_bridge:callback:canCarryItem', false, item, amount)
end

exports('CanCarryItem', function(item, amount)
    return it.canCarryItem(item, amount)
end)
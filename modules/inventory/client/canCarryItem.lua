---@param item string: The item name.
---@return boolean: If the player can carry the item.
function it.canCarryItem(item)
    return lib.callback.await('it_lib:callback:canCarryItem', item, false)
end

exports('canCarryItem', it.canCarryItem)
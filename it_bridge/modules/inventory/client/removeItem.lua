--- Remove an item from the player's inventory.
---@param item string The item name.
---@param amount number The amount of the item.
---@param metadata table|string|nil The metadata of the item.
---@return boolean If the item was removed from the player.
function it.removeItem(item, amount, metadata)
    return lib.callback.await('it_bridge:callback:removeItem', false, item, amount, metadata)
end

exports('RemoveItem', function(item, amount, metadata)
    return it.removeItem(item, amount, metadata)
end)
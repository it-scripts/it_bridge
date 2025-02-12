--- Give an item to the player
---@param item string The item name
---@param amount number The amount of the item 
---@param metadata number The metadata of the item
---@return boolean If the item was given to the player
function it.giveItem(item, amount, metadata)
    return lib.callback.await('it_bridge:callback:giveItem', item, amount, metadata, false)
end

exports('giveItem', it.giveItem)
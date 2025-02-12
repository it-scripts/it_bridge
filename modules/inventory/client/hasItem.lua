--- Check if the player has an item in their inventory
---@param item string The item name
---@param amount number The amount of the item
---@param metadata table|string|nil The metadata of the item
---@return boolean If the player has the item
function it.hasItem(item, amount, metadata)
    if not amount then amount = 1 end
    return lib.callback.await('it_lib:callback:hasItem', item, amount, metadata, false)
end

exports('hasItem', it.hasItem)
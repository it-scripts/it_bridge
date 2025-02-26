--- Function to get item count from server
---@param item string: The item name.
---@return number: The amount of the item.
function it.getItemCount(item, metadata)
    return lib.callback.await('it_bridge:callback:getItemCount', false, item, metadata)
end

exports('GetItemCount', function(item, metadata)
    return it.getItemCount(item, metadata)
end)
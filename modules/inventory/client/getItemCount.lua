--- Function to get item count from server
---@param item string: The item name.
---@return number: The amount of the item.
function it.getItemCount(item)
    return lib.callback.await('it_lib:callback:getItemCount', item, false)
end

exports('getItemCount', it.getItemCount)
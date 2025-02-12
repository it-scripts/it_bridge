--- Get the label of an item.
---@param itemName string The item name.
---@return string The item label.
function it.getItemLabel(itemName)
    return lib.callback.await('it_lib:callback:getItemLabel', itemName, false)
end

exports('getItemLabel', it.getItemLabel)

--- Get the label of an item.
---@param item string The item name.
---@return unknown The item label.
function it.getItemLabel(itemName)
    return lib.callback.await('it_lib:callback:getItemLabel', itemName, false)
end

return it.getItemLabel

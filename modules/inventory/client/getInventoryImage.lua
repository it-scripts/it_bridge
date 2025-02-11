function it.getInventoryImage(itemName)
    local imagePath = 'nui://'..Config.InventoryImgPath[it.inventory]..itemName..'.png'
    return imagePath
end

return it.getInventoryImage
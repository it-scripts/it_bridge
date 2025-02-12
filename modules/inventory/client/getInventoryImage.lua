function it.getInventoryImage(itemName)
    local imagePath = 'nui://'..Config.InventoryImgPath[it.inventory]..itemName..'.png'
    return imagePath
end

exports('getInventoryImage', function(itemName)
    return it.getInventoryImage(itemName)
end)
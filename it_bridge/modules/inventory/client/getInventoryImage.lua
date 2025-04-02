function it.getInventoryImage(itemName)
    local imagePath = 'nui://'..Config.InventoryImgPath[it.inventory]..itemName..'.png'
    return imagePath
end

exports('GetInventoryImage', function(itemName)
    return it.getInventoryImage(itemName)
end)
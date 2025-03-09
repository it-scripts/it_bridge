local consumableItems = {}

function it.createUsableItem(itemName, cb)

    --[[ if consumableItems[itemName] then
        it.print.error('The item ' .. itemName .. ' is already registered as a consumable item')
        return
    end ]]

    if it.inventory == Inventories.QS then
        if it.getItemLabel(itemName) then
            exports['qs-inventory']:registerUsableItem(itemName, cb)
            consumableItems[itemName] = cb
            return
        end
    end

    if it.inventory == Inventories.ORIGEN then
        if it.getItemLabel(itemName) then
            exports.origen_inventory:CreateUseableItem(itemName, cb)
            consumableItems[itemName] = cb
            return
        end
    end

    if it.framework == Framework.ESX then
        local itemLabel = it.getItemLabel(itemName)
        if itemLabel then
            CoreObject.RegisterUsableItem(itemName, cb)
            consumableItems[itemName] = cb
            return
        end
    end

    if it.framework == Framework.QBCore then
        local itemLabel = it.getItemLabel(itemName)
        if itemLabel then
            CoreObject.Functions.CreateUseableItem(itemName, cb)
            consumableItems[itemName] = cb
            return
        end
    end
    it.print.error('Failed to create usable item: ' .. itemName)
end

exports('CreateUsableItem', function(itemName, cb)
    it.createUsableItem(itemName, cb)
end)
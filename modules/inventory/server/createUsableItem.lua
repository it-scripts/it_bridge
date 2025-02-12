local consumableItems = {}

function it.createUsableItems(itemName, cb)

    if consumableItems[itemName] then
        it.print.warn('The item ' .. itemName .. ' is already registered as a consumable item')
        return
    end

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
            exports['qb-core']:RegisterUsableItem(itemName, cb)
            consumableItems[itemName] = cb
            return
        end
    end
    it.print.error('Failed to create usable item: ' .. itemName)
end

exports('createUsableItems', it.createUsableItems)
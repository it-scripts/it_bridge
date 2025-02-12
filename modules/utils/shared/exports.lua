local function getServerFramework()
    return it.framework
end

exports('getServerFramework', getServerFramework)

local function getServerInventory()
    return it.inventory
end

exports('getServerInventory', getServerInventory)


local function getServerInteraction()
    return it.interaction
end

exports('getServerInteraction', getServerInteraction)

local function getServerNotification()
    return it.notification
end

exports('getServerNotification', getServerNotification)

local function getServerDispatch()
    return it.dispatch
end

exports('getServerDispatch', getServerDispatch)
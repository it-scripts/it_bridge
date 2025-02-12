function it.sendNotification(title, msg, time, type, sound)
    type = Config.NotificationsSettings[type] or Config.NotificationsSettings.Info

    if it.notify == Notifications.BRUTAL then
        exports['brutal_notify']:SendAlert(title, msg, time, type, sound)
    elseif it.notify == Notifications.OX then
        lib.notify({
            title = title,
            description = msg,
            duration = time,
            type = type,
        })
    elseif it.notify == Notifications.ESX_NOTIFY then
        exports["esx_notify"]:Notify(type, time, msg)
    elseif it.notify == Notifications.QBCORE then
        CoreObject.Functions.Notify(msg, type, time)
    elseif it.notify == Notifications.ESX then
        CoreObject.ShowNotification(msg, type, time)
    elseif it.notify == Notifications.MYTHIC then
        exports['mythic_notify']:DoCustomHudText (type, msg, time)
    elseif it.notify == Notifications.OKOK then
        exports['okokNotify']:Alert(title, msg, time, type, sound)
    end
end

RegisterNetEvent('it_lib:client:notify', function(title, msg, time, type, sound)
    it.notify(title, msg, time, type, sound)
end)

exports('sendNotification', function(title, msg, time, type, sound)
    it.sendNotification(title, msg, time, type, sound)
end)
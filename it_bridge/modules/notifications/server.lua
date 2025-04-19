function it.sendNotification(playerId, title, msg, time, type, sound)
    TriggerClientEvent('it_bridge:client:notify', playerId, title, msg, time, type, sound)
end

exports('SendNotification', function(playerId, title, msg, time, type, sound)
    it.sendNotification(playerId, title, msg, time, type, sound)
end)
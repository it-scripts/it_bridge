function it.notify(source, title, msg, time, type, sound)
    TriggerClientEvent('it_lib:client:notify', source, title, msg, time, type, sound)
end

return it.notify
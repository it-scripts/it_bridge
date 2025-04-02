function it.getPlayerJob()
    return lib.callback.await('it_bridge:callback:getPlayerJob', false)
end

exports('GetPlayerJob', function()
    return it.getPlayerJob()
end)
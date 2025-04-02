function it.getPlayerName()
    return lib.callback.await('it_bridge:callback:getPlayerName', false)
end

exports('GetPlayerName', function()
    return it.getPlayerName()
end)
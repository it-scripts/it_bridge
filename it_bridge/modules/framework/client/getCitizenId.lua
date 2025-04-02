function it.getCitizenId()
    return lib.callback.await('it_bridge:callback:getCitizenId', false)
end

exports('GetCitizenId', function()
    return it.getCitizenId()
end)
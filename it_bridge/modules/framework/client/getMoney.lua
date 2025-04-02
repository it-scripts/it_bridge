function it.getMoney(moneyType)
    return lib.callback.await('it_bridge:callback:getMoney', false, moneyType)
end

exports('GetMoney', function(moneyType)
    return it.getMoney(moneyType)
end)

function it.generateUUID()
    local random = math.random
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function it.generateCustomID(length)
    if length == nil then length = 8 end
    if length == 36 then return it.generateUUID() end
    if length > 36 then length = 36 end
    local randomId = it.generateUUID()
    return string.sub(randomId, 1, length)
end

exports('GenerateUUID', function()
    return it.generateUUID()
end)

exports('GenerateCustomID', function(length)
    return it.generateCustomID(length)
end)
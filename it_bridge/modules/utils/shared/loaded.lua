function it.hasLoaded()
    if it.loaded then
        return true
    end
    return false
end

exports('hasLoaded', it.hasLoaded)
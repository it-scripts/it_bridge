local boxZones = {}


function it.createBoxZone()


end


function it.removeBoxZone()

end

exports("createBoxZone", function(zoneData)
    local callerResource = GetInvokingResource()

    -- Check of boxZone already exists for this resource
    if boxZones[callerResource].zoneData.id then
        it.print.warn("BoxZone already exists for resource: " .. callerResource)
        return
    end
end)
function it.sendDisptach(playerId, disptachData)

    if it.disptach == Dispatches.NONE then
        it.print.error("No dispatch type set.")
        return
    end

    if it.dispatch == Dispatches.QS then
        local qsDispatchData = {
            job = disptachData.jobs,
            callLocation = vec3(disptachData.coords.x, disptachData.coords.y, disptachData.coords.z),
            callCode = { code = disptachData.callCode.code, snippet = disptachData.callCode.snippet },
            message = disptachData.message,
            flashes = disptachData.flashes,
            image = disptachData.image,
            blip = {
                sprite = disptachData.blip.sprite,
                scale = disptachData.blip.scale,
                colour = disptachData.blip.colour,
                flashes = disptachData.blip.flashes,
                text = disptachData.blip.text,
                time = disptachData.blip.time,
            },
        }
        TriggerEvent('qs-dispatch:client:sendDispatch', qsDispatchData)
    end

    if it.disptach == Dispatches.PS then
        local psDisptachData = {
            message = disptachData.message,
            codeName = 'NONE',
            code = disptachData.callCode.code,
            displayCode = disptachData.callCode.code,
            icon = 'fas fa-question',
            priority = 1,
            coords = vector3(disptachData.coords.x, disptachData.coords.y, disptachData.coords.z),
            origin = vector3(disptachData.coords.x, disptachData.coords.y, disptachData.coords.z),
            job = disptachData.job,
            jobList = disptachData.jobs,
            recipientList = disptachData.jobs,
            jobs = disptachData.jobs,
            description = disptachData.message,
            alert = {
                jobList = disptachData.jobs,
                recipientList = disptachData.jobs,
                jobs = disptachData.jobs,
                description = disptachData.message,
                displayCode = disptachData.callCode.code,
                sprite = disptachData.blip.sprite,
                colour = disptachData.blip.colour,
                scale = disptachData.blip.scale,
                text = disptachData.blip.text,
                radius = disptachData.blip.radius,
                offset = false,
                flash = disptachData.blip.flashes,
                time = disptachData.blip.time,
            }
        }

        if DoesExportExist(Dispatches.PS, "CreateDispatchCall") then
            exports[Dispatches.PS]:CreateDispatchCall(psDisptachData, playerId)
        else
            it.print.error('Dispatches.PS does not have the CreateDispatchCall export.')
        end
    end

    if it.dispatch == Dispatches.CD then
        TriggerClientEvent('it_bridge:client:sendDispatch', playerId, disptachData)
    end

    if it.dispatch == Dispatches.CODEM then
        local codemDisptachData = {
            type = 'dispatch',
            header = disptachData.title,
            text = disptachData.message,
            code = disptachData.callCode.code,
        }
    end

    if it.dispatch == Dispatches.LOVE_SCRIPTS then
        for _, jobName in pairs(disptachData.jobs) do

            TriggerEvent('emergencydispatch:emergencycall:new', jobName, disptachData.message, vector3(disptachData.coords.x, disptachData.coords.y, disptachData.coords.z), true)
        end
    end


    if it.disptach == Dispatches.ORIGEN then
        for _, jobName in pairs(disptachData.jobs) do
            exports['origen_police']:SendAlert({
                coords = vector3(disptachData.coords.x, disptachData.coords.y, disptachData.coords.z),
                title = disptachData.title,
                type = 'GENERAL',
                message = disptachData.message,
                job = jobName,
            })
        end
    end

    if it.dispatch == STANDALONE then
        -- TODO: Here you can add your own dispatch system
    end

end

RegisterNetEvent('it_bridge:server:sendDispatch', function(disptachData)
    it.sendDisptach(source, disptachData)
end)

exports('SendDisptach', function(playerId, disptachData)
    it.sendDisptach(playerId, disptachData)
end)
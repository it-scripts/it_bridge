lib.addCommand('bridgeBoxZone', {
    help = 'Test Bridge target export',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
    },
}, function(source, args, raw)
    local target = args.target

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    TriggerClientEvent('bridge_tester:client:targetZoneTest', target)
    it.print.info('Spawned new target zone in front of the player', target, 'for the next 15 seconds')
end)

lib.addCommand('targetEntity', {
    help = 'Test Bridge target export',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
    },
}, function(source, args, raw)
    local target = args.target

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    TriggerClientEvent('bridge_tester:client:targetEntityTest', target)
    it.print.info('Spawned new target entity in front of the player', target, 'for the next 15 seconds')
end)

lib.addCommand('globalPedTest', {
    help = 'Test Bridge target export',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
    },
}, function(source, args, raw)
    local target = args.target

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    TriggerClientEvent('bridge_tester:client:globalPedTest', target)
    it.print.info('Created a global ped target for the player', target, 'for the next 15 seconds (Interact was added to every ped)')
end)

lib.addCommand('globalPlayer', {
    help = 'Test Bridge target export',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
    },
}, function(source, args, raw)
    local target = args.target

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    TriggerClientEvent('bridge_tester:client:globalPlayerTest', target)
    it.print.info('Created a global player target for the player', target, 'for the next 15 seconds (Interact was added to every player)')
end)

lib.addCommand('globalVehicleTest', {
    help = 'Test Bridge target export',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
    },
}, function(source, args, raw)
    local target = args.target

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    TriggerClientEvent('bridge_tester:client:globalVehicleTest', target)
    it.print.info('Created a global vehicle target for the player', target, 'for the next 15 seconds (Interact was added to every vehicle)')
end)

lib.addCommand('modelTest', {
    help = 'Test Bridge target export',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
        },
    },
}, function(source, args, raw)
    local target = args.target

    if source ~= 0 then
        lib.print.error('This command can only be executed from the server console')
        return
    end

    TriggerClientEvent('bridge_tester:client:modelTest', target)
    it.print.info('Spawned new target model in front of the player', target, 'for the next 15 seconds')
end)
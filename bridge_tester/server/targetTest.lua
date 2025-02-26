lib.addCommand('bridgeTestModelTarget', {
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


    TriggerClientEvent('bridge_tester:client:modelTargetTest', target)
end)

lib.addCommand('bridgeTestGlobalped', {
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
end)
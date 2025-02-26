lib.addCommand('bridgeTestMenu', {
    help = 'Test Bridge Menu export',
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


    TriggerClientEvent('bridge_tester:client:menuTest', target)
end)
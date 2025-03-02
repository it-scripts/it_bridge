lib.addCommand('textUITest', {
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

    TriggerClientEvent('brigde_tester:client:textUITest', target)
end)
RegisterNetEvent('bridge_tester:client:notifyTest', function(args)
    exports.it_bridge:SendNotification(args.title, args.message, args.duration, args.type, args.sound)
end)


RegisterNetEvent('bridge_tester:client:menuTest', function()
    exports.it_bridge:OpenMenu({
        id = 'test_menu',
        title = 'Test Menu',
        options = {
            {
                title = 'Send Success Notify',
                description = 'Send a success notification',
                icon = 'fas fa-check',
                onSelect = function()
                    exports.it_bridge:SendNotification('Success', 'This is a success notification', 5000, 'Success', false)
                end,
                params = {
                    event = 'bridge_tester:client:notifyTest',
                    args = {
                        title = 'Success',
                        message = 'This is a success notification',
                        duration = 5000,
                        type = 'Success',
                        sound = false
                    }
                }
            },
            {
                title = 'Send Error Notify',
                description = 'Send an error notification',
                icon = 'fas fa-times',
                onSelect = function()
                    exports.it_bridge:SendNotification('Error', 'This is an error notification', 5000, 'Error', false)
                end,
                params = {
                    event = 'bridge_tester:client:notifyTest',
                    args = {
                        title = 'Error',
                        message = 'This is an error notification',
                        duration = 5000,
                        type = 'Error',
                        sound = false
                    }
                }
            },
            {
                title = 'Send Info Notify',
                description = 'Send an info notification',
                icon = 'fas fa-info',
                onSelect = function()
                    exports.it_bridge:SendNotification('Info', 'This is an info notification', 5000, 'Info', false)
                end,
                params = {
                    event = 'bridge_tester:client:notifyTest',
                    args = {
                        title = 'Info',
                        message = 'This is an info notification',
                        duration = 5000,
                        type = 'Info',
                        sound = false
                    }
                }
            },
            {
                title = 'Send Warning Notify',
                description = 'Send an Warning notification',
                icon = 'fas fa-exclamation-triangle',
                onSelect = function()
                    exports.it_bridge:SendNotification('Warning', 'This is an Warning notification', 5000, 'Warning', false)
                end,
                params = {
                    event = 'bridge_tester:client:notifyTest',
                    args = {
                        title = 'Warning',
                        message = 'This is a warning notification',
                        duration = 5000,
                        type = 'Warning',
                        sound = false
                    }
                }
            },
            {
                title = 'Disabled Button',
                description = 'This button is disabled',
                icon = 'fas fa-ban',
                disabled = true,
            }
        }
    })
end)
RegisterNetEvent('brigde_tester:client:textUITest', function()

    local options = {
        position = 'left',
        icon = 'fas fa-car',
        iconAnimation = 'bounce',
        type = 'success',
        playSound = false,
    }
    exports.it_bridge:ShowTextUI('Test Success TextUI', options)
    Wait(5000)
    exports.it_bridge:CloseTextUI('Test Success TextUI')

    Wait(100)
    options.type = 'info'
    exports.it_bridge:ShowTextUI('Test Info TextUI', options)
    Wait(5000)
    exports.it_bridge:CloseTextUI('Test Info TextUI')

    Wait(100)
    options.type = 'error'
    exports.it_bridge:ShowTextUI('Test Error TextUI', options)
    Wait(5000)
    exports.it_bridge:CloseTextUI('Test Error TextUI')
end)
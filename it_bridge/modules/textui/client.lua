function it.showTextUI(text, options)

    if it.textui == TextUI.NONE then
        return
    end

    if it.textui == TextUI.OX then
        local oxPosition = options.position == 'right' and 'right-center' or 'left-center'
        lib.showTextUI(text, {
            position = oxPosition,
            icon = options.icon,
            iconAnimation = options.iconAnimation,
        })

    end

    if it.textui == TextUI.QBCORE then
        exports['qb-core']:DrawText(text, options.position)
    end

    if it.textui == TextUI.ESX then
        CoreObject.TextUI(text, options.type)
    
    end

    if it.textui == TextUI.OKOK then

        local okokColor = options.color == 'success' and 'darkgreen' or options.color == 'info' and 'darkblue' or options.color == 'error' and 'darkred' or 'darkgrey'
        exports['okokTextUI']:Open(text, okokColor, options.position, options.playSound)
    end

    it.print.error('[showTextUI] - There was an issue showing the text UI.')
end

function it.closeTextUI(text)

    if it.textui == TextUI.NONE then
        return
    end

    if it.textui == TextUI.OX then
        local isOpen, uiText = lib.isTextUIOpen()
        if isOpen then
            if uiText == text then
                lib.closeTextUI()
            end
        end
    end

    if it.textui == TextUI.QBCORE then
        exports['qb-core']:HideText()
    end

    if it.textui == TextUI.ESX then
        CoreObject.HideUI()
    end

    if it.textui == TextUI.OKOK then
        exports['okokTextUI']:Close()
    end

    it.print.error('[closeTextUI] - There was an issue closing the text UI.')
end

exports('ShowTextUI', function(text, options)
    it.showTextUI(text, options)
end)

exports('CloseTextUI', function(text)
    it.closeTextUI(text)
end)
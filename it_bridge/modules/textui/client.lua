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
        return true
    end

    if it.textui == TextUI.QBCORE then
        exports['qb-core']:DrawText(text, options.position)
        return true
    end

    if it.textui == TextUI.ESX then
        CoreObject.TextUI(text, options.type)
        return true
    end

    if it.textui == TextUI.OKOK then

        local okokColor = options.type == 'success' and 'darkgreen' or options.type == 'info' and 'darkblue' or options.type == 'error' and 'darkred' or 'darkgrey'
        exports['okokTextUI']:Open(text, okokColor, options.position, options.playSound)
        return true
    end

    it.print.error('[showTextUI] - There was an issue showing the text UI.')
    return false
end

function it.closeTextUI(text)

    if it.textui == TextUI.NONE then
        return
    end

    if it.textui == TextUI.OX then
        local isOpen, uiText = lib.isTextUIOpen()
        if isOpen then
            if text == nil then
                lib.hideTextUI()
                return true
            end
            if uiText == text then
                lib.hideTextUI()
                return true
            end
        end
    end

    if it.textui == TextUI.QBCORE then
        exports['qb-core']:HideText()
        return true
    end

    if it.textui == TextUI.ESX then
        CoreObject.HideUI()
        return true
    end

    if it.textui == TextUI.OKOK then
        exports['okokTextUI']:Close()
        return true
    end

    it.print.error('[closeTextUI] - There was an issue closing the text UI.')
    return false
end

exports('ShowTextUI', function(text, options)
    it.showTextUI(text, options)
end)

exports('CloseTextUI', function(text)
    it.closeTextUI(text)
end)
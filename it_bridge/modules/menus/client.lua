function it.openMenu(menuData)

    if it.menu == Menus.ESX_CONTEXT then
        local elements = {}
        for _, optionData in pairs(menuData.options) do
            table.insert(elements, {
                unselectable = optionData.readOnly,
                icon = optionData.icon,
                title = optionData.title,
                description = optionData.description,
                disabled = optionData.disabled,
            })
        end

        CoreObject.OpenContext("left", elements, function(menu, element)
            local elementName = element.title
            for _, data in pairs(menuData.options) do
                if data.title == elementName then
                    data.onSelect()
                    CoreObject.CloseContext()
                    break
                end
            end
        end, function(menu)
            if menuData.onBack then
                menuData.onBack()
            end
        end)
    end

    if it.menu == Menus.OX then
        local options = {}
        for _, optionData in pairs(menuData.options) do
            table.insert(options, {
                title = optionData.title,
                disabled = optionData.disabled,
                readOnly = optionData.readOnly,
                onSelect = optionData.onSelect,
                icon = optionData.icon,
                progress = optionData.progress,
                colorScheme = optionData.colorScheme,
                arrow = optionData.arrow,
                description = optionData.description,
                image = optionData.image,
                metadata = optionData.metadata,
            })

            lib.registerContext({
                id = menuData.id,
                title = menuData.title,
                menu = menuData.menu,
                onBack = menuData.onBack,
                options = options,
            })

            lib.showContext(menuData.id)
        end
    end

    if it.menu == Menus.QB then
        local options = {}
        for _, optionData in pairs(menuData.options) do
            table.insert(options, {
                isMenuHeader = optionData.readOnly,
                header = optionData.title,
                txt = optionData.description,
                icon = optionData.icon,
                params = optionData.params,
                disabled = optionData.disabled,
            })
        end

        -- Check if the exprots exsits
        if DoesExportExist(Menus.QB, "openMenu") then
            exports[Menus.QB]:openMenu(options)
        else
            it.print.error("The export does not exist")
        end
    end
end

exports("OpenMenu", function(menuData)
    it.openMenu(menuData)
end)
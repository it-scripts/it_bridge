--== VERSION CHECK ==--

-- pars the jason code to a table
local function parseJson(data)
    local decodedData = json.decode(data)
    return decodedData
end

local updatePath = nil
local identifier = GetResourceMetadata(GetCurrentResourceName(), "identifier", 0)
local version = CURRENT_VERSION
local remoteVersionFile = nil

local function checkResourceVersion(err, responseText, headers)

    local framework = '^8NONE'
    if it.framework then
        framework = it.framework
    end
    local inventory = '^8NONE'
    if it.inventory then
        inventory = it.inventory
    end
    local interaction = '^8NONE'
    if it.interaction then
        interaction = it.interaction
    end
    local menu = '^8NONE'
    if it.menu then
        menu = it.menu
    end
    local notify = '^8NONE'
    if it.notify then
        notify = it.notify
    end
    local textui = '^8NONE'
    if it.textui then
        textui = it.textui
    end
    local distpach = '^8NONE'
    if it.dispatch then
        distpach = it.dispatch
    end

    if Config.MinimizeStartup == nil then
        it.print.error("Please set the Config.MinimizeStartup to true or false in config.lua")
        Config.MinimizeStartup = true
        return
    end

    if Config.MinimizeStartup == true then
        print('^5═════════════════════════════════════════════════════════════^7')
        print('^6██╗████████╗     ██████╗ ██████╗ ██╗██████╗  ██████╗ ███████╗^7')
        print('^6██║╚══██╔══╝     ██╔══██╗██╔══██╗██║██╔══██╗██╔════╝ ██╔════╝^7')
        print('^6██║   ██║        ██████╔╝██████╔╝██║██║  ██║██║  ███╗█████╗^7')
        print('^6██║   ██║        ██╔══██╗██╔══██╗██║██║  ██║██║   ██║██╔══╝^7')
        print('^6██║   ██║███████╗██████╔╝██║  ██║██║██████╔╝╚██████╔╝███████╗^7')
        print('^6╚═╝   ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚══════╝^7')
        print('^5═════════════════════════════════════════════════════════════^7')
        print(' ')
        print('         ^6Discord > https://discord.it-scripts.com')
        print('         ^6GitHub > https://github.it-scripts.com')
        print('         ^6Tebex > https://it-scripts.tebex.io')
        print(' ')
        print('^5═════════════════════════[ Settings ]════════════════════════^7')
        print(' ')
        print('         ^6[1] - Framework:    ^2'..framework)
        print('         ^6[2] - Inventory:    ^2'..inventory)
        print('         ^6[3] - Interaction:  ^2'..interaction)
        print('         ^6[4] - Menu:         ^2'..menu)
        print('         ^6[5] - Notification: ^2'..notify)
        print('         ^6[5] - TextUI:       ^2'..textui)
        print('         ^6[6] - Distpach:     ^2'..distpach)
        print(' ')
    end

    remoteVersionFile = parseJson(responseText)
    if responseText == nil or remoteVersionFile == nil then
        print('^5═════════════════════[ Version Check ]═══════════════════════^7')
        print(' ')
        print('         ^8ERROR: ^0Failed to check for update.')
        print(' ')
        print("^5═════════════════════════════════════════════════════════════^7")
        return
    end
    if version >= remoteVersionFile.version then
        print('^5═════════════════════[ Version Check ]═══════════════════════^7')
        print(' ')
        print("         ^2[it_bridge] - The Script is up to date!")
        print("         ^7Current Version: ^4" .. version .. "^7.")
        print(' ')
        print("^5═════════════════════════════════════════════════════════════^7")
        return
    end

    print('^5═════════════════════[ Version Check ]═══════════════════════^7')
    print('         ^8[it_bridge] - New update available now!')
    print('         ^7Current Version: ^4'..version..'^7.')
    print('         ^7New Version: ^4'..remoteVersionFile.version..'^7.')
    print('         ^7Update Message: ^4' ..remoteVersionFile.message.. '^7.')
    print(' ')
    print('         ^4Download it now on https://keymaster.fivem.net')
    print("^5═════════════════════════════════════════════════════════════^7")
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(3000)
        updatePath = "it-scripts/it-updates"
        PerformHttpRequest("https://raw.githubusercontent.com/"..updatePath.."/main/"..identifier.."/version", checkResourceVersion, "GET")
    end
end)

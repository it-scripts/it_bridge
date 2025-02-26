--== VERSION CHECK ==--

-- pars the jason code to a table
local function parseJson(data)
    local decodedData = json.decode(data)
    return decodedData
end

local updatePath = nil
local identifier = GetResourceMetadata(GetCurrentResourceName(), "identifier", 0)
local version = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
local remoteVersionFile = nil

local function checkResourceVersion(err, responseText, headers)
    remoteVersionFile = parseJson(responseText)
    if responseText == nil or remoteVersionFile == nil then
        print("^5======================================^7")
        print(' ')
        print('^8ERROR: ^0Failed to check for update.')
        print(' ')
        print("^5======================================^7")
        return
    end
    if version >= remoteVersionFile.version then
        print("^5======================================^7")
        print("^2[it_bridge] - The Script is up to date!")
        print("^7Current Version: ^4" .. remoteVersionFile.version .. "^7.")
        print("^5======================================^7")
        return
    end

    print("^5======================================^7")
    print('^8[it_bridge] - New update available now!')
    print('^7Current Version: ^4'..version..'^7.')
    print('^7New Version: ^4'..remoteVersionFile.version..'^7.')
    print('^7Update Message: ^4' ..remoteVersionFile.message.. '^7.')
    print(' ')
    print('^4Download it now on http://keymaster.fivem.net')
    print("^5======================================^7")
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(3000)
        updatePath = "it-scripts/it-updates"
        PerformHttpRequest("https://raw.githubusercontent.com/"..updatePath.."/main/"..identifier.."/version", checkResourceVersion, "GET")
    end
end)

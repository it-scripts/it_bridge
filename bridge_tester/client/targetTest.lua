local model = 'prop_protest_table_01'

local options = {
    {
        label = 'Test',
        name = 'bridge_tester_test_one',
        icon = 'fas fa-clipboard',
        canInteract = function(entity, distance)
            return true
        end,
        onSelect = function(entity)
            exports.it_bridge:SendNotification('bridge_tester', 'You tested a target interaction', 'Success', 5000)
        end,
        distance = 1.5
    },
    {
        label = 'Test 2',
        name = 'bridge_tester_test_two',
        icon = 'fas fa-clipboard',
        canInteract = function(entity, distance)
            return true
        end,
        onSelect = function(entity)
            exports.it_bridge:SendNotification('bridge_tester', 'You tested a target interaction', 'Success', 5000)
        end,
        distance = 1.5
    },
}


RegisterNetEvent('bridge_tester:client:targetZoneTest', function()
    lib.requestModel(model)

    local min, max = GetModelDimensions(model)
    -- Calculate prop dimensions
    local size = vector3(max.x - min.x, max.y - min.y, max.z - min.z)

    -- Get coords infront of player
    local coords = GetEntityCoords(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    local forwardCoords = coords + forward * 2.0

    -- Get ground Z
    local _ , groundZ = GetGroundZFor_3dCoord(forwardCoords.x, forwardCoords.y, forwardCoords.z, false)

    -- Create object
    local obj = CreateObject('prop_protest_table_01', forwardCoords.x, forwardCoords.y, groundZ, true, true, true)
    FreezeEntityPosition(obj, true)
    SetEntityAsMissionEntity(obj, true, true)

    local objCoords = GetEntityCoords(obj)
    local objHeading = GetEntityHeading(obj)

    if exports.it_bridge:GetServerInteraction() == 'qb-target' then
        objHeading = objHeading + 90.0
    end
    -- Create target
    local boxData = {
        id = 'bridge_tester_zone_test',
        coords = vector3(objCoords.x, objCoords.y, objCoords.z),
        rotation = objHeading,
        size = size, --extendedTableData.target.size or vector3(1.0, 1.0, 1.0),
        drawSprite = true,
        interactDistance = 1.5,
        minZ = objCoords.z - 0.5,
        maxZ = objCoords.z + (size.z / 2),
        debug = true
    }

    local target = exports.it_bridge:CreateBoxZone(boxData, options)

    Wait(15000)

    exports.it_bridge:RemoveBoxZone(target)
    DeleteEntity(obj)
    SetModelAsNoLongerNeeded('prop_protest_table_01')
end)

RegisterNetEvent('bridge_tester:client:targetEntityTest', function()
    lib.requestModel(model)
    -- Get coords infront of player
    local coords = GetEntityCoords(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    local forwardCoords = coords + forward * 2.0

    -- Get ground Z
    local _ , groundZ = GetGroundZFor_3dCoord(forwardCoords.x, forwardCoords.y, forwardCoords.z, false)

    -- Create object
    local obj = CreateObject('prop_protest_table_01', forwardCoords.x, forwardCoords.y, groundZ, true, true, true)
    SetEntityAsMissionEntity(obj, true, true)

    -- Get NetID
    local netId = NetworkGetNetworkIdFromEntity(obj)

    -- Create target
    local createdOptions = exports.it_bridge:AddTargetEntity(netId, options)

    Wait(15000)

    exports.it_bridge:RemoveTargetEntity(netId, createdOptions)

    -- Delete object
    DeleteEntity(obj)
    SetModelAsNoLongerNeeded('prop_protest_table_01')
end)

RegisterNetEvent('bridge_tester:client:globalPedTest', function()

    local createdOptions = exports.it_bridge:AddGlobalPed(options)

    Wait(15000)

    exports.it_bridge:RemoveGlobalPed(createdOptions)
end)

RegisterNetEvent('bridge_tester:client:globalPlayerTest', function()

    local createdOptions = exports.it_bridge:AddGlobalPlayer(options)

    Wait(15000)

    exports.it_bridge:RemoveGlobalPlayer(createdOptions)
end)

RegisterNetEvent('bridge_tester:client:globalVehicleTest', function()

    local createdOptions = exports.it_bridge:AddGlobalVehicle(options)

    Wait(15000)

    exports.it_bridge:RemoveGlobalVehicle(createdOptions)
end)

RegisterNetEvent('bridge_tester:client:modelTest', function()
    lib.requestModel(model)
    -- Get coords infront of player
    local coords = GetEntityCoords(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    local forwardCoords = coords + forward * 2.0

    -- Get ground Z
    local _ , groundZ = GetGroundZFor_3dCoord(forwardCoords.x, forwardCoords.y, forwardCoords.z, false)

    -- Create object
    local obj = CreateObject('prop_protest_table_01', forwardCoords.x, forwardCoords.y, groundZ, true, true, true)
    SetEntityAsMissionEntity(obj, true, true)

    -- Create target
    local createdOptions = exports.it_bridge:AddTargetModel('prop_protest_table_01', options)

    Wait(15000)

    exports.it_bridge:RemoveTargetModel('prop_protest_table_01', createdOptions)

    -- Delete object
    DeleteEntity(obj)
    SetModelAsNoLongerNeeded('prop_protest_table_01')
end)
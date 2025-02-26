RegisterNetEvent('bridge_tester:client:targetZoneTest', function()
end)

RegisterNetEvent('bridge_tester:client:modelTargetTest', function()

    lib.requestModel('prop_protest_table_01')
    local coords = GetEntityCoords(PlayerPedId())
    local _ , groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
    local obj = CreateObject('prop_protest_table_01', coords.x, coords.y, groundZ, true, true, true)
    SetEntityAsMissionEntity(obj, true, true)

    local target = exports.it_bridge:CreateTargetModel('prop_protest_table_01', {
        {
            label = 'Test',
            name = 'bridge_tester_test',
            icon = 'fas fa-clipboard',
            canOxInteract = function(entity, distance, coords, name, bone)
                return true
            end,
            canQbInteract = function(entity, distance, data)
                return true
            end,
            onOxSelect = function(data)
                print('Test OX')
            end,
            onQbInteract = function(entity)
                print('Test QB')
            end,
            distance = 1.5
        },
        {
            label = 'Remove Model',
            name = 'bridge_tester_remove',
            icon = 'fas fa-clipboard',
            canOxInteract = function(entity, distance, coords, name, bone)
                return true
            end,
            canQbInteract = function(entity, distance, data)
                return true
            end,
            onOxSelect = function(data)
                print('Remove OX')
            end,
            onQbInteract = function(entity)
                DeleteEntity(entity)
            end,
            distance = 1.5
        }
    })

    Wait(10000)

    exports.it_bridge:RemoveTargetModel('prop_protest_table_01')
    SetModelAsNoLongerNeeded('prop_protest_table_01')
end)


RegisterNetEvent('bridge_tester:client:globalPedTest', function()
    local target = exports.it_bridge:CreateGlobalPed({
        {
            label = 'Test',
            name = 'bridge_tester_test',
            icon = 'fas fa-clipboard',
            canOxInteract = function(entity, distance, coords, name, bone)
                return true
            end,
            canQbInteract = function(entity, distance, data)
                return true
            end,
            onOxSelect = function(data)
                print('Test OX')
            end,
            onQbInteract = function(entity)
                print('Test QB')
            end,
            distance = 1.5
        },
    })

    Wait(10000)

    exports.it_bridge:RemoveGlobalPed(target)
end)
--[[ local playerDataModel = {
    identifier = 'string',
    name = 'string',
    firstName = 'string',
    lastName = 'string',
    dateOfBirth = 'string',
    sex= 'number',
    source = 'number',
    money = {
        cash = 'number',
        bank = 'number',
        black_money = 'number',
    },
} ]]

function it.getPlayerData(source)
    local player = it.getPlayer(source)

    if not player then
        lib.print.error('[getPlayerData] No player object found')
        return nil
    end

    if it.framework == Framework.ESX then
        return {
            identifier = player.identifier,
            name = player.name,
            firstName = player.firstName,
            lastName = player.lastName,
            dateOfBirth = player.dateofbirth,
            sex = player.sex,
            source = player.source,
            money = {
                cash = it.getMoney(source, MoneyTypes['cash'][Framework.ESX]),
                bank = it.getMoney(source, MoneyTypes['bank'][Framework.ESX]),
                black_money = it.getMoney(source, MoneyTypes['black_money'][Framework.ESX]),
            }
        }
    end

    if it.framework == Framework.QBCore then
        return {
            identifier = player.PlayerData.citizenid,
            name = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname,
            firstName = player.PlayerData.charinfo.firstname,
            lastName = player.PlayerData.charinfo.lastname,
            dateOfBirth = player.PlayerData.charinfo.birthdate,
            sex = player.PlayerData.charinfo.gender,
            source = source,
            money = {
                cash = it.getMoney(source, MoneyTypes['cash'][Framework.QBCore]),
                bank = it.getMoney(source, MoneyTypes['bank'][Framework.QBCore]),
                black_money = it.getMoney(source, MoneyTypes['black_money'][Framework.QBCore]),
            }
        }
    end

    if it.framework == Framework.QBOX then
        return {
            identifier = player.PlayerData.citizenid,
            name = player.PlayerData.name,
            firstName = player.PlayerData.charinfo.firstname,
            lastName = player.PlayerData.charinfo.lastname,
            dateOfBirth = player.PlayerData.charinfo.birthdate,
            sex = player.PlayerData.charinfo.gender,
            source = source,
            money = {
                cash = it.getMoney(source, MoneyTypes['cash'][Framework.QBOX]),
                bank = it.getMoney(source, MoneyTypes['bank'][Framework.QBOX]),
                black_money = it.getMoney(source, MoneyTypes['black_money'][Framework.QBOX]),
            }
        }
    end

    if it.framework == Framework.NDCore then
        return {
            identifier = player.identifier,
            name = player.name,
            firstName = player.firstName,
            lastName = player.lastName,
            dateOfBirth = player.dob,
            sex = player.gender,
            source = player.source,
            money = {
                cash = it.getMoney(source, MoneyTypes['cash'][Framework.NDCore]),
                bank = it.getMoney(source, MoneyTypes['bank'][Framework.NDCore]),
                black_money = it.getMoney(source, MoneyTypes['black_money'][Framework.NDCore]),
            }
        }
    end

    lib.print.error('[getPlayerData] Unsupported framework')
    return nil
end

exports('GetPlayerData', function(source)
    return it.getPlayerData(source)
end)
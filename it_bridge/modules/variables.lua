it = setmetatable({
    name = 'it_bridge',
    context = IsDuplicityVersion() and "server" or "client",
}, {
    __nexindex = function(self, name, fn)
        rawset(self, name, fn)
    end
})

cache = {
    resource = GetResourceMetadata(it.name, 'identifier', 0),
    game = GetGameName();
    version = GetResourceMetadata(it.name, 'version', 0),
}

CURRENT_VERSION = '1.0.8'

STANDALONE = 'standalone'
AUTO_DETECT = 'auto-detect'

Framework = {
    ESX = 'es_extended',
    QBCore = 'qb-core',
    QBOX = 'qbx_core',
    NDCore = 'ND_Core',
}

Inventories = {
    ESX = 'es_extended',
    QB = 'qb-inventory',
    PS = 'ps-inventory',
    QS = 'qs-inventory',
    OX = 'ox_inventory',
    CODEM = 'codem-inventory',
    ORIGEN = 'origen_inventory',
    RC2 = 'Rc2-inventory',
    TGIANN = 'tgiann-inventory',
}

Interactions = {
    OX = 'ox_target',
    QB = 'qb-target',
    NONE = nil,
}

Notifications = {
    BRUTAL = 'brutal_notify',
    OX = 'ox_lib',
    ESX_NOTIFY = 'esx_notify',
    QBCORE = 'qb-core',
    QBOX = 'qbx_core',
    ESX = 'es_extended',
    MYTHIC = 'mythic_notify',
    OKOK = 'okokNotify',
}

TextUI = {
    OX = 'ox_lib',
    QBCORE = 'qb-core',
    ESX = 'esx_textui',
    OKOK = 'okokTextUI',
    NONE = nil,
}

Menus = {
    ESX_CONTEXT = 'esx_context',
    OX = 'ox_lib',
    QB = 'qb-menu',
}

Dispatches = {
    QS = 'qs-dispatch',
    PS = 'ps-dispatch',
    CD = 'cd_disaptch',
    CORE = 'core_dispatch',
    CODEM = 'codem_dispatch',
    LOVE_SCRIPTS = 'emergency_dispatch',
    ORIGEN = 'origen_police',
    PIOTREQ = 'piotreq_gpt',
    NONE = nil,
}
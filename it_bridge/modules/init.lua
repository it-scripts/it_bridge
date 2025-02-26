-- Functions to detect the config values
-- ┌──────────────────────────────────────────────────────────────┐
-- │ _____ ____      _    __  __ _______        _____  ____  _  __│
-- │|  ___|  _ \    / \  |  \/  | ____\ \      / / _ \|  _ \| |/ /│
-- │| |_  | |_) |  / _ \ | |\/| |  _|  \ \ /\ / / | | | |_) | ' / │
-- │|  _| |  _ <  / ___ \| |  | | |___  \ V  V /| |_| |  _ <| . \ │
-- │|_|   |_| \_\/_/   \_\_|  |_|_____|  \_/\_/  \___/|_| \_\_|\_\│
-- └──────────────────────────────────────────────────────────────┘
--- Detect the framework that is used by the server
---
--- @return table | nil
local function detectFramework()
    local function detectESX()
        if GetResourceState('es_extended') == 'started' then
            local esx = exports['es_extended']:getSharedObject()
            if esx then
                it.framework = Framework.ESX
                return esx
            end
        end
    end

    local function detectQBCore()
        if GetResourceState('qb-core') == 'started' then
            local qbCore = exports['qb-core']:GetCoreObject()
            if qbCore then
                it.framework = Framework.QBCore
                return qbCore
            end
        end
    end

    local function detectQBOX()
        if GetResourceState('qbx_core') == 'started' then
            it.framework = Framework.QBOX
            return Framework.QBOX
        end
    end

    local function detectNDCore()
        if GetResourceState('ND_Core') == 'started' then
            local ndCore = exports['ND_Core']:GetCoreObject()
            if ndCore then
                it.framework = Framework.NDCore
                return ndCore
            end
        end
    end

    if Config.Framework == AUTO_DETECT then
        local core = detectQBOX() or detectNDCore() or detectESX() or detectQBCore() or STANDALONE
        if core == STANDALONE then
            it.print.warn('[it_bridge] No framework was detected, you will need to integrate it!')
            return
        else
            return core
        end
    end

    if Config.Framework == Framework.ESX then
        local esx = detectESX()
        if not esx then
            it.print.error('[it_bridge] ESX was selected as the framework, but the resource was not found or not started!')
            return
        end
        return esx
    end

    if Config.Framework == Framework.QBCore then
        local qbCore = detectQBCore()
        if not qbCore then
            it.print.error('[it_bridge] QB-Core was selected as the framework, but the resource was not found or not started!')
            return
        end
        return qbCore
    end

    if Config.Framework == Framework.QBOX then
        local qbox = detectQBOX()
        if not qbox then
            it.print.error('[it_bridge] QBX-Core was selected as the framework, but the resource was not found or not started!')
            return
        end
        return qbox
    end

    if Config.Framework == Framework.NDCore then
        local ndCore = detectNDCore()
        if not ndCore then
            it.print.error('[it_bridge] ND-Core was selected as the framework, but the resource was not found or not started!')
            return
        end
        return ndCore
    end
    it.print.error(string.format('[it_bridge] The framework %s is not supported!', framework))
end

-- ┌─────────────────────────────────────────────────────┐
-- │ ___ _   ___     _______ _   _ _____ ___  ______   __│
-- │|_ _| \ | \ \   / / ____| \ | |_   _/ _ \|  _ \ \ / /│
-- │ | ||  \| |\ \ / /|  _| |  \| | | || | | | |_) \ V / │
-- │ | || |\  | \ V / | |___| |\  | | || |_| |  _ < | |  │
-- │|___|_| \_|  \_/  |_____|_| \_| |_| \___/|_| \_\|_|  │
-- └─────────────────────────────────────────────────────┘
--- Detect the inventory that is used by the server
--- @return table | nil
local function detectInventory()
    local function detectPS()
        if GetResourceState('ps-inventory') == 'started' then
            it.inventory = Inventories.PS
            return Inventories.PS
        end
    end

    local function detectQS()
        if GetResourceState('qs-inventory') == 'started' then
            it.inventory = Inventories.QS
            return Inventories.QS
        end
    end

    local function detectOX()
        if GetResourceState('ox_inventory') == 'started' then
            it.inventory = Inventories.OX
            return Inventories.OX
        end
    end

    local function detectCODEM()
        if GetResourceState('codem-inventory') == 'started' then
            it.inventory = Inventories.CODEM
            return Inventories.CODEM
        end
    end

    local function detectORIGEN()
        if GetResourceState('origen-inventory') == 'started' then
            it.inventory = Inventories.ORIGEN
            return Inventories.ORIGEN
        end
    end

    local function detectESX()
        if GetResourceState('es_extended') == 'started' then
            it.inventory = Inventories.ESX
            return Inventories.ESX
        end
    end

    local function detectQB()
        if GetResourceState('qb-inventory') == 'started' then
            it.inventory = Inventories.QB
            return Inventories.QB
        end
    end

    if Config.Inventories == AUTO_DETECT then
        local inventory = detectPS() or detectQS() or detectOX() or detectCODEM() or detectORIGEN() or detectESX() or detectQB() or STANDALONE
        if inventory == STANDALONE then
            it.print.warn('[it_bridge] No inventory was detected, you will need to integrate it!')
            return
        else
            return inventory
        end
    end

    if Config.Inventories == Inventories.ESX then
        local esx = detectESX()
        if not esx then
            it.print.error('[it_bridge] ESX was selected as the inventory, but the resource was not found or not started!')
            return
        end
        return esx
    end

    if Config.Inventories == Inventories.QB then
        local qbInventory = detectQB()
        if not qbInventory then
            it.print.error('[it_bridge] QB-Inventory was selected as the inventory, but the resource was not found or not started!')
            return
        end
        return qbInventory
    end

    if Config.Inventories == Inventories.PS then
        local psInventory = detectPS()
        if not psInventory then
            it.print.error('[it_bridge] PS-Inventory was selected as the inventory, but the resource was not found or not started!')
            return
        end
        return psInventory
    end

    if Config.Inventories == Inventories.QS then
        local qsInventory = detectQS()
        if not qsInventory then
            it.print.error('[it_bridge] QS-Inventory was selected as the inventory, but the resource was not found or not started!')
            return
        end
        return qsInventory
    end

    if Config.Inventories == Inventories.OX then
        local oxInventory = detectOX()
        if not oxInventory then
            it.print.error('[it_bridge] OX-Inventory was selected as the inventory, but the resource was not found or not started!')
            return
        end
        return oxInventory
    end

    if Config.Inventories == Inventories.CODEM then
        local codemInventory = detectCODEM()
        if not codemInventory then
            it.print.error('[it_bridge] CODEM-Inventory was selected as the inventory, but the resource was not found or not started!')
            return
        end
        return codemInventory
    end

    if Config.Inventories == Inventories.ORIGEN then
        local origenInventory = detectORIGEN()
        if not origenInventory then
            it.print.error('[it_bridge] ORIGEN-Inventory was selected as the inventory, but the resource was not found or not started!')
            return
        end
        return origenInventory
    end

    it.print.error(string.format('[it_bridge] The inventory %s is not supported!', inventory))
end

-- ┌────────────────────────────────────────────────────┐
-- │ ___       _                      _   _             │
-- │|_ _|_ __ | |_ ___ _ __ __ _  ___| |_(_) ___  _ __  │
-- │ | || '_ \| __/ _ \ '__/ _` |/ __| __| |/ _ \| '_ \ │
-- │ | || | | | ||  __/ | | (_| | (__| |_| | (_) | | | |│
-- │|___|_| |_|\__\___|_|  \__,_|\___|\__|_|\___/|_| |_|│
-- └────────────────────────────────────────────────────┘
--- Detect the interactions that are used by the server
--- @return table | nil
local function detectInteractions()
    local function detectOX()
        if GetResourceState('ox_target') == 'started' then
            it.interaction = Interactions.OX
            return Interactions.OX
        end
    end

    local function detectQB()
        if GetResourceState('qb-target') == 'started' then
            it.interaction = Interactions.QB
            return Interactions.QB
        end
    end

    local function detectMV()
        if GetResourceState('ps-inventory') == 'started' then
            it.interaction = Interactions.MV
            return Interactions.MV
           
        end
    end

    if Config.Interactions == AUTO_DETECT then
        local interaction = detectQB() or detectMV() or detectOX() or STANDALONE
        if interaction == STANDALONE then
            it.print.warn('[it_bridge] No interaction was detected, you will need to integrate it!')
            return
        else
            return interaction
        end
    end

    if Config.Interactions == Interactions.OX then
        local oxInteraction = detectOX()
        if not oxInteraction then
            it.print.error('[it_bridge] OX-Interaction was selected as the interaction, but the resource was not found or not started!')
            return
        end
        return oxInteraction
    end

    if Config.Interactions == Interactions.QB then
        local qbInteraction = detectQB()
        if not qbInteraction then
            it.print.error('[it_bridge] QB-Interaction was selected as the interaction, but the resource was not found or not started!')
            return
        end
        return qbInteraction
    end

    if Config.Interactions == Interactions.MV then
        local mvInteraction = detectMV()
        if not mvInteraction then
            it.print.error('[it_bridge] MV-Interaction was selected as the interaction, but the resource was not found or not started!')
            return
        end
        return mvInteraction
    end

    if Config.Interactions == Interactions.NONE then
        it.interaction = Interactions.NONE
        return
    end

    it.print.error(string.format('[it_bridge] The interaction %s is not supported!', interactions))
end

-- ┌─────────────────────────────────────────────────────┐
-- │ _   _       _   _  __ _           _   _             │
-- │| \ | | ___ | |_(_)/ _(_) ___ __ _| |_(_) ___  _ __  │
-- │|  \| |/ _ \| __| | |_| |/ __/ _` | __| |/ _ \| '_ \ │
-- │| |\  | (_) | |_| |  _| | (_| (_| | |_| | (_) | | | |│
-- │|_| \_|\___/ \__|_|_| |_|\___\__,_|\__|_|\___/|_| |_|│
-- └─────────────────────────────────────────────────────┘
--- Detect the notify system that is used by the server
--- @return table | nil
local function detectNotify()
    local function detectBRUTAL()
        if GetResourceState('brutal_notify') == 'started' then
            it.notify = Notifications.BRUTAL
            return Notifications.BRUTAL
        end
    end

    local function detectPNOTIFY()
        if GetResourceState('qb-pNotify') == 'started' then
            it.notify = Notifications.PNOTIFY
            return Notifications.PNOTIFY
        end
    end

    local function detectOX()
        if GetResourceState('ox_lib') == 'started' then
            it.notify = Notifications.OX
            return Notifications.OX
        end
    end

    local function detectESX_NOTIFY()
        if GetResourceState('esx_notify') == 'started' then
            it.notify = Notifications.ESX_NOTIFY
            return Notifications.ESX_NOTIFY
        end
    end

    local function detectQBCORE()
        if GetResourceState('qb-core') == 'started' then
            it.notify = Notifications.QBCORE
            return Notifications.QBCORE
        end
    end

    local function detectESX()
        if GetResourceState('es_extended') == 'started' then
            it.notify = Notifications.ESX
            return Notifications.ESX
        end
    end

    local function detectMYTHIC()
        if GetResourceState('mythic_notify') == 'started' then
            it.notify = Notifications.MYTHIC
            return Notifications.MYTHIC
        end
    end

    local function detectOKOK()
        if GetResourceState('okokNotify') == 'started' then
            it.notify = Notifications.OKOK
            return Notifications.OKOK
        end
    end

    if Config.Notifications == AUTO_DETECT then
        local notify = detectBRUTAL() or detectPNOTIFY() or detectMYTHIC() or detectOKOK() or detectOX() or detectESX_NOTIFY() or detectESX() or detectQBCORE() or STANDALONE
        if notify == STANDALONE then
            it.print.warn('[it_bridge] No notify was detected, you will need to integrate it!')
            return
        else
            return notify
        end
    end

    if Config.Notifications == Notifications.BRUTAL then
        local brutalNotify = detectBRUTAL()
        if not brutalNotify then
            it.print.error('[it_bridge] BRUTAL-Notify was selected as the notify, but the resource was not found or not started!')
            return
        end
        return brutalNotify
    end

    if Config.Notifications == Notifications.PNOTIFY then
        local pNotify = detectPNOTIFY()
        if not pNotify then
            it.print.error('[it_bridge] PNOTIFY-Notify was selected as the notify, but the resource was not found or not started!')
            return
        end
        return pNotify
    end

    if Config.Notifications == Notifications.OX then
        local oxNotify = detectOX()
        if not oxNotify then
            it.print.error('[it_bridge] OX-Notify was selected as the notify, but the resource was not found or not started!')
            return
        end
        return oxNotify
    end

    if Config.Notifications == Notifications.ESX_NOTIFY then
        local esxNotify = detectESX_NOTIFY()
        if not esxNotify then
            it.print.error('[it_bridge] ESX-NOTIFY was selected as the notify, but the resource was not found or not started!')
            return
        end
        return esxNotify
    end

    if Config.Notifications == Notifications.QBCORE then
        local qbCoreNotify = detectQBCORE()
        if not qbCoreNotify then
            it.print.error('[it_bridge] QB-CORE-Notify was selected as the notify, but the resource was not found or not started!')
            return
        end
        return qbCoreNotify
    end

    if Config.Notifications == Notifications.ESX then
        local esxNotify = detectESX()
        if not esxNotify then
            it.print.error('[it_bridge] ESX-Notify was selected as the notify, but the resource was not found or not started!')
            return
        end
        return esxNotify
    end

    if Config.Notifications == Notifications.MYTHIC then
        local mythicNotify = detectMYTHIC()
        if not mythicNotify then
            it.print.error('[it_bridge] MYTHIC-Notify was selected as the notify, but the resource was not found or not started!')
            return
        end
        return mythicNotify
    end

    if Config.Notifications == Notifications.OKOK then
        local okokNotify = detectOKOK()
        if not okokNotify then
            it.print.error('[it_bridge] OKOK-Notify was selected as the notify, but the resource was not found or not started!')
            return
        end
        return okokNotify
    end

    it.print.error(string.format('[it_bridge] The notify %s is not supported!', notify))
end

-- ┌─────────────────────────────┐
-- │ __  __                      │
-- │|  \/  | ___ _ __  _   _ ___ │
-- │| |\/| |/ _ \ '_ \| | | / __|│
-- │| |  | |  __/ | | | |_| \__ \│
-- │|_|  |_|\___|_| |_|\__,_|___/│
-- └─────────────────────────────┘
--- Detect the menu resource that is used by the server
--- @return table | nil
local function detectMenu()
    local function detectESX_CONTEXT()
        if GetResourceState('esx_context') == 'started' then
            it.menu = Menus.ESX_CONTEXT
            return Menus.ESX_CONTEXT
        end
    end

    local function detectOX()
        if GetResourceState('ox_lib') == 'started' then
            it.menu = Menus.OX
            return Menus.OX
        end
    end

    local function detectQB()
        if GetResourceState('qb-menu') == 'started' then
            it.menu = Menus.QB
            return Menus.QB
        end
    end

    if Config.Menus == AUTO_DETECT then
        local menu = detectOX() or detectESX_CONTEXT() or detectQB() or STANDALONE
        if menu == STANDALONE then
            it.print.warn('[it_bridge] No menu was detected, you will need to integrate it!')
            return
        else
            return menu
        end
    end

    if Config.Menus == Menus.ESX_CONTEXT then
        local esxContext = detectESX_CONTEXT()
        if not esxContext then
            it.print.error('[it_bridge] ESX-Context was selected as the menu, but the resource was not found or not started!')
            return
        end
        return esxContext
    end

    if Config.Menus == Menus.OX then
        local oxMenu = detectOX()
        if not oxMenu then
            it.print.error('[it_bridge] OX-Menu was selected as the menu, but the resource was not found or not started!')
            return
        end
        return oxMenu
    end

    if Config.Menus == Menus.QB then
        local qbMenu = detectQB()
        if not qbMenu then
            it.print.error('[it_bridge] QB-Menu was selected as the menu, but the resource was not found or not started!')
            return
        end
        return qbMenu
    end

    it.print.error(string.format('[it_bridge] The menu %s is not supported!', menu))
end

-- ┌─────────────────────────────────────────────────┐
-- │ ____  _           _             _               │
-- │|  _ \(_)___ _ __ | |_ __ _  ___| |__   ___  ___ │
-- │| | | | / __| '_ \| __/ _` |/ __| '_ \ / _ \/ __|│
-- │| |_| | \__ \ |_) | || (_| | (__| | | |  __/\__ \│
-- │|____/|_|___/ .__/ \__\__,_|\___|_| |_|\___||___/│
-- │            |_|                                  │
-- └─────────────────────────────────────────────────┘
--- Detect the dispatch resource that is used by the server
--- @return table | nil
local function detectDispatch()
    local function detectQS()
        if GetResourceState('qs-dispatch') == 'started' then
            it.dispatch = Dispatches.QS
            return Dispatches.QS
        end
    end

    local function detectPS()
        if GetResourceState('ps-dispatch') == 'started' then
            it.dispatch = Dispatches.PS
            return Dispatches.PS
        end
    end

    local function detectCD()
        if GetResourceState('cd-dispatch') == 'started' then
            it.dispatch = Dispatches.CD
            return Dispatches.CD  
        end
    end

    local function detectCORE()
        if GetResourceState('core_dispatch') == 'started' then
            it.dispatch = Dispatches.CORE
            return Dispatches.CORE
        end
    end

    local function detectCODEM()
        if GetResourceState('codem_dispatch') == 'started' then
            it.dispatch = Dispatches.CODEM
            return  Dispatches.CODEM
        end
    end

    local function detectLOVE_SCRIPTS()
        if GetResourceState('emergencydispatch') == 'started' then
            it.dispatch = Dispatches.LOVE_SCRIPTS
            return Dispatches.LOVE_SCRIPTS
        end
    end

    local function detectORIGEN()
        if GetResourceState('origen_police') == 'started' then
            it.dispatch = Dispatches.ORIGEN
            return Dispatches.ORIGEN
        end
    end

    if Config.Dispatches == AUTO_DETECT then
        local dispatch = detectQS() or detectPS() or detectCD() or detectCORE() or detectCODEM() or detectLOVE_SCRIPTS() or detectORIGEN() or STANDALONE
        if dispatch == STANDALONE then
            it.print.warn('[it_bridge] No dispatch was detected, you will need to integrate it!')
            return
        else
            return dispatch
        end
    end

    if Config.Dispatches == Dispatches.QS then
        local qsDispatch = detectQS()
        while not qsDispatch do
            it.print.error('[it_bridge] QS-Dispatch was selected as the dispatch, but the resource was not found or not started!')
            Wait(5000)
        end
        return qsDispatch
    end

    if Config.Dispatches == Dispatches.PS then
        local psDispatch = detectPS()
        while not psDispatch do
            it.print.error('[it_bridge] PS-Dispatch was selected as the dispatch, but the resource was not found or not started!')
            Wait(5000)
            return
        end
        return psDispatch
    end

    if Config.Dispatches == Dispatches.CD then
        local cdDispatch = detectCD()
        if not cdDispatch then
            it.print.error('[it_bridge] CD-Dispatch was selected as the dispatch, but the resource was not found or not started!')
            return
        end
        return cdDispatch
    end

    if Config.Dispatches == Dispatches.CORE then
        local coreDispatch = detectCORE()
        if not coreDispatch then
            it.print.error('[it_bridge] CORE-Dispatch was selected as the dispatch, but the resource was not found or not started!')
            return
        end
        return coreDispatch
    end

    if Config.Dispatches == Dispatches.CODEM then
        local codemDispatch = detectCODEM()
        if not codemDispatch then
            it.print.error('[it_bridge] CODEM-Dispatch was selected as the dispatch, but the resource was not found or not started!')
            return
        end
        return codemDispatch
    end

    if Config.Dispatches == Dispatches.LOVE_SCRIPTS then
        local loveScriptsDispatch = detectLOVE_SCRIPTS()
        if not loveScriptsDispatch then
            it.print.error('[it_bridge] LOVE_SCRIPTS-Dispatch was selected as the dispatch, but the resource was not found or not started!')
            return
        end
        return loveScriptsDispatch
    end

    if Config.Dispatches == Dispatches.ORIGEN then
        local origenDispatch = detectORIGEN()
        if not origenDispatch then
            it.print.error('[it_bridge] ORIGEN-Dispatch was selected as the dispatch, but the resource was not found or not started!')
            return
        end
        return origenDispatch
    end

    if Config.Disptaches == STANDALONE then
        it.dispatch = Dispatches.STANDALONE
    end

    it.print.error(string.format('[it_bridge] The dispatch %s is not supported!', Config.Dispatches))
end

if Config.Framework then
    CoreObject = detectFramework()
end

if Config.Inventories then
    InventoryObject = detectInventory()
end

if Config.Interactions then
    InteractionObject = detectInteractions()
end

if Config.Notifications then
    NotifyObject = detectNotify()
end

if Config.Menus then
    MenuObject = detectMenu()
end

if Config.Dispatches then
    DispatchObject = detectDispatch()
end

it.loaded = true

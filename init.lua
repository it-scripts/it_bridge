
-- Check lua version
if not _VERSION:find('5.4') then
    error('Lua 5.4 must be enabled in the resource manifest!', 2)
end

local resourceName = GetCurrentResourceName()
local it_bridge = 'it_bridge'

-- If somewone wants to load the load it_bridge from the it_bridge resource, then we will not load it.
if resourceName == it_bridge then return end

if lib and lib.name == it_bridge then
    error(("Cannot load it_bridge more than once.\n\tRemove any duplicate entries from '@%s/fxmanifest.lua'"):format(resourceName))
end
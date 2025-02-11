fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
games {'gta5'}

name 'it_bridge'
author '@allroundjonu'
version '1.0.0'

dependencies {
    '/server:7290',
    '/onesync',
}

files {
    'init.lua',
    'modules/**/client.lua',
    'modules/**/client/*.lua',
    'modules/**/server.lua',
    'modules/**/server/*.lua',
}

shared_script 'modules/init.lua'

shared_scripts {
    'resource/**/shared.lua',
    -- 'resource/**/shared/*.lua'
}

--[[ client_scripts {
    'modules/**/client.lua',
    'modules/**/client/*.lua'
}

server_scripts {
    'modules/**/server.lua',
    'modules/**/server/*.lua',
} ]]
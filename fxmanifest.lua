fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
games {'gta5'}

name 'it_bridge'
author '@allroundjonu'
version 'v1.0.0'

identifier 'it_bridge'

shared_scripts {
    '@ox_lib/init.lua',
    'modules/variables.lua',
    'config.lua',
    'modules/print/shared.lua',
    'modules/init.lua',
    'modules/**/shared.lua',
    'modules/**/shared/*.lua'
}

client_scripts {
    'modules/**/client.lua',
    'modules/**/client/*.lua'
}

server_scripts {
    'modules/versionCheck.lua',
    'modules/**/server.lua',
    'modules/**/server/*.lua',
}

escrow_ignore {
    'framework/server/shared.lua',
    'config.lua'
}

dependencies {
    '/server:7290',
    '/onesync',
    'ox_lib'
}
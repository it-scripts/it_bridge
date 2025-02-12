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

shared_script 'modules/init.lua'

shared_scripts {
    'config.lua',
    'resource/**/shared.lua',
    'resource/**/shared/*.lua'
}

lient_scripts {
    'modules/**/client.lua',
    'modules/**/client/*.lua'
}

server_scripts {
    'modules/**/server.lua',
    'modules/**/server/*.lua',
}

escrow_ignore {
    'framework/server/shared.lua',
    'config.lua'
  }
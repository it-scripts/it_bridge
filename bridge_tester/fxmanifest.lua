fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
games {'gta5'}

name 'it_bridge_tester'
author '@allroundjonu'
version '1.0.0'

dependencies {
    '/server:7290',
    '/onesync',
    'ox_lib'
}

shared_script '@ox_lib/init.lua'

client_scripts {
    'client.lua',
}

server_scripts {
    'server/*.lua',
}

dependencies {
    'it_bridge'
}
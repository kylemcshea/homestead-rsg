fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

shared_scripts {
    '@rsg-core/shared/locale.lua',    
    'locales/en.lua',
    'locales/*.lua',
    "config.lua",
    "hairs.lua",
    'overlays.lua',
}

client_scripts {
    "client/client.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/server.lua"
}

dependency 'rsg-core'
dependency 'rsg-menubase'
dependency 'rsg-npcs'

lua54 'yes'
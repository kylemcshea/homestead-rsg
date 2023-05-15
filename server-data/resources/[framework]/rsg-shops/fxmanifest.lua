fx_version 'cerulean'
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

author 'rexshack and qbcore'
description 'rsg-shops'

shared_scripts {
    '@rsg-core/shared/locale.lua',
    'config.lua',
    'locales/en.lua',
    'locales/*.lua',
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

dependencies {
    'rsg-core',
    'rsg-inventory'
}
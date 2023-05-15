fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'Apollyon#5164'
description 'rsg-boats'


client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

shared_scripts {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}

dependencies {
    'rsg-core',
    'menu_base',
    'oxmysql'
}

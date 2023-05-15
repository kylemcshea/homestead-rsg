fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'RexShack#3041'
description 'rsg-indiantobacco'

client_scripts {
    'client/client.lua',
    'client/trader.lua'
}

server_scripts {
    'server/server.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_scripts { 
    'config.lua',
}

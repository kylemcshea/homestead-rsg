fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

author 'RexShack#3041'
description 'rsg-houses'

client_scripts
{
    'client/client.lua'
}

server_scripts
{
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

shared_scripts
{
    '@rsg-core/shared/locale.lua',
    'locales/en.lua', -- preferred language
    'config.lua'
}

dependencies
{
    'rsg-core',
    'rsg-menu',
    'rsg-input',
    'rsg-npcs',
    'rsg-management'
}
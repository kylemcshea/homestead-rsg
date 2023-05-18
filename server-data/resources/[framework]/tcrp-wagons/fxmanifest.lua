fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'tcrp-wagons'
version '1.0.0'
author 'zee#2115 , humanityisinsanity#3505'

shared_scripts {
    'shared/config.lua',
    'shared/horse_comp.lua'
}

client_script 'client/main.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependencies {
    'rsg-core'
}
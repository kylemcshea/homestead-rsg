fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'Phil Mcraken#9759'
name "rsg-notes"

client_scripts {
    'client/client.lua'
}

server_script {
    'server/server.lua'
}

shared_scripts {
    '@rsg-core/shared/locale.lua',
    'locales/en.lua', -- preferred language
    'config.lua',
    'locales/*.lua'
}

dependencies {
    'rsg-input',
    'rsg-menu',
    'rsg-target'
}

lua54 'yes'
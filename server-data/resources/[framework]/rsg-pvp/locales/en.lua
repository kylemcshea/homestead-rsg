local Translations = {
    error = {
        var = 'text goes here',
    },
    success = {
        var = 'text goes here',
    },
    primary = {
        pvp_on = 'PVP : ON',
        pvp_off = 'PVP : OFF',
    },
    menu = {
        var = 'text goes here',
    },
    commands = {
        toggle_pvp = 'Toggle PVP on/off',
    },
    progressbar = {
        var = 'text goes here',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- Lang:t('primary.pvp_on')
-- Lang:t('primary.pvp_off')
-- Lang:t('commands.toggle_pvp')
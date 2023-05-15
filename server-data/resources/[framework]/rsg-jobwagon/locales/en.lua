local Translations = {
    error = {
        no_wagon_setup = 'no wagon setup',
        already_have_wagon = 'you already have a company wagon',
        not_the_boss = 'you are not the boss',
    },
    success = {
        wagon_stored = 'company wagon stored',
        wagon_setup_successfully = 'successfully setup your company wagon',
    },
    primary = {
        wagon_out = 'company wagon taken out',
        wagon_already_out = 'your company wagon is already out',
    },
    menu = {
        wagon_menu = 'Wagon Menu',
        wagon_setup = 'Setup Wagon (Boss)',
        wagon_get = 'Get Wagon',
        wagon_store = 'Store Wagon',
        close_menu = '>> Close Menu <<',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
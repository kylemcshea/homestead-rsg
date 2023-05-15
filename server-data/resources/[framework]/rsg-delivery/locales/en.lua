local Translations = {
    error = {
        error_var = 'Example Text',
    },
    success = {
        success_var = 'Example Text',
    },
    primary = {
        primary_var = 'Example Text',
    },
    menu = {
        menu_var = 'Example Text',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

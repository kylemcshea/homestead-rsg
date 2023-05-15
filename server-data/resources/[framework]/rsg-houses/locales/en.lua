local Translations = {
    error = {
        not_enough_cash = "you don\'t have enought cash for that!",
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

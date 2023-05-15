local Translations = {
    error = {
        you_donthave_the_required_items = "You don\'t have the required items!",
    },
    success = {
        smelting_finished = 'smelting finished',
    },
    primary = {
        gold_smelt_deployed = 'gold smelt deployed',
    },
    menu = {
        smelting_menu = '☢️ | Smelting Menu',
        close_menu = '❌ | Close Menu',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        smelting_a = 'Smelting a ',
    },
    text = {
        gold_bar = 'Gold Bar',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

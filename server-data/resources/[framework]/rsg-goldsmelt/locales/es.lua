local Translations = {
    error = {
        you_donthave_the_required_items = "¡No tienes los elementos requeridos!",
    },
    success = {
        smelting_finished = 'fundición terminada',
    },
    primary = {
        gold_smelt_deployed = 'fundición de oro liberada',
    },
    menu = {
        smelting_menu = '☢️ | Menú de fundición',
        close_menu = '❌ | Cerrar menu',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        smelting_a = 'Fundición de un ',
    },
    text = {
        gold_bar = 'Barra de oro',
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
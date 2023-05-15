local Translations = {
    error = {
        you_dont_have_an_axe = "¡No tienes un hacha!",
        your_axe_is_broken = '¡Tu hacha se rota!',
    },
    success = {
        you_chopped_wood = 'tú picaste %{givewood} madera',
    },
    primary = {
        you_are_busy_at_the_moment = 'Estas ocupada en este momento!',
    },
    menu = {
        start_choping  = 'Empezar a picar ',
    },
    commands = {
            var = 'text goes here',
    },
    progressbar = {
            var = 'text goes here',
    },
    text = {
        tree = 'Arbol'
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
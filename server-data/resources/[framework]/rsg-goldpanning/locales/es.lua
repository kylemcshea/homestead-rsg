local Translations = {
    error = {
        you_are_already_goldpanning = '¡ya estás buscando oro!',
        you_are_mounted = 'no puedes hacer esto mientras estás montado!',
    },
    success = {
        var = 'text goes here',
    },
    primary = {
        you_need_the_river_to_goldpan = 'necesitas estar junto al río para batear',
        not_much_this_pan = 'no hay mucho en esta batea',
        looks_like_good_gold = 'parece oro del bueno',
        gold_fever_jackpot = 'bote de la fiebre del oro...',
        no_gold_this_time = 'no hay oro esta vez...',
    },
    menu = {
        var = 'text goes here',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}


if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
local Translations = {
    error = {
        you_are_already_goldpanning = 'Stai già cercando oro!',
        you_are_mounted = 'non sei in grado di farlo mentre sei montato!',
    },
    success = {
        var = 'text goes here',
    },
    primary = {
        you_need_the_river_to_goldpan = 'Devi essere vicino ad un fiume per cercare oro',
        not_much_this_pan = 'Non c\'è molto in questo setaccio',
        looks_like_good_gold = 'Sembra oro buono',
        gold_fever_jackpot = 'Jackpot della febbre dell\'oro..',
        no_gold_this_time = 'Niente oro questa volta..',
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

if GetConvar('rsg_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

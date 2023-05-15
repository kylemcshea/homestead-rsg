local Translations = {
    error = {
        you_are_already_goldpanning = 'you are already goldpanning!',
        you_are_mounted = 'you are not able to do this while mounted!',
    },
    success = {
        var = 'text goes here',
    },
    primary = {
        you_need_the_river_to_goldpan = 'you need to be by the river to goldpan',
        not_much_this_pan = 'not much in this pan',
        looks_like_good_gold = 'looks like good gold',
        gold_fever_jackpot = 'gold fever jackpot..',
        no_gold_this_time = 'no gold this time..',
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

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

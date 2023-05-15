local Translations = {
    error = {
        horse_brush_needed = 'Horse trainer brush required!',
        not_horse_trainer = 'You are not a horse trainer!',
        horse_too_clean = 'Horse is too clean right now!',
        carrot_needed = 'Carrot required to feed the horse!',
        horse_too_full = 'Horse is too full right now!',
        horse_too_far = 'Please move closer to your horse!'
    },
    success = {
        xp_now = ' EXP is now ',
    },
    info = {
        --var = 'text goes here',
    },
    menu = {
        --var = 'text goes here',
    },
    commands = {
        --var = 'text goes here',
    },
    progressbar = {
        --var = 'text goes here',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- Lang:t('error.horse_too_full')
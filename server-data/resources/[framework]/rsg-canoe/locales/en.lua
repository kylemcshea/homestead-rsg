local Translations = {
    error = {
        cant_take_out_boat = 'You can\'t take out your canoe here!',
        boat_already_out = 'You already have your canoe out!',
        no_item = 'You don\'t have this item!',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- Lang:t('error.horse_too_far')
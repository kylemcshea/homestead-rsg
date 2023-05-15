local Translations = {
    error = {
        no_cash = 'you don\'t have enough cash on you!',
    },
    success = {
        var = 'text goes here',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        open_prompt = 'Open ',
        fast_travel_annesburg = 'Fast Travel Annesburg',
        fast_travel_armadillo = 'Fast Travel Armadillo',
        fast_travel_blackwater = 'Fast Travel Blackwater',
        fast_travel_rhodes = 'Fast Travel Rhodes',
        fast_travel_strawberry = 'Fast Travel Strawberry',
        fast_travel_saintdenis = 'Fast Travel Saint Denis',
        fast_travel_tumbleweed = 'Fast Travel Tumbleweed',
        fast_travel_valentine = 'Fast Travel Valentine',
        fast_travel_vanhorn = 'Fast Travel Van Horn',
        fast_travel_sisika = 'Fast Travel Sisika',
        fast_travel_to = 'Fast Travel to ',
        ticket_price = 'Ticket Price $ ',
        close_menu = '❌ | Close Menu',
        fast_travel = 'Fast Travel',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- Lang:t('error.var')
-- Lang:t('success.var')
-- Lang:t('primary.var')
-- Lang:t('menu.var')

local Translations = {
    error = {
        something_went_wrong = 'something went wrong!',
        dont_have_animal = "don't have an animal on you"
    },
    success = {
        var = 'text goes here',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        open = 'Open ',
        sell_your_animal_the_butcher = 'sell your animal',
        buy_items_from_butcher = 'buy items from the butcher',
        close_menu = 'Close Menu',
        open_shop = 'Open Shop',
        sell_animal = 'Sell Animal',
        butcher_shop = 'Butcher Shop'
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        selling = 'Selling ',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

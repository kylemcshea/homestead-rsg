local Translations = {
    error = {
        you_dont_have_the_ingredients_to_make_this = "you don\'t have the ingredients to make this!",
        something_went_wrong = 'something went wrong!',
        you_dont_have_that_much_on_you = "You don\'t have that much on you.",
        you_dont_have_an_item_on_you = "You don\'t have an item on you",
        must_not_be_a_negative_value = 'must not be a negative value.',
    },
    success = {
        you_made_some_moonshine = 'you made some moonshine',
        you_sold = 'You sold  %{amount} for $ %{totalcash}',
    },
    primary = {
        moonshine_destroyed = 'moonshine destroyed!',
    },
    menu = {
        close_menu = 'Close menu',
        price = ' (price $',
        enter_the_number_of_1pc = "Enter the number of 1pc / ${price} $",
        brew = 'Brew [J]',
        destroy = 'Destroy [J]',
        moonshine = '| Moonshine |',
        make_moonshine = 'Make Moonshine',
        sell_moonshine = 'sell moonshine',
    },
    commands = {
            var = 'text goes here',
    },
    progressbar = {
            var = 'text goes here',
    },
    blip = {
      moonshine_vendor = 'Moonshine Vendor',
    },
    text = {
        xsugar_1xWater_and_1xcorn = '1 x Sugar 1 x Water and 1 x Corn',
        sell = 'sell',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

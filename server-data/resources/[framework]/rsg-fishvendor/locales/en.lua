local Translations = {
    error = {
        no_small_fish = 'you don\'t have any small fish to sell!',
        no_medium_fish = 'you don\'t have any medium fish to sell!',
        no_large_fish = 'you don\'t have any large fish to sell!',
    },
    success = {
        small_fish_sold = 'you have sold your small fish for $',
        medium_fish_sold = 'you have sold your medium fish for $',
        large_fish_sold = 'you have sold your large fish for $',
    },
    menu = {
        open_prompt = 'Open ',
        sell_small_fish = 'Sell Small Fish',
        sell_medium_fish = 'Sell Medium Fish',
        sell_large_fish = 'Sell Large Fish',
        we_currently_pay = 'we pay $',
        per_small_fish = '.00 per small fish',
        per_medium_fish = '.00 per medium fish',
        per_large_fish = '.00 per large fish',
        open_shop = 'Open Fish Vendor Shop',
        buy_items_txt = 'buy items from the fish vendor',
        close_menu = 'Close Menu',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

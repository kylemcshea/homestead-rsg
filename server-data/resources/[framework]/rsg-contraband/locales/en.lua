local Translations = {
    error = {
        you_do_not_have_enough_blood_money_to_do_that = 'You do not have enough blood money to do that!',
        you_do_not_have_any_blood_money = 'You do not have any blood money!',
        you_do_not_have_enough_gold_bars = 'You do not have enough gold bars to do that!',
        you_do_not_have_any_gold_bars = 'You do not have any gold bars!',
    },
    success = {
        you_sold_money_for = 'You sold %{amount} blood money for $ %{totalcash}',
        you_sold_gold_bars_for_totalcash = 'You sold %{amount} gold bars for $ %{totalcash}',
    },
    primary = {
        started_selling_contraband = 'started selling contraband',
    },
    menu = {
        open = 'Open ',
        outlaw_menu = '| Outlaw Menu |',
        blood_money_wash = 'Blood Money Wash',
        sell_gold_bars = 'Sell Gold Bars',
        open_outlaw_shop = 'Open Outlaw Shop',
        close_menu = 'Close Menu',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
    text = {
        wash_the_blood_off_your_money = 'wash the blood off your money',
        sell_your_gold_bars_here = 'sell your gold bars here',
        buy_outlawed_items = 'buy outlawed items',
        amount_to_wash = 'Amount to Wash ($)',
        amount_of_bars = 'Amount of Bars',
    },
    label = {
        outlaw_shop = 'Outlaw Shop',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

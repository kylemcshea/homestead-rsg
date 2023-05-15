local Translations = {
    error = {
        you_do_not_have_enough_blood_money_to_do_that = '¡No tienes suficiente dinero de sangre para hacer eso!',
        you_do_not_have_any_blood_money = '¡No tienes dinero de sangre!',
        you_do_not_have_enough_gold_bars = '¡No tienes suficientes lingotes de oro para hacer eso!',
        you_do_not_have_any_gold_bars = '¡No tienes lingotes de oro!',
    },
    success = {
        you_sold_money_for = 'Vendistes %{amount} dinero de sangre para $ %{totalcash}',
        you_sold_gold_bars_for_totalcash = 'Vendistes %{amount} lingotes de oro para $ %{totalcash}',
    },
    primary = {
        started_selling_contraband = 'comenzó a vender contrabando',
    },
    menu = {
        open = 'Abrir ',
        outlaw_menu = '| Menú Outlaw |',
        blood_money_wash = 'Lavado de dinero con sangre',
        sell_gold_bars = 'Vender lingotes de oro',
        open_outlaw_shop = 'Abrir tienda de Outlaw',
        close_menu = 'Cerrar menú',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
    text = {
        wash_the_blood_off_your_money = 'lava la sangre de tu dinero',
        sell_your_gold_bars_here = 'vende tus lingotes de oro aquí',
        buy_outlawed_items = 'comprar artículos prohibidos',
        amount_to_wash = 'Cantidad a lavar ($)',
        amount_of_bars = 'Cantidad de barras',
    },
    label = {
        outlaw_shop = 'Tienda de Outlaw',
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
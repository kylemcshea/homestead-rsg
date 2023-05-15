local Translations = {
    error = {
        something_went_wrong = '¡algo salió mal!',
      you_dont_have_any_pelts_to_sell = "¡No tienes pieles para vender!"
    },
    success = {
        you_have_sold_all_your_pelts_for = 'Has vendido todas tus pieles por $',
    },
    primary = {
        stored = ' Almacenado',
    },
    menu = {
        open = 'Abrir ',
        sell_stored_pelts = 'Vender pieles',
        trapper_menu = 'Menú trapper',
        open_trapper_shop = 'Abrir tienda de trapper',
        close_menu = 'Cerrar Menú',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        checking_pelts = 'Revisando pieles',
    },
    text = {
        buy_items_from_the_fish_vendor = 'comprar artículos del vendedor',
        sell_store_pelts = 'vender artículos para tienda de pieles',
        trapper_shop =  'Tienda trapper',
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true,
    fallbackLang = Lang,
  })
end

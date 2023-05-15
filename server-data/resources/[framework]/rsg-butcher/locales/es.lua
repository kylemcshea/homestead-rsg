local Translations = {
    error = {
        something_went_wrong = '¡algo salió mal!',
        dont_have_animal = "no tienes un animal encima"
    },
    success = {
        var = 'text goes here',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        open = 'Abrir ',
        sell_your_animal_the_butcher = 'vende tu animal al carnicero',
        buy_items_from_butcher = 'comprar artículos del carnicero',
        close_menu = 'Cerrar Menú',
        open_shop = 'Abrir Tienda',
        sell_animal = 'Vender Animal',
        butcher_shop = 'Tienda de Carnicero'
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        selling = 'Vendiendo ',
    },
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

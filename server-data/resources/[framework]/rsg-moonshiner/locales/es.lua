local Translations = {
    error = {
        you_dont_have_the_ingredients_to_make_this = '¡No tienes los ingredientes para hacer esto!',
        something_went_wrong = '¡algo salió mal!',
        you_dont_have_that_much_on_you = 'No tienes mas.',
        you_dont_have_an_item_on_you = 'No tienes un artículo contigo',
        must_not_be_a_negative_value = 'no debe ser un valor negativo.',
    },
    success = {
        you_made_some_moonshine = 'Hiciste algo de moonshine',
        you_sold = 'Vendistes  %{amount} por $ %{totalcash}',
    },
    primary = {
        moonshine_destroyed = 'moonshine destruido!',
    },
    menu = {
        close_menu = 'Cerrar menú',
        price = ' (precio $',
        enter_the_number_of_1pc = "Ingrese el número de 1pc / ${price} $",
        brew = 'Elaborar [J]',
        destroy = 'Destruir [J]',
        moonshine = '| Moonshine |',
        make_moonshine = 'Hacer moonshine',
        sell_moonshine = 'Vender moonshine',
    },
    commands = {
            var = 'text goes here',
    },
    progressbar = {
            var = 'text goes here',
    },
    text = {
        xsugar_1xWater_and_1xcorn = '1 x Azucar 1 x Agua and 1 x Maiz',
        sell = 'vender',
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

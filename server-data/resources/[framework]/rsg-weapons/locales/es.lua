local Translations = {
    error = {
        no_arrows_your_inventory_load = 'no hay flechas en su inventario para cargar',
        max_mmo_capacity = 'Capacidad máxima de munición',
        wrong_ammo_for_weapon = '¡munición incorrecta para el arma!',
        you_are_not_holding_weapon = '¡No estás sosteniendo un arma!',
    },
    success = {
        weapon_reloaded = 'Arma Recargada',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        var = 'text goes here',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

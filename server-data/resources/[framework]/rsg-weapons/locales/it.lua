local Translations = {
    error = {
        no_arrows_your_inventory_load = 'Nessuna freccia da caricare nel tuo inventario',
        max_mmo_capacity = 'Capacità massima munizioni',
        wrong_ammo_for_weapon = 'Munizioni non per quest\'arma!',
        you_are_not_holding_weapon = 'Non hai in mano un\'arma!',
    },
    success = {
        weapon_reloaded = 'Arma ricaricata',
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

if GetConvar('rsg_locale', 'en') == 'it' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      fallbackLang = Lang,
  })
end

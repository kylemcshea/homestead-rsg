local Translations = {
    error = {
      you_dont_have_the_required_items = "Non hai gli oggetti necessari!",
    },
    success = {
      cooking_finished = 'Cottura terminata',
    },
    primary = {
      campfire_put_out = 'Fuoco da campo spento',
      campfire_deployed = 'Fuoco da campo acceso'
    },
    menu = {
      fish_steak = 'Trancio di pesce',
      meat_steak = 'Bistecca di Carne',
      cooking_menu = '🥩 | Menù Cucina',
      close_menu = '❌ | Chiudi Menu',
    },
    commands = {
      deploy_campfire = 'Prepara un fuoco da campo',
    },
    progressbar = {
      cooking_a = 'Cuocendo un ',
    },
    label = {
      open_cooking_menu = 'Apri Menu Cucina'
    }
}

if GetConvar('rsg_locale', 'en') == 'it' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      fallbackLang = Lang,
  })
end

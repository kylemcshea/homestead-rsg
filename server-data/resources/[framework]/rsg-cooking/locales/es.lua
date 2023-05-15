local Translations = {
    error = {
      you_dont_have_the_required_items = "¡No tienes los artículos requeridos!",
    },
    success = {
      cooking_finished = 'cocinado',
    },
    primary = {
      campfire_put_out = 'fogata apagada',
      campfire_deployed = 'fogata colocada'
    },
    menu = {
      fish_steak = 'Filete de pescado',
      meat_steak = 'Filete de carne',
      cooking_menu = '🥩 | Menú de cocina',
      close_menu = '❌ | Cerrar Menú',
    },
    commands = {
      deploy_campfire = 'colocar una fogata',
    },
    progressbar = {
      cooking_a = 'Cocinando una ',
    },
    label = {
      open_cooking_menu = 'Abrir Menú de cocina'
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      fallbackLang = Lang,
  })
end
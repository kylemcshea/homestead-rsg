local Translations = {
    error = {
            you_need_use_your_fishing_rod_first = 'Primero debes usar tu caña de pescar.',
    },
    success = {
            var = 'text goes here',
    },
    primary = {
            you_got_fish_name = 'Tienes un %{fish_name}',
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
    text = {
        ready_to_fish = 'Listo para pescar!',
        fishing = 'Pescando',
        get_the_fish = '¡Toma el pescado!',
        name = 'Nombre',
        weight = 'Peso',
        prepare_fishing_rod = 'Preparar caña de pescar',
        cast_fishing_rod = 'Caña de pescar fundida',
        hook = 'Halar',
        reset_cast = 'Reiniciar',
        reel_lure = 'Carrete señuelo',
        reel_in = 'Enrollar',
        keep_fish = 'Mantener pescado',
        throw_fish = 'Tirar el pez',
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      fallbackLang = Lang,
  })
end
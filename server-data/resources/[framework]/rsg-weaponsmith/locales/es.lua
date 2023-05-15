local Translations = {
    error = {
        you_are_not_authorised = 'No estas autorizado',
        you_must_be_holding_weapon = '¡Debes estar sosteniendo el arma!',
        you_dont_have_the_required_items = "¡No tienes los elementos requeridos!",
    },
    success = {
        weapon_cleaned = 'arma limpiada',
        crafting_finished = 'fabricación terminada',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        open = 'Abrir ',
        weapon_crafting = 'Fabricación de armas',
        weapon_parts_crafting = 'Fabricación de piezas de armas',
        weaponsmith_storage = 'Inventario de armeria',
        job_management = 'Gestión de trabajos',
        close_menu = '>> Cerrar menú <<',
        revolver_crafting = 'Fabricación de Revolver',
        pistol_crafting = 'Fabricación de Pistola',
        repeater_crafting = 'Fabricación de Repetidora',
        rifle_crafting = 'Fabricación de Rifle',
        shotgun_crafting = 'Fabricación de Shotgun',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        crafting_a = 'Elaborando un(a) ',
    },
    text = {
        var = 'text goes here',
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      fallbackLang = Lang,
  })
end

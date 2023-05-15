local Translations = {
    error = {
        you_are_not_authorised = 'Non sei autorizzato!',
        you_must_be_holding_weapon = 'Devi avere in mano l\'arma!',
        you_dont_have_the_required_items = "Non hai gli oggetti necessari!",
    },
    success = {
        weapon_cleaned = 'Arma pulita',
        crafting_finished = 'Lavorazione terminata',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        open = 'Open ',
        weapon_crafting = 'Fabbricazione armi',
        weapon_parts_crafting = 'Fabbricazione componenti armi',
        weaponsmith_storage = 'Magazzino armiere',
        job_management = 'Gestione Lavoro',
        close_menu = '>> Chiudi Menu <<',
        revolver_crafting = 'Fabbricazione Revolver',
        pistol_crafting = 'Fabbricazione Pistola',
        repeater_crafting = 'Fabbricazione Arma a ripetizione',
        rifle_crafting = 'Fabbricazione Fucile',
        shotgun_crafting = 'Fabbricazione Fucile da caccia',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        crafting_a = 'Fabbricando un ',
    },
    text = {
        var = 'text goes here',
    }
}

if GetConvar('rsg_locale', 'en') == 'it' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      fallbackLang = Lang,
  })
end

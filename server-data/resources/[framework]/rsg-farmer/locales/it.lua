local Translations = {
    error = {
        something_went_wrong = 'Qualcosa è andato storto!',
        you_need_item_to_do_that = 'Hai bisogno di %{item1} e %{item2} per farlo!',
        only_farmers_can_plant_seeds = 'Solo gli agricoltori sono capaci di seminare!',
        you_are_not_in_a_farming_zone = 'Non sei in una zona agricola!',
        you_may_only_plant_seeds_here = 'Puoi piantare solo %{zonename} semi qui!',
        too_close_to_another_plant = 'Troppo vicino a un\'altra pianta!',
        you_already_have_plants_down = 'Hai già %{MaxPlantCount} piante abbattute',
        only_farmers_can_collect_water = 'Solo gli agricoltori possono raccogliere l\'acqua!',
        you_need_bucket_collect_water = 'Hai bisogno di un secchio per raccogliere l\'acqua!',
        only_farmers_can_collect_poo = 'Solo i contadini possono raccogliere le feci!',
        you_need_a_bucket_collect_fertilizer = 'Hai bisogno di un secchio per raccogliere il fertilizzante!',
    },
    success = {
        you_distroyed_the_plant = 'Hai distrutto la pianta',
        you_harvest_label = 'Raccogli %{amount} %{label}',
        youve_got_bucketful_water = "Hai un secchio pieno d'acqua!",
        youve_got_bucketful_fertilizer = "Hai un secchio pieno di fertilizzante!",
    },
    primary = {
        you_have_entered_farm_zone = 'Sei entrato in una zona agricola!',
        you_have_entered_farm_zone_zonename = 'Sei entrato nella zona agricola %{zonename}!',
        you_may_only_plant_seeds_here = 'Puoi piantare solo %{zonename} semi qui!',
    },
    menu = {
        open = 'Apri ',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        destroying_the_plants = 'Distruzione piante...',
        harvesting_plants = 'Raccolta delle piante...',
        watering_the_plants = 'Innaffiando piante...',
        fertilising_the_plants = 'Concimazione delle piante...',
        planting_seeds = 'Piantando semi di %{planttype}...',
        collecting_water = 'Raccogliendo Acqua...',
        collecting_poo = 'Raccogliendo Escrementi...',		 
    },
    blip = {
        farming_zone = 'Zona Agricola',
        farm_shop = 'Negozio Fattoria',
        farmzone_farm_zone = 'farmzone1 Farm Zone',
    },
    text = {
        thirst_hunger = 'Irrigazione: %{thirst} % - Concime: %{hunger} %',
        growth_quality = 'Sviluppo: %{growth} % -  Qualità: %{quality} %',
        destroy_plant = 'Distruggi pianta [G]',
        water_feed = 'Annaffia [G] : Concima [J]',
        quality = '[Qualità: ${quality}]',
        harvest = 'Raccogli [E]',
        collect_water = 'Raccogli Acqua [J]',
        pickup_poo = 'Raccogli Escrementi [J]',
    },
    label = {
        corn = 'Mais',
        sugar = 'Zucchero',
        tobacco = 'Tabacco',
        carrot = 'Carota',
        tomato = 'Pomodoro',
        broccoli = 'Broccoli',
        potato = 'Patata',
    }
}

if GetConvar('rsg_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

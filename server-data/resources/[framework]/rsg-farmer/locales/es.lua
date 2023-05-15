local Translations = {
    error = {
        something_went_wrong = '¡Algo salió mal!',
        you_need_item_to_do_that = 'Necesitas un %{item1} y %{item2} para hacer eso!',
        only_farmers_can_plant_seeds = '¡Solo los agricultores pueden plantar semillas!',
        you_are_not_in_a_farming_zone = '¡No estás en una zona agrícola!',
        you_may_only_plant_seeds_here = '¡Solo puedes plantar %{zonename} semillas aquí!',
        too_close_to_another_plant = '¡Demasiado cerca de otra planta!',
        you_already_have_plants_down = 'Tienes %{MaxPlantCount} plantas',
        only_farmers_can_collect_water = '¡Solo los agricultores pueden recoger agua!',
        you_need_bucket_collect_water = '¡Necesitas un cubo para recoger agua!',
        only_farmers_can_collect_poo = '¡Solo los agricultores pueden recoger caca!',
        you_need_a_bucket_collect_fertilizer = '¡Necesitas un balde para recolectar fertilizante!',
    },
    success = {
        you_distroyed_the_plant = 'destruiste la planta',
        you_harvest_label =  'Cosechastes %{amount} %{label}',
        youve_got_bucketful_water = "¡Tienes un balde lleno de agua!",
        youve_got_bucketful_fertilizer = "¡Tienes un balde lleno de fertilizante!",
    },
    primary = {
        you_have_entered_farm_zone = '¡Has entrado en una zona de cultivo!',
        you_have_entered_farm_zone_zonename = '¡Has entrado %{zonename} zona de cultivo!',
        you_may_only_plant_seeds_here = 'Solo puedes plantar %{zonename} semillas aquí!',
    },
    menu = {
        open = 'Abrir ',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        destroying_the_plants = 'Destruyendo las plantas...',
        harvesting_plants = 'Cosechando las plantas...',
        watering_the_plants = 'Regando las plantas...',
        fertilising_the_plants = 'Fertilizando las plantas...',
        planting_seeds = 'Plantando %{planttype} semillas...',
        collecting_water = 'Agarrando agua...',
        collecting_poo = 'Agarrando estierlco...',
    },
    blip = {
        farming_zone = 'Zona de cultivo',
        farm_shop = 'Tienda Agricola',
        farmzone_farm_zone = 'Zona Agricola 1',
    },
    text = {
        thirst_hunger = 'Sed: %{thirst} % - Hambre: %{hunger} %',
        growth_quality = 'Crecimiento: %{growth} % -  Calidad: %{quality} %',
        destroy_plant = 'Destruir planta [G]',
        water_feed = 'Agua [G] : Alimento [J]',
        quality = '[Calidad: ${quality}]',
        harvest = 'Cosecha [E]',
        collect_water = 'Agarrar agua [J]',
        pickup_poo = 'Agarrar estiercol [J]',
    },
    label = {
        corn = 'Maiz',
        sugar = 'Azucar',
        tobacco = 'Tabaco',
        carrot = 'Zanahoria',
        tomato = 'Tomate',
        broccoli = 'Brocoli',
        potato = 'Potata',
    }
}

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
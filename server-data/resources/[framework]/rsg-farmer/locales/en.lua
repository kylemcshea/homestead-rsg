local Translations = {
    error = {
        something_went_wrong = 'Something went wrong!',
        you_need_item_to_do_that = 'You need a %{item1} and %{item2} to do that!',
        only_farmers_can_plant_seeds = 'Only farmers can plant seeds!',
        you_are_not_in_a_farming_zone = 'You are not in a farming zone!',
        you_may_only_plant_seeds_here = 'You may only plant %{zonename} seeds here!',
        too_close_to_another_plant = 'Too close to another plant!',
        you_already_have_plants_down = 'You already have %{MaxPlantCount} plants down',
        only_farmers_can_collect_water = 'Only farmers can collect water!',
        you_need_bucket_collect_water = 'You need a bucket to collect water!',
        only_farmers_can_collect_poo = 'Only farmers can collect poo!',
        you_need_a_bucket_collect_fertilizer = 'You need a bucket to collect fertilizer!',
    },
    success = {
        you_distroyed_the_plant = 'you distroyed the plant',
        you_harvest_label =  'You harvest %{amount} %{label}',
        youve_got_bucketful_water = "You\'ve got a bucketful of water!",
        youve_got_bucketful_fertilizer = "You\'ve got a bucketful of fertilizer!",
    },
    primary = {
        you_have_entered_farm_zone = 'You have entered a farm zone!',
        you_have_entered_farm_zone_zonename = 'You have entered a %{zonename} farm zone!',
        you_may_only_plant_seeds_here = 'You may only plant %{zonename} seeds here!',
    },
    menu = {
        open = 'Open ',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        destroying_the_plants = 'Destroying the plants...',
        harvesting_plants = 'Harvesting the plants...',
        watering_the_plants = 'Watering the plants...',
        fertilising_the_plants = 'Fertilising the plants...',
        planting_seeds = 'Planting %{planttype} seeds...',
        collecting_water = 'Collecting Water...',
        collecting_poo = 'Collecting Poo...',
    },
    blip = {
        farming_zone = 'Farming Zone',
        farm_shop = 'Farm Shop',
        farmzone_farm_zone = 'farmzone1 Farm Zone',
    },
    text = {
        thirst_hunger = 'Thirst: %{thirst} % - Hunger: %{hunger} %',
        growth_quality = 'Growth: %{growth} % -  Quality: %{quality} %',
        destroy_plant = 'Destroy Plant [G]',
        water_feed = 'Water [G] : Feed [J]',
        quality = '[Quality: ${quality}]',
        harvest = 'Harvest [E]',
        collect_water = 'Collect Water',
        pickup_poo = 'Pickup Poo',
    },
    label = {
        corn = 'Corn',
        sugar = 'Sugar',
        tobacco = 'Tobacco',
        carrot = 'Carrot',
        tomato = 'Tomato',
        broccoli = 'Broccoli',
        potato = 'Potato',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

local Translations = {
    error = {
            you_need_use_your_fishing_rod_first = 'You need to use your fishing rod first.',
    },
    success = {
            var = 'text goes here',
    },
    primary = {
            you_got_fish_name = 'You got a %{fish_name}',
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
        ready_to_fish = 'Ready to fish!',
        fishing = 'Fishing',
        get_the_fish = 'Get the fish!',
        name = 'Name',
        weight = 'Weight',
        prepare_fishing_rod = 'Prepare Fishing Rod',
        cast_fishing_rod = 'Cast Fishing Rod',
        hook = 'Hook',
        reset_cast = 'Reset Cast',
        reel_lure = 'Reel Lure',
        reel_in = 'Reel In',
        keep_fish = 'Keep Fish',
        throw_fish = 'Throw Fish',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

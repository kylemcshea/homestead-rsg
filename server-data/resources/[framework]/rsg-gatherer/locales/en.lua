local Translations = {
    error = {
        you_dont_have_an_axe = "you don\'t have an axe!",
        your_axe_is_broken = 'your axe is broken!',
    },
    success = {
        you_chopped_wood = 'you chopped %{givewood} wood',
    },
    primary = {
        you_are_busy_at_the_moment = 'you are busy at the moment!',
    },
    menu = {
        start_choping  = 'Start Choping ',
    },
    commands = {
            var = 'text goes here',
    },
    progressbar = {
            var = 'text goes here',
    },
    text = {
        tree = 'Tree'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

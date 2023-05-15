local Translations = {
    error = {
        you_dont_have_pickaxe = "you don\'t have a pickaxe!",
        something_went_wrong = 'something went wrong!',
    },
    success = {
        your_pickaxe_broke = 'your pickaxe broke!',
    },
    primary = {
        you_are_busy_the_moment = 'you are busy at the moment!',
        small_haul_time = 'small haul time!',
        medium_haul_this_time = 'medium haul this time!',
        largq_haul_this_time = 'large haul this time!',
    },
    menu = {
        start = 'Start ',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

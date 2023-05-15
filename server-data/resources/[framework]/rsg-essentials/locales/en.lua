local Translations = {
    error = {
        var = 'text goes here',
    },
    success = {
            var = 'text goes here',
    },
    primary = {
            var = 'text goes here',
    },
    menu = {
            var = 'text goes here',
    },
    commands = {
        emoteMenu = 'Open emote menu.',
    },
    progressbar = {
            var = 'text goes here',
    },
    label = {
        take_a_drink = 'Take a Drink'
    },
    emotes = {
        title = ' Emote Menu',
        actions = {
            mainMenu = '🚩 Actions',
            secondMenu = '🚩 Actions Emotes'
        },
        greeting = {
            mainMenu = '👋 Greeting',
            secondMenu = '👋 Greeting Emotes'
        },
        reaction = {
            mainMenu = '🎭 Reactions',
            secondMenu = '🎭 Reactions Emotes'
        },
        taunting = {
            mainMenu = '😡 Taunting',
            secondMenu = '😡 Taunting Emotes'
        },
        dancing = {
            mainMenu = '💃 Dancing',
            secondMenu = '💃 Dancing Emotes'
        },
        close = '❌ Exit'
    },
    log = {
        weapon_removed = 'Weapon Removed!',
        had_weapon_them_that_they_did_not_have = '** @staff ** ${firstname} ${lastname} had a weapon on them that they did not have in his inventory : anticheat has removed the weapon',
        test_webhook = 'Test Webhook',
        webhook_setup_successfully = 'Webhook setup successfully',
        test_your_discord_webhook = 'Test Your Discord Webhook For Logs (God Only)',
    },
    afk = {
        will_kick = 'You are AFK and will be kicked in ',
        time_seconds = ' seconds!',
        time_minutes = ' minute(s)!'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

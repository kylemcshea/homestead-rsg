local Translations = {
    error = {
        no_arrows_your_inventory_load = 'no arrows in your inventory to load',
        max_mmo_capacity = 'Max Ammo Capacity',
        wrong_ammo_for_weapon = 'wrong ammo for weapon!',
        you_are_not_holding_weapon = 'you are not holding a weapon!',
    },
    success = {
        weapon_reloaded = 'Weapon Reloaded',
    },
    primary = {
        var = 'text goes here',
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
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

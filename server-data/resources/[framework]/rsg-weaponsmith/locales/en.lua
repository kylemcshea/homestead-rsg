local Translations = {
    error = {
        you_are_not_authorised = 'you are not authorised!',
        you_must_be_holding_weapon = 'you must be holding the weapon!',
        you_dont_have_the_required_items = "You don\'t have the required items!",
    },
    success = {
        weapon_cleaned = 'weapon cleaned',
        crafting_finished = 'crafting finished',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        open = 'Open ',
        weapon_crafting = 'Weapon Crafting',
        weapon_parts_crafting = 'Weapon Parts Crafting',
        weaponsmith_storage = 'Weaponsmith Storage',
        job_management = 'Job Management',
        close_menu = '>> Close Menu <<',
        revolver_crafting = 'Revolver Crafting',
        pistol_crafting = 'Pistol Crafting',
        repeater_crafting = 'Repeater Crafting',
        rifle_crafting = 'Rifle Crafting',
        shotgun_crafting = 'Shotgun Crafting',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        crafting_a = 'Crafting a ',
    },
    text = {
        var = 'text goes here',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

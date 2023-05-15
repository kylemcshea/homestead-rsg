local Translations = {
    error = {
        you_dont_have_this_blueprint_original = "you don\'t have this blueprint original",
        need_more_crafting_items = 'need more crafting items!',
        you_dont_have_enough_cash_to_do_that = 'you don\'t have enough cash to do that!',
        not_enough_reputation_repneeded_required = 'not enough reputation %{repneeded} required!',
    },
    success = {
        taken_for_the_copy = '$ %{copycost} taken for the copy',
        crafting_successful = 'crafting successful',
        not_enough_crafting_reputation_to_make_this = 'not enough crafting reputation to make this!'
    },
    primary = {
        your_crafting_rep_is = 'Your Crafting Rep is: ',
        your_crafting_reputation_increased_to  = 'Your crafting reputation increased to '
    },
    menu = {
        open = 'Open ',
        crafting_menu = 'Crafting Menu',
        craft_shovel = 'Craft Shovel',
        craft_axe = 'Craft Axe',
        craft_pickAxe = 'Craft PickAxe'
    },
    commands = {
        get_your_crafting_reputation = 'get your crafting reputation',
    },
    progressbar = {
      making_copy_of = 'Making a copy of ',
      copy = 'copy-',
      crafting_shovel = 'Crafting a Shovel..',
      crafting_axe= 'Crafting a Axe..',
      crafting_pickAxe = 'Crafting a PickAxe..',
    },
    text = {
      xbpc_xsteel_xwood = '1 x BPC / 3 x Steel / 1 x Wood'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- wooden_cart = '"Wooden Cart %{numbercart}',
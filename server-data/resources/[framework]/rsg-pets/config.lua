Config = {}

Config.enable_blip = true
Config.whistle_wait = 10000

Config.Blip = {
    blipName = 'Pet Shop',
    blipSprite = 1475879922,
    blipScale = 0.2
}

Config.PetShop = {
    -- dogs
    [1] =  { name = "foxhound",     price = 250, amount = 50, info = {}, type = "item", slot = 1, },
    [2] =  { name = "sheperd",      price = 250, amount = 50, info = {}, type = "item", slot = 2, },
    [3] =  { name = "coonhound",    price = 250, amount = 50, info = {}, type = "item", slot = 3, },
    [4] =  { name = "catahoulacur", price = 250, amount = 50, info = {}, type = "item", slot = 4, },
    [5] =  { name = "bayretriever", price = 250, amount = 50, info = {}, type = "item", slot = 5, },
    [6] =  { name = "collie",       price = 250, amount = 50, info = {}, type = "item", slot = 6, },
    [7] =  { name = "hound",        price = 250, amount = 50, info = {}, type = "item", slot = 7, },
    [8] =  { name = "husky",        price = 250, amount = 50, info = {}, type = "item", slot = 8, },
    [9] =  { name = "lab",          price = 250, amount = 50, info = {}, type = "item", slot = 9, },
    [10] = { name = "poodle",       price = 250, amount = 50, info = {}, type = "item", slot = 10, },
    [11] = { name = "street",       price = 250, amount = 50, info = {}, type = "item", slot = 11, },
}

Config.PetShopLocations = {

    {name = 'Valentine Pet Shop', shopname = 'valentine-pets', coords = vector3(-360.5724, 784.24835, 116.15647), showblip = true},
}

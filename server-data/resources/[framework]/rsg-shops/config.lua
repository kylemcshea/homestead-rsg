Config = {}

Config.Products = {
    ["normal"] = {
        [1] =  { name = "water",                             price = 0.50, amount = 500, info = {}, type = "item", slot = 1 },
        [2] =  { name = "bread",                             price = 0.50, amount = 500, info = {}, type = "item", slot = 2 },
        [3] =  { name = "fieldbandage",                      price = 1.00, amount = 500, info = {}, type = "item", slot = 3 },
        [4] =  { name = "horsebrush",                        price = 10,   amount = 100, info = {}, type = "item", slot = 4 },
        [5] =  { name = "horselantern",                      price = 25,   amount = 100, info = {}, type = "item", slot = 5 },
        [6] =  { name = "goldpan",                           price = 10,   amount = 100, info = {}, type = "item", slot = 6 },
        [7] =  { name = "goldsmelt",                         price = 50,   amount = 100, info = {}, type = "item", slot = 7 },
        [8] =  { name = "campfire",                          price = 10,   amount = 100, info = {}, type = "item", slot = 8 },
        [9] =  { name = "shovel",                            price = 5,    amount = 100, info = {}, type = "item", slot = 9 },
        [10] = { name = "axe",                               price = 5,    amount = 100, info = {}, type = "item", slot = 10 },
        [11] = { name = "pickaxe",                           price = 5,    amount = 100, info = {}, type = "item", slot = 11 },
        [12] = { name = "weapon_kit_binoculars",             price = 25,   amount = 100, info = {}, type = "weapon", slot = 12 },
        [13] = { name = "weapon_kit_binoculars_improved",    price = 50,   amount = 100, info = {}, type = "weapon", slot = 13 },
        [14] = { name = "weapon_kit_metal_detector",         price = 25,   amount = 100, info = {}, type = "weapon", slot = 14 },
    },
    ["weapons"] = {
        -- WEAPONS REVOLVER
        [1] = { name = "weapon_revolver_cattleman",            price = 50,  amount = 50,   info = {}, type = "weapon", slot = 1, },
        [2] = { name = "weapon_revolver_cattleman_mexican",    price = 127, amount = 50,   info = {}, type = "weapon", slot = 2, },
        [3] = { name = "weapon_revolver_doubleaction_gambler", price = 190, amount = 50,   info = {}, type = "weapon", slot = 3, },
        [4] = { name = "weapon_revolver_schofield",            price = 192, amount = 50,   info = {}, type = "weapon", slot = 4, },
        [5] = { name = "weapon_revolver_navy",                 price = 275, amount = 50,   info = {}, type = "weapon", slot = 5, },
        [6] = { name = "weapon_revolver_navy_crossover",       price = 349, amount = 50,   info = {}, type = "weapon", slot = 6, },
        [7] = { name = "weapon_revolver_lemat",                price = 317, amount = 50,   info = {}, type = "weapon", slot = 7, },
        -- WEAPONS PISTOL
        [8] = { name = "weapon_pistol_volcanic",               price = 270, amount = 50,   info = {}, type = "weapon", slot = 8, },
        [9] = { name = "weapon_pistol_semiauto",               price = 537, amount = 50,   info = {}, type = "weapon", slot = 9, },
        [10] = { name = "weapon_pistol_mauser",                price = 600, amount = 50,   info = {}, type = "weapon", slot = 10, },
        -- WEAPONS RIFLE
        [11] = { name = "weapon_rifle_varmint",                price = 75,  amount = 50,   info = {}, type = "weapon", slot = 11, },
        [12] = { name = "weapon_rifle_springfield",            price = 156, amount = 50,   info = {}, type = "weapon", slot = 12, },
        [13] = { name = "weapon_rifle_boltaction",             price = 216, amount = 50,   info = {}, type = "weapon", slot = 13, },
        [14] = { name = "weapon_sniperrifle_rollingblock",     price = 411, amount = 50,   info = {}, type = "weapon", slot = 14, },
        -- WEAPONS REPEATER
        [15] = { name = "weapon_repeater_carbine",             price = 90,  amount = 50,   info = {}, type = "weapon", slot = 15, },
        [16] = { name = "weapon_repeater_evans",               price = 300, amount = 50,   info = {}, type = "weapon", slot = 16, },
        [17] = { name = "weapon_repeater_winchester",          price = 243, amount = 50,   info = {}, type = "weapon", slot = 17, },
        [18] = { name = "weapon_repeater_henry",               price = 348, amount = 50,   info = {}, type = "weapon", slot = 18, },
        [19] = { name = "weapon_rifle_elephant",               price = 580, amount = 50,   info = {}, type = "weapon", slot = 19, },
        -- WEAPONS SHOTGUN
        [20] = { name = "weapon_shotgun_sawedoff",             price = 111, amount = 50,   info = {}, type = "weapon", slot = 20, },
        [21] = { name = "weapon_shotgun_doublebarrel",         price = 185, amount = 50,   info = {}, type = "weapon", slot = 21, },
        [22] = { name = "weapon_shotgun_semiauto",             price = 540, amount = 50,   info = {}, type = "weapon", slot = 22, },
        -- WEAPONS OTHER
        [23] = { name = "weapon_melee_knife",                  price = 75,  amount = 50,   info = {}, type = "weapon", slot = 23, },
        [24] = { name = "weapon_lasso",                        price = 5,   amount = 50,   info = {}, type = "weapon", slot = 24, },
        [25] = { name = "weapon_bow",                          price = 10,  amount = 50,   info = {}, type = "weapon", slot = 25, },
        [26] = { name = "weapon_bow_improved",                 price = 30,  amount = 50,   info = {}, type = "weapon", slot = 26, },
        -- AMMO
        [27] = { name = "ammo_revolver",                       price = 0.50, amount = 500, info = {}, type = "item",   slot = 27, },
        [28] = { name = "ammo_pistol",                         price = 0.50, amount = 500, info = {}, type = "item",   slot = 28, },
        [29] = { name = "ammo_rifle",                          price = 0.75, amount = 500, info = {}, type = "item",   slot = 29, },
        [30] = { name = "ammo_varmint",                        price = 0.75, amount = 500, info = {}, type = "item",   slot = 30, },
        [31] = { name = "ammo_rifle_elephant",                 price = 0.75, amount = 500, info = {}, type = "item",   slot = 31, },
        [32] = { name = "ammo_repeater",                       price = 0.75, amount = 500, info = {}, type = "item",   slot = 32, },
        [33] = { name = "ammo_shotgun",                        price = 0.75, amount = 500, info = {}, type = "item",   slot = 33, },
        [34] = { name = "ammo_arrow",                          price = 0.10, amount = 500, info = {}, type = "item",   slot = 34, },
    },
}

-- shop locations and blips
Config.Locations = {
    {
        name = 'Rhodes General Store',
        location = 'gen-rhodes',
        products = "normal",
        shopcoords = vector3(1328.99, -1293.28, 77.02 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Valentine General Store',
        location = 'gen-valentine',
        products = "normal",
        shopcoords = vector3(-322.433, 803.797, 117.882 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Strawberry General Store',
        location = 'gen-strawberry',
        products = "normal",
        shopcoords = vector3(-1791.49, -386.87, 160.33 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Annesburg General Store',
        location = 'gen-annesburg',
        products = "normal",
        shopcoords = vector3(2931.35, 1365.94, 45.19 -0.8),
        showblip = true
    },
    {
        name = 'Saint Denis General Store',
        location = 'gen-stdenis',
        products = "normal",
        shopcoords = vector3(2859.81, -1200.37, 49.59 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Tumbleweed General Store',
        location = 'gen-tumbleweed',
        products = "normal",
        shopcoords = vector3(-5487.613, -2938.54, -0.38 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Armadillo General Store',
        location = 'gen-armadillo',
        products = "normal",
        shopcoords = vector3(-3685.56, -2622.59, -13.43 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Blackwater General Store',
        location = 'gen-blackwater',
        products = "normal",
        shopcoords = vector3(-785.18, -1323.83, 43.88 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Van Horn General Store',
        location = 'gen-vanhorn',
        products = "normal",
        shopcoords = vector3(3027.03, 561.00, 44.72 -0.8),
        blipsprite = 1475879922,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Valentine Gunsmith',
        location = 'gun-valentine',
        products = "weapons",
        shopcoords = vector3(-281.97, 781.09,119.52 -0.8),
        blipsprite = 4149098929,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Tumbleweed Gunsmith',
        location = 'gun-tumbleweed',
        products = "weapons",
        shopcoords = vector3(-5508.14, -2964.33,-0.628 -0.8),
        blipsprite = 4149098929,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Saint Denis Gunsmith',
        location = 'gun-stdenis',
        products = "weapons",
        shopcoords = vector3(2716.42, -1285.42,49.63 -0.8),
        blipsprite = 4149098929,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Rhodes Gunsmith',
        location = 'gun-rhodes',
        products = "weapons",
        shopcoords = vector3(1322.67, -1323.16,77.88 -0.8),
        blipsprite = 4149098929,
        blipscale = 0.2,
        showblip = true
    },
    {
        name = 'Annesburg Gunsmith',
        location = 'gun-annesburg',
        products = "weapons",
        shopcoords = vector3(2946.50, 1319.53,44.82 -0.8),
        blipsprite = 4149098929,
        blipscale = 0.2,
        showblip = true
    },
}

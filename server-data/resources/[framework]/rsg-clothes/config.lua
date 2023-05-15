Config = {}
Config.Shoptext = 'Press ~INPUT_JUMP~ to open a clothing store' -- Text to open the clothing shop
Config.Cloakroomtext = 'Press ~INPUT_JUMP~ to open the changing rooms' -- Text to open the clothing shop
Config.BlipName = 'A clothing store' -- Blip Name Showed on map
Config.BlipNameCloakRoom = 'Wardrobe' -- Blip Name Showed on map
Config.BlipSprite = 1195729388	 -- Clothing shop sprite
Config.BlipSpriteCloakRoom = 1496995379	 -- Clothing shop sprite
Config.BlipScale = 0.2 -- Blip scale
Config.OpenKey = 0xD9D0E1C0 -- Opening key hash
Config.Zones = {
    vector3(-325.5,774.57,117.45), -- VALENTINE
    vector3(1326.42, -1289.56, 77.02), -- RHODES
    vector3(2550.81,-1166.28,53.68), -- SAINT DENIS
    vector3(-767.94,-1294.95,43.84), -- BLACK WATER
    vector3(-1794.89,-385.22,160.33), -- STRAWBERRY
    vector3(-3689.37,-2628.01,-13.41), -- ARMADILO
    vector3(-5490.97,-2938.28,-0.4) -- TUMBLEWEED
}

Config.Cloakroom = {
    vector3(-325.29,766.24,117.48), -- VALENTINE
    vector3(-1817.11,-368.77,166.54), 
    vector3(-825.40,-1323.76,47.91), 
    vector3(1331.86,-1377.35,80.55), 
    vector3(2556.49,-1160.14,53.74) 
}

Config.Label = {
    ["boot_accessories"] = "Boot Accessories",
    ["pants"] = "Pants",
    ["cloaks"] = "Cloaks",
    ["hats"] = "Hats",
    ["vests"] = "Vests",
    ["chaps"] = "Chaps",
    ["shirts_full"] = "Shirts Full",
    ["badges"] = "Badges",
    ["masks"] = "Masks",
    ["spats"] = "Spats",
    ["neckwear"] = "Neck Wear",
    ["boots"] = "Boots",
    ["accessories"] = "Accessories",
    ["jewelry_rings_right"] = "Jewelry Rings Right",
    ["jewelry_rings_left"]    = "Jewelry Rings Reft",
    ["jewelry_bracelets"] = "Jewelry Bracelets",
    ["gauntlets"] = "Gaunt Lets",
    ["neckties"] = "Neck Ties",
    ["holsters_knife"] = "Holsters Knife",
    ["talisman_holster"] = "Talisman Holster",
    ["loadouts"] = "Load outs",
    ["suspenders"] = "Suspenders",
    ["talisman_satchel"] = "Talisman Satchel",
    ["satchels"] = "Satchels",
    ["gunbelts"] = "Gun Belts",
    ["belts"] = "Belts",
    ["belt_buckles"] = "Belt Buckles",
    ["holsters_left"] = "Holsters Left",
    ["holsters_right"] = "Holsters Right",
    ["talisman_wrist"] = "Talisman Wrist",
    ["coats"] = "Coats",
    ["coats_closed"] = "Coats Closed",
    ["ponchos"] = "Ponchos",
    ["eyewear"] = "Eyewear",
    ["gloves"] = "Gloves",
    ["holsters_crossdraw"] = "Holsters Crossdraw",
    ["aprons"] = "Aprons",
    ["skirts"] = "Skirts",
    ["hair_accessories"] = "Hair Accessories",
    ["armor"] = "Armor",
    ["dresses"] = "Dresses",
}

Config.Price = {
    ["boot_accessories"] = 4,
    ["pants"] = 2,
    ["cloaks"] = 4,
    ["hats"] = 2,
    ["vests"] = 2,
    ["chaps"] = 2,
    ["shirts_full"] = 2,
    ["badges"] = 10,
    ["masks"] = 5,
    ["spats"] = 3,
    ["neckwear"] = 2,
    ["boots"] = 2,
    ["accessories"] = 5,
    ["jewelry_rings_right"] = 10,
    ["jewelry_rings_left"] = 10,
    ["jewelry_bracelets"] = 6,
    ["gauntlets"] = 3,
    ["neckties"] = 3,
    ["holsters_knife"] = 3,
    ["talisman_holster"] = 3,
    ["loadouts"] = 5,
    ["suspenders"] = 3,
    ["talisman_satchel"] = 3,
    ["satchels"] = 3,
    ["gunbelts"] = 3,
    ["belts"] = 2,
    ["belt_buckles"] = 6,
    ["holsters_left"] = 5,
    ["holsters_right"] = 5,
    ["talisman_wrist"] = 5,
    ["coats"] = 5,
    ["coats_closed"] = 5,
    ["ponchos"] = 3,
    ["eyewear"] = 5,
    ["gloves"] = 3,
    ["holsters_crossdraw"] = 4,
    ["aprons"] = 4,
    ["skirts"] = 2,
    ["hair_accessories"] = 2,
    ["dresses"] = 1,  
    ["armor"] = 20,        
}

Config.MenuElements = {
    ["head"] = {
        label = "Head",
        category = {
            "hats",
            "eyewear",
            "masks",
            "neckwear",
            "neckties",
        }
    },

    ["torso"] = {
        label = "Torso",
        category = {
            "cloaks",
            "vests",
            "shirts_full",
            "holsters_knife",
            "loadouts",
            "suspenders",
            "gunbelts",
            "belts",
            "holsters_left",
            "holsters_right",
            "coats",
            "coats_closed",
            "ponchos",
            "dresses",
        }
    },

    ["legs"] = {
        label = "Legs",
        category = {
            "pants",
            "chaps",
            "skirts",
        }
    },
    ["foot"] = {
        label = "Foot",
        category = {
            "boots",
            "spats",
            "boot_accessories",
        }
    },

    ["hands"] = {
        label = "Hands",
        category = {
            "jewelry_rings_right",
            "jewelry_rings_left",
            "jewelry_bracelets",
            "gauntlets",
            "gloves",
        }
    },

    ["accessories"] = {
        label = "Accessories",
        category = {
            "accessories",
            "talisman_wrist",
            "talisman_holster",
            "belt_buckles",
            "satchels",
            "holsters_crossdraw",
            "aprons",
            "bows",
            "armor",
            "badges",
            "hair_accessories",
        }
    },
}
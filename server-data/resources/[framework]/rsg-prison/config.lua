Config = {}

-- config settings
Config.RemoveJob = true -- if true then player loses job
Config.MarkerDistance = 10.0 -- distance for the marker to show

-- blip config
Config.Blip = {
    blipName = 'Sisika Prison', -- Config.Blip.blipName
    blipSprite = 'blip_mp_roles_bounty_hunter_lock', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- locations
Config.Locations = {
    ["outside"] = { coords = vector4(3340.71, -629.99, 43.72, 36.36) },
    ["middle"] = { coords = vector4(3357.41, -679.26, 46.26, 165.59) },
    spawns = {
        [1] = { coords = vector4(3330.66, -692.75, 43.95, 292.86) },
        [2] = { coords = vector4(3349.62, -650.41, 45.38, 207.53) },
        [3] = { coords = vector4(3380.62, -672.35, 46.27, 110.95) },
        [4] = { coords = vector4(3366.75, -666.08, 46.34, 297.69) }
    }
}

-- prison menu location
Config.MenuLocations = {
    {    --sisika jail
        name = 'Jail Menu',
        prompt = 'sisikaprison',
        coords = vector3(3351.2497, -689.4622, 44.021572 -0.8),
        showblip = true,
        showmarker = true 
    }, 
}

-- jail shop
Config.PrisonShop = {
    [1] = {
        name = "bread",
        price = 1,
        amount = 50,
        info = {},
        type = "item",
        slot = 1
    },
    [2] = {
        name = "water",
        price = 1,
        amount = 50,
        info = {},
        type = "item",
        slot = 2
    }
}

Config.PrisonZone =
{
    [1] =
    {
        name = "prison",
        zones =
        {
            vector2(3318.3984375, -657.3021850586),
            vector2(3318.3984375, -657.3021850586),
            vector2(3384.744140625, -640.3119506836),
            vector2(3406.6110839844, -678.14178466796),
            vector2(3368.9548339844, -724.2036743164),
            vector2(3334.6440429688, -704.1216430664),
            vector2(3329.4631347656, -698.779296875),
            vector2(3318.314453125, -656.95434570312)
        },
        minZ = 44.26696395874,
        maxZ = 46.395713806152
    }
}
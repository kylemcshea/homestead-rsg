Config = {}

-- settings
Config.JobRequired = 'wholesaletrader'
Config.StorageMaxWeight = 4000000
Config.StorageMaxSlots = 48
Config.StorageName = 'Wholesale_Storage' -- do not change this once active

-----------------------------------------------------------------------------------

-- wholesale blip
Config.WholesaleBlip = {
    blipName = 'Wholesale Trader', -- Config.Blip.blipName
    blipSprite = 'blip_mp_trader_introduction', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- wholesale prompt locations
Config.WholesaleLocations = {

    {   -- saint denis
        name = 'St Denis Wholesale Trader',
        prompt = 'wholesale-1',
        job = 'stdeniswholesale',
        coords = vector3(2349.6372, -1477.177, 46.921913 -0.8),
        showblip = true,
        showmarker = true
    },
    {    -- blackwater
        name = 'Blackwater Wholesale Trader',
        prompt = 'wholesale-2',
        job = 'blkwholesale',
        coords = vector3(-738.3149, -1337.646, 44.176853 -0.8),
        showblip = true,
        showmarker = true
    }, 
    
}

Config.WholesaleShop = {
    [1] = {
        name = 'beer',
        price = 1,
        amount = 5000,
        info = {},
        type = 'item',
        slot = 1,
    },
    [2] = {
        name = 'whiskey',
        price = 2,
        amount = 5000,
        info = {},
        type = 'item',
        slot = 2,
    },
}

-----------------------------------------------------------------------------------

Config = Config or {}
Config.FarmPlants = {}

-- job settings
Config.EnableJob = false -- (true = job required / false = anyone can farm)
Config.JobRequired = 'farmer' -- job required to farm (N/A if Config.EnableJob = false)

-- start plant settings
Config.GrowthTimer = 60000 -- 60000 = every 1 min / testing 1000 = 1 seconds
Config.DeadPlantTime = 60 * 60 * 72 -- time until plant is dead and removed from db - e.g. 60 * 60 * 24 for 1 day / 60 * 60 * 48 for 2 days / 60 * 60 * 72 for 3 days
Config.StartingThirst = 100.0 -- starting plan thirst percentage
Config.StartingHunger = 100.0 -- starting plan hunger percentage
Config.HungerIncrease = 25.0 -- amount increased when watered
Config.ThirstIncrease = 25.0 -- amount increased when fertilizer is used
Config.Degrade = {min = 3, max = 5}
Config.QualityDegrade = {min = 8, max = 12}
Config.GrowthIncrease = {min = 10, max = 20}
Config.MaxPlantCount = 40 -- maximum plants play can have at any one time
Config.UseFarmingZones = true -- true = use farmzones / false = no farmzones
Config.UseSeedBasedZones = true -- true = use seed based farmzones / false = no seed based specific farmzones
Config.NotificationSound = true -- when UseSeedBasedZones is enabled, play notification sound when the player is doing some actions
Config.ProgressBar = true -- add progress bar when the player is doing some actions
Config.CollectWaterTime = 30000 -- time set to collect water
Config.CollectPooTime = 30000 -- time set to collect fertilizer

-- farm plants
Config.FarmItems = {
    {
        planttype = 'corn',
        item = 'corn',
        label = Lang:t('label.corn'),
        -- reward settings
        poorRewardMin = 1,
        poorRewardMax = 2,
        goodRewardMin = 3,
        goodRewardMax = 4,
        exellentRewardMin = 5,
        exellentRewardMax = 6,
    },
    {
        planttype = 'sugar',
        item = 'sugar',
        label =  Lang:t('label.sugar'),
        -- reward settings
        poorRewardMin = 1,
        poorRewardMax = 2,
        goodRewardMin = 3,
        goodRewardMax = 4,
        exellentRewardMin = 5,
        exellentRewardMax = 6,
    },
    {
        planttype = 'tobacco',
        item = 'tobacco',
        label = Lang:t('label.tobacco'),
        -- reward settings
        poorRewardMin = 1,
        poorRewardMax = 2,
        goodRewardMin = 3,
        goodRewardMax = 4,
        exellentRewardMin = 5,
        exellentRewardMax = 6,
    },
    {
        planttype = 'carrot',
        item = 'carrot',
        label = Lang:t('label.carrot'),
        -- reward settings
        poorRewardMin = 1,
        poorRewardMax = 2,
        goodRewardMin = 3,
        goodRewardMax = 4,
        exellentRewardMin = 5,
        exellentRewardMax = 6,
    },
    {
        planttype = 'tomato',
        item = 'tomato',
        label = Lang:t('label.tomato'),
        -- reward settings
        poorRewardMin = 1,
        poorRewardMax = 2,
        goodRewardMin = 3,
        goodRewardMax = 4,
        exellentRewardMin = 5,
        exellentRewardMax = 6,
    },
    {
        planttype = 'broccoli',
        item = 'broccoli',
        label = Lang:t('label.broccoli'),
        -- reward settings
        poorRewardMin = 1,
        poorRewardMax = 2,
        goodRewardMin = 3,
        goodRewardMax = 4,
        exellentRewardMin = 5,
        exellentRewardMax = 6,
    },
    {
        planttype = 'potato',
        item = 'potato',
        label = Lang:t('label.potato'),
        -- reward settings
        poorRewardMin = 1,
        poorRewardMax = 2,
        goodRewardMin = 3,
        goodRewardMax = 4,
        exellentRewardMin = 5,
        exellentRewardMax = 6,
    },
}
-- end plant settings

Config.Blip = {
    blipName = Lang:t('blip.farm_shop'), -- Config.Blip.blipName
    blipSprite = 'blip_shop_market_stall', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- farm shop
Config.FarmShop = {
     [1] = { name = "carrotseed",   price = 0.10, amount = 500,  info = {}, type = "item", slot = 1, },
     [2] = { name = "cornseed",     price = 0.10, amount = 500,  info = {}, type = "item", slot = 2, },
     [3] = { name = "sugarseed",    price = 0.10, amount = 500,  info = {}, type = "item", slot = 3, },
     [4] = { name = "tobaccoseed",  price = 0.10, amount = 500,  info = {}, type = "item", slot = 4, },
     [5] = { name = "tomatoseed",   price = 0.10, amount = 500,  info = {}, type = "item", slot = 5, },
     [6] = { name = "broccoliseed", price = 0.10, amount = 500,  info = {}, type = "item", slot = 6, },
     [7] = { name = "potatoseed",   price = 0.10, amount = 500,  info = {}, type = "item", slot = 7, },
     [8] = { name = "bucket",       price = 10,   amount = 50,   info = {}, type = "item", slot = 8, },
     [9] = { name = "fertilizer",   price = 0.10, amount = 5000, info = {}, type = "item", slot = 9, },
}

-- farm shop locations
Config.FarmShopLocations = {
    {name = Lang:t('blip.farm_shop'), coords = vector3(-249.43, 685.72, 113.33), showblip = true, showmarker = true},
}

-- farm zone settings
Config.FarmZone = { 
    [1] = {
        zones = { -- example
            vector2(-347.09591674805, 894.11151123047),
            vector2(-390.92279052734, 889.30194091797),
            vector2(-392.01412963867, 911.32104492188),
            vector2(-373.91583251953, 913.11346435547),
            vector2(-369.53713989258, 944.28149414063),
            vector2(-349.36514282227, 941.19653320313)
        },
        name = "farmzone1",
        blipname =  Lang:t('blip.farmzone_farm_zone'),
        minZ = 115.78807830811,
        maxZ = 122.06151580811,
        showblip = true,
        blipcoords = vector3(-375.72, 900.24, 116.08)
    },
}

Config.WaterProps = {
    `p_watertrough01x`,
    `p_watertroughsml01x`,
    `p_watertrough01x_new`,
    `p_watertrough02x`,
    `p_watertrough03x`,
}

Config.FertilizerProps = {
    `p_horsepoop02x`,
    `p_horsepoop03x`,
    `new_p_horsepoop02x_static`,
    `p_poop01x`,
    `p_poop02x`,
    `p_poopile01x`,
    `p_sheeppoop01`,
    `p_sheeppoop02x`,
    `p_sheeppoop03x`,
    `p_wolfpoop01x`,
    `p_wolfpoop02x`,
    `p_wolfpoop03x`,
    `s_horsepoop01x`,
    `s_horsepoop02x`,
    `s_horsepoop03x`,
    `mp007_p_mp_horsepoop03x`,
}

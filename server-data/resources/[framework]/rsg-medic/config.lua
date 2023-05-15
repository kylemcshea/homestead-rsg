Config = {}

-- settings
Config.JobRequired = 'medic'
Config.StorageMaxWeight = 4000000
Config.StorageMaxSlots = 48
Config.DeathTimer = 300 -- 300 = 5 mins / testing 60 = 1 min
Config.WipeInventoryOnRespawn = false
Config.WipeCashOnRespawn = false
Config.MaxHealth = 600
Config.MedicReviveTime = 5000
Config.MedicTreatTime = 5000
Config.DisableRegeneration = false -- enable/disable player health regenerations

-- blip settings
Config.Blip = {
    blipName = 'Medic', -- Config.Blip.blipName
    blipSprite = 'blip_shop_doctor', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- prompt locations
Config.MedicJobLocations = {
    {name = 'Valentine Medic', prompt = 'valmedic', coords = vector3(-287.59, 811.28, 119.39 -0.8), showblip = true, showmarker = true}, --valentine
}

-- medic supplies items
Config.MedicSupplies = {
    [1] = { name = "bandage", price = 0, amount = 500, info = {}, type = "item", slot = 1, },
    [2] = { name = "firstaid", price = 0, amount = 500, info = {}, type = "item", slot = 2, },
}

-- respawn locations
Config.RespawnLocations = {
    [1] = {coords = vector4(-242.69, 796.27, 121.16, 110.18)}, -- valentine
    [2] = {coords = vector4(-733.28, -1242.97, 44.73, 87.64)}, -- blackwater
    [3] = {coords = vector4(-1801.98, -366.95, 161.66, 236.04)}, -- strawberry
    [4] = {coords = vector4(-3613.85, -2640.1, -11.73, 47.92)}, -- armadillo
    [5] = {coords = vector4(-5436.5, -2930.96, 0.69, 182.25)}, -- tumbleweed
    [6] = {coords = vector4(2725.33, -1067.42, 47.4, 168.42)}, -- staint-denis
    [7] = {coords = vector4(1291.85, -1236.22, 80.93, 210.67)}, -- rhodes
    [8] = {coords = vector4(3033.01, 433.82, 63.81, 65.9)}, -- van-horn
    [9] = {coords = vector4(3016.71, 1345.64, 42.69, 67.85)}, -- annesburg
}

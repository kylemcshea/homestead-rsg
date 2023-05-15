Config = {}

-- settings
Config.SmallFishPrice = 1 -- price per small fish
Config.MediumFishPrice = 2 -- price per medium fish
Config.LargeFishPrice = 3 -- price per large fish

Config.Blip = {
    blipName = 'Fish Vendor', -- Config.Blip.blipName
    blipSprite = 'blip_mg_fishing', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- fish vendor shop items
Config.FishVendorShop = {
    [1] = { name = "weapon_fishingrod", price = 10,   amount = 500,  info = {}, type = "weapon", slot = 1, },
    [2] = { name = "p_baitbread01x",    price = 0.25, amount = 5000, info = {}, type = "item",   slot = 2, },
    [3] = { name = "p_baitcorn01x",     price = 0.25, amount = 5000, info = {}, type = "item",   slot = 3, },
    [4] = { name = "p_baitcheese01x",   price = 0.25, amount = 5000, info = {}, type = "item",   slot = 4, },
    [5] = { name = "p_baitworm01x",     price = 0.50, amount = 5000, info = {}, type = "item",   slot = 5, },
    [6] = { name = "p_baitcricket01x",  price = 0.50, amount = 5000, info = {}, type = "item",   slot = 6, },
    [7] = { name = "p_crawdad01x",      price = 0.50, amount = 5000, info = {}, type = "item",   slot = 7, },
}

-- prompt locations
Config.FishVendorLocations = {
    {name = 'St Denis Fish Vendor',   location = 'stdenis-fishvendor',    coords = vector3(2662.2517, -1505.653, 45.968982 -0.8), showblip = true}, --st denis
    {name = 'Valentine Fish Vendor',  location = 'valentine-fishvendor',  coords = vector3(-335.5372, 761.984, 116.58402 -0.8),   showblip = true}, --valentine
    {name = 'Rhodes Fish Vendor',     location = 'rhodes-fishvendor',     coords = vector3(1292.9488, -1274.879, 75.814758 -0.8), showblip = true}, -- rhodes
    {name = 'Annesburg Fish Vendor',  location = 'annesburg-fishvendor',  coords = vector3(3017.9001, 1352.2457, 42.735687 -0.8), showblip = true}, -- annesburg
    {name = 'Van Horn Fish Vendor',   location = 'vanhorn-fishvendor',    coords = vector3(2991.6115, 558.83947, 44.355224 -0.8), showblip = true}, -- vanhorn
    {name = 'Blackwater Fish Vendor', location = 'blackwater-fishvendor', coords = vector3(-724.5062, -1253.603, 44.734111 -0.8), showblip = true}, -- blackwater
    {name = 'Tumbleweed Fish Vendor', location = 'tumbleweed-fishvendor', coords = vector3(-5513.275, -2943.476, -2.025686 -0.8), showblip = true}, -- tumbleweed
    {name = 'River Fish Vendor',      location = 'river-fishvendor',      coords = vector3(-1451.595, -2685.068, 41.228832 -0.8), showblip = false}, -- river
}

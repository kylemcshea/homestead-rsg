Config = Config or {}
Config.Plants = {}

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
Config.DrugEffect = false -- true/false if you want to have drug effect occur
Config.DrugEffectTime = 300000 -- drug effect time in milliseconds
Config.YieldRewards = {
    {type = "indtobacco", rewardMin = 5, rewardMax = 6, item = 'indtobacco', label = 'Indian Tobacco'},
}
-- end plant settings

-- start indian trader settings
Config.IndianTobaccoImage = "qr-inventory/html/images/indtobacco.png"
Config.IndianTobaccoLabel = "10 x Tobacco = 1 x Cigar"

Config.Blip = {
    blipName = 'Indian Trader', -- Config.Blip.blipName
    blipSprite = 819673798, -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- indian trader shop
Config.IndianTraderShop = {

    [1] = { name = "indtobaccoseed", price = 10, amount = 50, info = {}, type = "item",	slot = 1, },

}

-- indian trader prompt locations
Config.IndianTraderLocations = {

    {name = 'Indian Trader', location = 'indiantrader-1', coords = vector3(451.8908, 2237.673, 247.85261), showblip = true, showmarker = true}, --indian reserve

}

-- end indian trader settings
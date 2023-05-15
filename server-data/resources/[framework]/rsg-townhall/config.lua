Config = {}

-- blip settings
Config.Blip = {
    blipName = 'Town Hall', -- Config.Blip.blipName
    blipSprite = 'blip_town', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

Config.TownHallLocations = {
    -- town hall locations
    { name = 'Valentine Town Hall', location = 'valentine-townhall', coords = vector3(-262.8333, 762.4367, 118.15124), showblip = true, showmarker = true }, --valentine
}

Config.Jobs = { -- not job must be in : qr-core -> shared -> jobs
    { job = 'farmer', lable = 'Farmer', description = 'Farm hand to help around the farm' },
    { job = 'unemployed', lable = 'Freelancer', description = 'Like to do your own thing' },
}

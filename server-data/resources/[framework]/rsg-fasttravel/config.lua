Config = {}

Config.Blip = {
    blipName = 'Fast Travel', -- Config.Blip.blipName
    blipSprite = 784218150, -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- how much to charge travelers
Config.AnnesburgPrice = 50
Config.ArmadilloPrice = 40
Config.BlackwaterPrice = 20
Config.RhodesPrice = 20
Config.StrawberryPrice = 10
Config.StDenisPrice = 30
Config.TumbleweedPrice = 50
Config.ValentinePrice = 30
Config.VanHornPrice = 40
Config.SisikaPrisonPrice = 10

Config.TravelTime = 30000 -- 10000 = 10 seconds / 30000 = 30 seconds

-- prompt locations
Config.FastTravelLocations = {

    {name = 'Fast Travel', location = 'annesburg',  coords = vector3(2931.614, 1283.1109, 44.65287 -0.8),  showblip = true, showmarker = true}, --annesburg
    {name = 'Fast Travel', location = 'armadillo',  coords = vector3(-3729.09, -2603.55, -12.94 -0.8),     showblip = true, showmarker = true}, --armadillo
    {name = 'Fast Travel', location = 'blackwater', coords = vector3(-830.92, -1343.15, 43.67 -0.8),       showblip = true, showmarker = true}, --blackwater
    {name = 'Fast Travel', location = 'rhodes',     coords = vector3(1231.26, -1299.74, 76.9 -0.8),        showblip = true, showmarker = true}, --rhodes
    {name = 'Fast Travel', location = 'strawberry', coords = vector3(-1827.5, -437.65, 159.78 -0.8),       showblip = true, showmarker = true}, --strawberry
    {name = 'Fast Travel', location = 'st-denis',   coords = vector3(2747.10, -1394.87, 46.18 -0.8),       showblip = true, showmarker = true}, --st denis
    {name = 'Fast Travel', location = 'tumbleweed', coords = vector3(-5501.2, -2954.32, -1.73 -0.8),       showblip = true, showmarker = true}, --tumbleweed
    {name = 'Fast Travel', location = 'valentine',  coords = vector3(-174.39, 633.33, 114.09 -0.8),        showblip = true, showmarker = true}, --valentine
    {name = 'Fast Travel', location = 'van-horn',   coords = vector3(2893.37, 624.33, 57.72 -0.8),         showblip = true, showmarker = true}, --van horn trading post
    {name = 'Fast Travel', location = 'sisika',     coords = vector3(3266.8964, -715.8876, 42.03495 -0.8), showblip = true, showmarker = true}, --sisika prison
}
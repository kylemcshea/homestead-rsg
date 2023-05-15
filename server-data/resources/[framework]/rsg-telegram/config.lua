Config = {}

-- General Settings
Config.Debug                = false -- Dnable/disable debug functions
Config.AllowSendToSelf      = false -- A debug functions to allow sending letter to ourself (testing purpose)
Config.ChargePlayer         = true -- Whether to charge the player when sending a letter
Config.CostPerLetter        = 0.50 -- Cost for sending a letter

-- Bird Post settings
Config.BirdModel            = 'A_C_Owl_01' -- Bird model to use
Config.AutoResurrect        = true -- Auto resurrect the bird when it's died while sending letters
Config.BirdArrivalDelay     = 20000 -- Set the bird to arrives after 20 secs
Config.BirdTimeout          = 180 -- When timeout reached, the bird will fail to deliver the letter

Config.Blip =
{
    blipSprite              = 'blip_post_office', -- Config.Blip.blipSprite
    blipScale               = 0.2 -- Config.Blip.blipScale
}

-- prompt locations
Config.PostOfficeLocations =
{

    {name = 'Valentine Post Office', location = 'valentine-postoffice',  coords = vector3(-178.9489, 626.83941, 114.08961), showblip = true}, -- valentine
    {name = 'Rhodes Post Office', location = 'rhodes-postoffice',     coords = vector3(1225.57, -1293.87, 76.91),        showblip = true}, -- rhodes
    {name = 'Saint Denis Post Office', location = 'saintdenis-postoffice', coords = vector3(2731.55, -1402.37, 46.18),        showblip = true}, -- saintdenis
    {name = 'Van Horn Post Office', location = 'vanhorn-postoffice',    coords = vector3(2986.1557, 568.51599, 44.627922), showblip = true}, -- vanhorn
    {name = 'Annesburg Post Office', location = 'annesburg-postoffice',   coords = vector3(2939.5173, 1288.5345, 44.652824), showblip = true}, -- annsburg
    {name = 'Wallace Station Post Office', location = 'wallace-postoffice',    coords = vector3(-1299.277, 401.93942, 95.383865), showblip = true}, -- wallace
    {name = 'Riggs Station Post Office', location = 'riggs-postoffice',      coords = vector3(-1094.87, -575.608, 82.410873),   showblip = true}, -- riggs
    {name = 'Flatneck Station Post Office', location = 'flatneck-postoffice',   coords = vector3(-875.054, -1328.753, 43.958003),  showblip = true}, -- flatneck
    {name = 'Armadillo Post Office', location = 'armadillo-postoffice',  coords = vector3(-3733.965, -2597.86, -12.92674),  showblip = true}, -- armadillo
    {name = 'Tumbleweed Post Office', location = 'tumbleweed-postoffice', coords = vector3(-5487.083, -2936.11, -0.402813),  showblip = true}, -- tumbleweed
    {name = 'Strawberry Post Office', location = 'strawberry-postoffice', coords = vector3(-1765.084, -384.1582, 157.74119), showblip = true}, -- strawberry
}
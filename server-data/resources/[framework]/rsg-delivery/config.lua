Config = {}

Config.Debug = false

Config.Blip = {
    blipName = 'Delivery Job', -- Config.Blip.blipName
    blipSprite = 'blip_ambient_delivery', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- delivery locations
Config.DeliveryLocations = {
    {   -- saint denis -> valentine ( distance 3794 / $37.94)
        name        = 'Valentine Delivery',
        deliveryid  = 'delivery1',
        cartspawn   = vector4(2898.8957, -1169.942, 46.093143, 100.06992),
        cart        = 'wagon04x',
        cargo       = 'pg_teamster_wagon04x_gen',
        light       = 'pg_teamster_wagon04x_lightupgrade3',
        startcoords = vector3(2904.1989, -1169.292, 46.112228),
        endcoords   = vector3(-350.7503, 788.47381, 116.0307),
        showgps     = true,
        showblip    = true
    },
    {   -- valentine -> blackwater ( distance 2200 / $22.00)
        name        = 'Blackwater Delivery',
        deliveryid  = 'delivery2',
        cartspawn   = vector4(-343.9931, 809.86401, 116.6878, 132.8083), 
        cart        = 'wagon04x',
        cargo       = 'pg_teamster_wagon04x_perishables',
        light       = 'pg_teamster_wagon04x_lightupgrade3',
        startcoords = vector3(-339.0577, 814.22424, 116.96039),
        endcoords   = vector3(-739.7944, -1354.417, 43.461048),
        showgps     = true,
        showblip    = true
    },
    {   -- blackwater -> strawberry ( distance 1303 / $13.03)
        name        = 'Strawberry Delivery',
        deliveryid  = 'delivery3',
        cartspawn   = vector4(-757.1296, -1225.244, 43.54446, 0.8211954), 
        cart        = 'cart01',
        cargo       = 'pg_teamster_cart01_breakables',
        light       = 'pg_teamster_cart01_lightupgrade3',
        startcoords = vector3(-743.7046, -1218.822, 43.29129),
        endcoords   = vector3(-1792.688, -434.3452, 155.59338),
        showgps     = true,
        showblip    = true
    },
    {   -- strawberry -> mcfarlands ranch ( distance 2033 / $20.33)
        name        = 'Ranch Delivery',
        deliveryid  = 'delivery4',
        cartspawn   = vector4(-1788.618, -439.5259, 155.18444, 80.844512), 
        cart        = 'wagon02x',
        cargo       = 'pg_vl_rancher01',
        light       = 'pg_teamster_wagon02x_lightupgrade3',
        startcoords = vector3(-1798.899, -425.6275, 156.37739),
        endcoords   = vector3(-2381.418, -2384.764, 61.069843),
        showgps     = true,
        showblip    = true
    },
    {   -- mcfarlands ranch -> tumbleweed  ( distance 3214 / $32.14)
        name        = 'Tumbleweed Delivery',
        deliveryid  = 'delivery5',
        cartspawn   = vector4(-2352.572, -2398.797, 62.061191, 175.71217), 
        cart        = 'wagon05x',
        cargo       = 'pg_teamster_wagon05x_gen',
        light       = 'pg_teamster_wagon05x_lightupgrade3',
        startcoords = vector3(-2357.585, -2367.583, 62.18066),
        endcoords   = vector3(-5521.942, -2938.532, -1.995861),
        showgps     = true,
        showblip    = true
    },
    {   -- tumbleweed -> annesburg  ( distance 9595 / $95.95)
        name        = 'The Long Run',
        deliveryid  = 'delivery6',
        cartspawn   = vector4(-5523.004, -2936.102, -2.007142, 255.0812), 
        cart        = 'wagon02x',
        cargo       = 'pg_gunforhire03x',
        light       = 'pg_teamster_wagon02x_lightupgrade3',
        startcoords = vector3(-5529.143, -2932.52, -1.95342),
        endcoords   = vector3(3017.0349, 1438.4769, 46.421833),
        showgps     = true,
        showblip    = true
    },
    {   -- oil fields -> van horn  ( distance 2528 / $25.28)
        name        = 'The Oil Run',
        deliveryid  = 'delivery7',
        cartspawn   = vector4(439.78543, 699.36962, 116.86561, 122.11738), 
        cart        = 'oilWagon02x',
        cargo       = '',
        light       = '',
        startcoords = vector3(444.06781, 695.92626, 116.71598),
        endcoords   = vector3(2964.2658, 563.59588, 44.368358),
        showgps     = true,
        showblip    = true
    },
}

-- https://github.com/femga/rdr3_discoveries/blob/f729ba03f75a591ce5c841642dc873345242f612/vehicles/vehicle_modding/vehicle_propsets.lua
-- https://github.com/femga/rdr3_discoveries/blob/f729ba03f75a591ce5c841642dc873345242f612/vehicles/vehicle_modding/vehicle_lantern_propsets.lua

Config = {}

Config.DoorList = {

    -----------------------------------------------------
    -- Valentine Sheriff Office 
    -----------------------------------------------------
    { -- front door
        authorizedJobs = { 'police' },
        doorid = 1988748538,
        objCoords  = vector3(-276.0126037597656, 802.591064453125, 118.41165161132812),
        textCoords  = vector3(-276.0126037597656, 802.591064453125, 119.41165161132812),
        objYaw = 10.0,
        locked = true,
        distance = 3.0
    },
    { -- back door
        authorizedJobs = { 'police' },
        doorid = 395506985,
        objCoords  = vector3(-275.8447570800781, 812.0270385742188, 118.41483306884766),
        textCoords  = vector3(-275.8447570800781, 812.0270385742188, 119.41483306884766),
        objYaw = -170.0,
        locked = true,
        distance = 3.0
    },
    { -- cells back door
        authorizedJobs = { 'police' },
        doorid = 1508776842,
        objCoords  = vector3(-270.76641845703125, 810.0264892578125, 118.39580535888672),
        textCoords  = vector3(-270.76641845703125, 810.0264892578125, 119.39580535888672),
        objYaw = -80.0,
        locked = true,
        distance = 1.0
    },
    { --cell area
        authorizedJobs = { 'police' },
        doorid = 535323366,
        objCoords  = vector3(-275.0232849121094, 809.2740478515625, 118.36856842041016),
        textCoords  = vector3(-275.0232849121094, 809.2740478515625, 119.36856842041016),
        objYaw = -80.0,
        locked = true,
        distance = 2.0
    },
    { --cell-1
        authorizedJobs = { 'police' },
        doorid = 295355979,
        objCoords  = vector3(-273.4643249511719, 809.966064453125, 118.36823272705078),
        textCoords  = vector3(-273.4643249511719, 809.966064453125, 119.36823272705078),
        objYaw = 10.0,
        locked = true,
        distance = 1.0
    },
    { -- cell-2
        authorizedJobs = { 'police' },
        doorid = 193903155,
        objCoords  = vector3(-272.0520935058594, 808.25830078125, 118.36851501464844),
        textCoords  = vector3(-272.0520935058594, 808.25830078125, 119.36851501464844),
        objYaw = -170.0,
        locked = true,
        distance = 1.0
    },

    -----------------------------------------------------
    -- Rhodes Sheriff Office
    -----------------------------------------------------
    {
        authorizedJobs = { 'police' }, -- front door
        doorid = 349074475,
        objCoords  = vector3(1359.710205078125, -1305.9600830078125, 76.76842498779297),
        textCoords  = vector3(1359.710205078125, -1305.9600830078125, 77.76842498779297),
        objYaw = 160.0,
        locked = true,
        distance = 3.0
    },
    {
        authorizedJobs = { 'police' }, -- back door
        doorid = 1614494720,
        objCoords = vector3(1359.097900390625, -1297.5343017578125, 76.78761291503906),
        textCoords = vector3(1359.097900390625, -1297.5343017578125, 77.78761291503906),
        objYaw = -110.0,
        locked = true,
        distance = 3.0
    },
    {
        authorizedJobs = { 'police' }, -- cell
        doorid = 1878514758,
        objCoords = vector3(1357.3343505859375, -1302.4530029296875, 76.76018524169922),
        textCoords = vector3(1357.3343505859375, -1302.4530029296875, 76.76018524169922),
        objYaw = 70.0,
        locked = true,
        distance = 1.5
    },
    -----------------------------------------------------
    -- Blackwater Sheriff Office
    -----------------------------------------------------
    {
        textCoords = vector3(-757.27, -1269.34, 44.04),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 3.0,
        doors = {
            {
                objYaw = 90.0,
                doorid = 3410720590,
                objCoords = vector3(-757.0421752929688, -1268.485107421875, 43.068603515625)
            },

            {
                objYaw = 90.0,
                doorid = 3821185084,
                objCoords = vector3(-757.0421142578125, -1269.9234619140625, 43.06863021850586)
            }
        }
    },
    {
        authorizedJobs = { 'police' }, -- back door
        doorid = 2810801921,
        objCoords  = vector3(-769.1370849609375, -1268.7451171875, 43.0400390625),
        textCoords  = vector3(-769.1370849609375, -1268.7451171875, 44.0400390625),
        objYaw = -90.0,
        locked = true,
        distance = 3.0
    },
    {
        authorizedJobs = { 'police' }, -- cell-1
        doorid = 2167775834,
        objCoords  = vector3(-763.52783203125, -1262.4608154296875, 43.02327346801758),
        textCoords  = vector3(-763.52783203125, -1262.4608154296875, 44.02327346801758),
        objYaw = -90.0,
        locked = true,
        distance = 1.0
    },
    {
        authorizedJobs = { 'police' }, -- cell-2
        doorid = 2514996159,
        objCoords  = vector3(-765.8607788085938, -1264.7044677734375, 43.02326965332031),
        textCoords  = vector3(-765.8607788085938, -1264.7044677734375, 44.02326965332031),
        objYaw = 90.0,
        locked = true,
        distance = 1.0
    },
    -----------------------------------------------------
    -- Strawberry Sheriff Office
    -----------------------------------------------------
    { -- front door
        authorizedJobs = { 'police' },
        doorid = 1821044729,
        objCoords  = vector3(-1806.6751708984375, -350.31280517578125, 163.64759826660156),
        textCoords  = vector3(-1806.6751708984375, -350.31280517578125, 164.64759826660156),
        objYaw = -115.0,
        locked = true,
        distance = 3.0
    },
    { -- cell-1
        authorizedJobs = { 'police' },
        doorid = 902070893,
        objCoords  = vector3(-1814.400390625, -353.1470947265625, 160.44180297851562),
        textCoords  = vector3(-1814.400390625, -353.1470947265625, 161.44180297851562),
        objYaw = -115.0,
        locked = true,
        distance = 1.5
    },
    {  -- cell-2
        authorizedJobs = { 'police' },
        doorid = 1207903970,
        objCoords  = vector3(-1812.0101318359375, -351.92095947265625, 160.46839904785156),
        textCoords  = vector3(-1812.0101318359375, -351.92095947265625, 161.46839904785156),
        objYaw = -25.0,
        locked = true,
        distance = 1.5
    },
    { -- back door
        authorizedJobs = { 'police' },
        doorid = 1514359658,
        objCoords  = vector3(-1812.669189453125, -345.08489990234375, 163.64759826660156),
        textCoords  = vector3(-1812.669189453125, -345.08489990234375, 164.64759826660156),
        objYaw = -115.0,
        locked = true,
        distance = 3.0
    },
    -----------------------------------------------------
    -- Saint Denis HQ Office
    -----------------------------------------------------
    { -- outside double doors
        textCoords = vector3(2516.144287109375, -1309.9276123046875, 48.95257186889648),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 1.5,
        doors = {
            {
                objYaw = 90.0,
                doorid = 417663242,
                objCoords = vector3(2516.144287109375, -1309.9276123046875, 47.95257186889648)
            },

            {
                objYaw = -90.0,
                doorid = 1611175760,
                objCoords = vector3(2516.14453125, -1307.724853515625, 47.95257186889648)
            }
        }
    },
    { -- inside double doors (left)
        textCoords = vector3(2510.90771484375, -1312.2154541015625, 48.95257186889648),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 1.5,
        doors = {
            {
                objYaw = -90.0,
                doorid = 3601535313,
                objCoords = vector3(2510.90771484375, -1312.2154541015625, 47.95257186889648)
            },

            {
                objYaw = -90.0,
                doorid = 3430284519,
                objCoords = vector3(2510.90771484375, -1310.4840087890625, 47.95257186889648)
            }
        }
    },
    { -- inside double doors (right)
        textCoords = vector3(2510.90771484375, -1307.141357421875, 48.95716857910156),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 1.5,
        doors = {
            {
                objYaw = -90.0,
                doorid = 3124713594,
                objCoords = vector3(2510.90771484375, -1307.141357421875, 47.95716857910156)
            },

            {
                objYaw = -90.0,
                doorid = 1879655431,
                objCoords = vector3(2510.90771484375, -1305.41162109375, 47.95716857910156)
            }
        }
    },
    { -- outside double doors (side-1)
        textCoords = vector3(2508.337646484375, -1317.2796630859375, 48.95257186889648),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 1.5,
        doors = {
            {
                objYaw = 180.0,
                doorid = 1020479727,
                objCoords = vector3(2508.337646484375, -1317.2796630859375, 47.95257186889648)
            },

            {
                objYaw = 180.0,
                doorid = 603068205,
                objCoords = vector3(2506.606201171875, -1317.2796630859375, 47.95257186889648)
            }
        }
    },
    { -- outside double doors (side-2)
        textCoords = vector3(2497.684814453125, -1317.28271484375, 48.95257186889648),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 1.5,
        doors = {
            {
                objYaw = 180.0,
                doorid = 305296302,
                objCoords = vector3(2497.684814453125, -1317.28271484375, 47.95257186889648)
            },

            {
                objYaw = 180.0,
                doorid = 2503834054,
                objCoords = vector3(2495.953369140625, -1317.28271484375, 47.95257186889648)
            }
        }
    },
    { -- outside double doors (back-1)
        textCoords = vector3(2493.37255859375, -1311.95654296875, 48.95257186889648),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 1.5,
        doors = {
            {
                objYaw = 90.0,
                doorid = 1992193795,
                objCoords = vector3(2493.37255859375, -1311.95654296875, 47.95257186889648)
            },

            {
                objYaw = 90.0,
                doorid = 1694749582,
                objCoords = vector3(2493.37255859375, -1310.2252197265625, 47.95257186889648)
            }
        }
    },
    { -- outside double doors (back-2)
        textCoords = vector3(2493.37255859375, -1307.41845703125, 48.95257186889648),
        authorizedJobs = { 'police' },
        locked = true,
        distance = 1.5,
        doors = {
            {
                objYaw = 90.0,
                doorid = 1979938193,
                objCoords = vector3(2493.37255859375, -1307.41845703125, 47.95257186889648)
            },

            {
                objYaw = 90.0,
                doorid = 1674105116,
                objCoords = vector3(2493.37255859375, -1305.68701171875, 47.95257186889648)
            }
        }
    },
    { -- cell-1
        authorizedJobs = { 'police' },
        doorid = 3365520707,
        objCoords  = vector3(2498.5, -1307.85595703125, 47.95327377319336),
        textCoords  = vector3(2498.5, -1307.85595703125, 48.95327377319336),
        objYaw = 0.0,
        locked = true,
        distance = 1.0
    },
    { -- cell-2
        authorizedJobs = { 'police' },
        doorid = 1995743734,
        objCoords  = vector3(2499.752197265625, -1309.8763427734375, 47.95327377319336),
        textCoords  = vector3(2499.752197265625, -1309.8763427734375, 48.95327377319336),
        objYaw = 180.0,
        locked = true,
        distance = 1.0
    },
    { -- cell-3
        authorizedJobs = { 'police' },
        doorid = 1711767580,
        objCoords  = vector3(2502.4296875, -1307.85595703125, 47.95327377319336),
        textCoords  = vector3(2502.4296875, -1307.85595703125, 48.95327377319336),
        objYaw = 0.0,
        locked = true,
        distance = 1.0
    },
    { -- cell-4
        authorizedJobs = { 'police' },
        doorid = 2515591150,
        objCoords  = vector3(2503.638671875, -1309.8763427734375, 47.95327377319336),
        textCoords  = vector3(2503.638671875, -1309.8763427734375, 48.95327377319336),
        objYaw = 180.0,
        locked = true,
        distance = 1.0
    },
    -----------------------------------------------------
    -- Sisika Jail thanks to mortimersays
    -----------------------------------------------------
    {
        authorizedJobs = { 'police' }, -- Main Gate Left Door
        doorid = 1692000954,
        objCoords  = vector3(3331.85, -700.07, 43.09),
        textCoords  = vector3(3331.85, -700.07, 43.09),
        objYaw = -47.99,
        locked = true,
        distance = 3
    },
    {
        authorizedJobs = { 'police' }, -- Main Gate Right Door
        doorid = -1819721708,
        objCoords  = vector3(3333.60, -702.02, 43.09),
        textCoords  = vector3(3333.60, -702.02, 43.09),
        objYaw = -47.99,
        locked = true,
        distance = 3
    },
    {
        authorizedJobs = { 'police' }, -- Side Gate North Interior Exit
        doorid = 559643844,
        objCoords  = vector3(3350.70, -648.00, 44.40),
        textCoords  = vector3(3350.70, -648.00, 44.40),
        objYaw = 14.99,
        locked = true,
        distance = 1.5
    },
    {
        authorizedJobs = { 'police' }, -- Side Gate North Exterior Exit
        doorid = 559643844,
        objCoords  = vector3(3349.96, -645.28, 44.41),
        textCoords  = vector3(3349.96, -645.28, 44.41),
        objYaw = 14.99,
        locked = true,
        distance = 1.5
    },
    {
        authorizedJobs = { 'police' }, -- NE Tower
        doorid = 4249790129,
        objCoords  = vector3(3384.6154785156, -639.47778320313, 45.466075897217),
        textCoords  = vector3(3384.6154785156, -639.47778320313, 45.466075897217),
        objYaw = -29.77,
        locked = true,
        distance = 1.5
    },
    {
        authorizedJobs = { 'police' }, -- Central Tower
        doorid = 559643844,
        objCoords  = vector3(3366.45, -680.12, 45.49),
        textCoords  = vector3(3366.45, -680.12, 45.49),
        objYaw = -85.0,
        locked = true,
        distance = 1.5
    },
    {
        authorizedJobs = { 'police' }, -- South Tower
        doorid = 559643844,
        objCoords  = vector3(3369.56, -723.59, 44.31),
        textCoords  = vector3(3369.56, -723.59, 44.31),
        objYaw = -179.43,
        locked = true,
        distance = 1.5
    },
    {
        authorizedJobs = { 'police' }, -- East Tower
        doorid = 559643844,
        objCoords  = vector3(3407.31, -677.72, 45.50),
        textCoords  = vector3(3407.31, -677.72, 45.50),
        objYaw = -99.40,
        locked = true,
        distance = 1.5
    },
    {
        authorizedJobs = { 'police' },
        doorid = -1694920053,
        objCoords  = vector3(3318.453125, -658.0032348632812, 44.8508186340332),
        textCoords  = vector3(3318.453125, -658.0032348632812, 44.8508186340332),
        objYaw = 59.9998550415039,
        locked = true,
        distance = 1.5
    },
}

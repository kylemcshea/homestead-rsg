Config = {}

Config.HorseInvWeight = 12000 --INVweight

Config.HorseInvSlots = 12 --INVslots
--Config.StableLocations = {
--    [1] = vector3()
--}

Config.Rhodescoords = vector3(1207.2, -202.53, 101.39)  --for despawning and spawning
Config.SDcoords = vector3(2537.91, -1360.08, 46.47)
Config.Annesburgcoords = vector3(2983.53, 1432.01, 44.87)
Config.Blackwatercoords = vector3(-948.53, -1343.16, 50.58)
Config.Tumbleweedcoords = vector3(-5517.2, -3030.53, -2.49)
Config.Strawberrycoords = vector3(-1815.69, -423.27, 160.1)


Config.ModelSpawns = { --for npcs
    ["Rhodes"] = {
        ["coords"] = vector3(1207.2, -202.53, 101.39),
        ["heading"] = 186.9,
        ["model"] = `U_M_M_BwmStablehand_01`,
    },
    ["Saint Denis"] = {
        ["coords"] = vector3(2537.91, -1360.08, 46.47),
        ["heading"] = 358.88,
        ["model"] = `U_M_M_BwmStablehand_01`,
    },
    ["Annesburg"] = {
        ["coords"] = vector3(2983.53, 1432.01, 44.87),
        ["heading"] = 128.09,
        ["model"] = `U_M_M_BwmStablehand_01`,
    },
    ["Blackwater"] = {
        ["coords"] = vector3(-948.53, -1343.16, 50.58),
        ["heading"] = 359.11,
        ["model"] = `U_M_M_BwmStablehand_01`,
    },
    ["Tumbleweed"] = {
        ["coords"] = vector3(-5517.2, -3030.53, -2.49),
        ["heading"] = 107.79,
        ["model"] = `U_M_M_BwmStablehand_01`,
    },
    ["Strawberry"] = {
        ["coords"] = vector3(-1815.69, -423.27, 160.1),
        ["heading"] = 346.91,
        ["model"] = `U_M_M_BwmStablehand_01`,
    },
}

Config.BoxZones = { --for wagons
    ["Rhodes"] = {
        [1] = {
            ["coords"] = vector3(1197.41, -197.62, 101.64),
            ["heading"] = 190.3,
            ["model"] = "WAGON04X",
            ["price"] = 250,
            ["names"] = "Chuck Wagon 4",
        },
        [2] = {
            ["coords"] = vector3(1190.7, -200.93, 101.37),
            ["heading"] = 209.24,
            ["model"] = "CART08",
            ["price"] = 125,
            ["names"] = "Small Cart 08",
        },
        [3] = {
            ["coords"] = vector3(1182.42, -208.64, 100.62),
            ["heading"] = 219.12,
            ["model"] = "CART01",
            ["price"] = 100,
            ["names"] = "Small Cart 01",
        },
        [4] = {
            ["coords"] = vector3(1208.72, -223.49, 99.43),
            ["heading"] = 287.05,
            ["model"] = "UTILLIWAG",
            ["price"] = 200,
            ["names"] = "Utlity Wagon",

        },
    },

    ["Strawberry"] = {
        [1] = {
            ["coords"] = vector3(-1812.53, -439.28, 159.03),
            ["heading"] = 170.51,
            ["model"] = "stagecoach006x",
            ["price"] = 400,
            ["names"] = "Large Stage Coach",
        },
        [2] = {
            ["coords"] = vector3(-1816.87, -437.82, 159.79),
            ["heading"] = 167.87,
            ["model"] = "supplywagon",
            ["price"] = 350,
            ["names"] = "Supply Wagon",
        },
        [3] = {
            ["coords"] = vector3(-1823.4, -438.81, 159.92),
            ["heading"] = 70.71,
            ["model"] = "cart02",
            ["price"] = 100,
            ["names"] = "Small Cart 2",
        },
    },

    ["Saint Denis"] = {
        [1] = {
            ["coords"] = vector3(2536.82, -1345.41, 47.02),
            ["heading"] = 181.45,
            ["model"] = "buggy01",
            ["price"] = 200,
            ["names"] = "Small Buggy 1",
        },
        [2] = {
            ["coords"] = vector3(2532.15, -1344.71, 47.02),
            ["heading"] = 181.45,
            ["model"] = "buggy02",
            ["price"] = 210,
            ["names"] = "Small Buggy 2",
        },
        [3] = {
            ["coords"] = vector3(2527.57, -1345.11, 47.04),
            ["heading"] = 181.45,
            ["model"] = "buggy03",
            ["price"] = 210,
            ["names"] = "Small Buggy 3",
        },
        [4] = {
            ["coords"] = vector3(2528.55, -1358.31, 46.56),
            ["heading"] = 2.06,
            ["model"] = "coach3",
            ["price"] = 350,
            ["names"] = "Coach 1",
        },
        [5] = {
            ["coords"] = vector3(2532.56, -1358.31, 46.55),
            ["heading"] = 2.06,
            ["model"] = "coach4",
            ["price"] = 400,
            ["names"] = "Small Coach 1",
        },
    },

    ["Annesburg"] = {
        [1] = {
            ["coords"] = vector3(2982.09, 1419.61, 44.75),
            ["heading"] = 123.95,
            ["model"] = "cart05",
            ["price"] = 100,
            ["names"] = "Small Barrel Cart",
        },
        [2] = {
            ["coords"] = vector3(2976.81, 1429.36, 44.71),
            ["heading"] = 224.35,
            ["model"] = "CART06",
            ["price"] = 100,
            ["names"] = "Small Cart 6",
        },
        [3] = {
            ["coords"] = vector3(2968.88, 1430.81, 44.72),
            ["heading"] = 219.07,
            ["model"] = "wagon02x",
            ["price"] = 300,
            ["names"] = "Large Wagon 2",
        },
    },

    ["Blackwater"] = {
        [1] = {
            ["coords"] = vector3(-957.9, -1325.25, 51.94),
            ["heading"] = 93.13,
            ["model"] = "wagon03x",
            ["price"] = 350,
            ["names"] = "Large Seated Wagon",
        },
        [2] = {
            ["coords"] = vector3(-981.74, -1318.25, 51.9),
            ["heading"] = 270.78,
            ["model"] = "wagon06x",
            ["price"] = 250,
            ["names"] = "Small Cargo Wagon",
        },
        [3] = {
            ["coords"] = vector3(-982.08, -1312.23, 51.75),
            ["heading"] = 270.78,
            ["model"] = "cart07",
            ["price"] = 120,
            ["names"] = "Small Cart 7",
        },
        [4] = {
            ["coords"] = vector3(-981.5, -1305.78, 52.21),
            ["heading"] = 270.78,
            ["model"] = "coach5",
            ["price"] = 270,
            ["names"] = "Coach 5",

        },
    },

    ["Tumbleweed"] = {
        [1] = {
            ["coords"] = vector3(-5531.65, -3026.41, -1.53),
            ["heading"] = 15.0,
            ["model"] = "cart04",
            ["price"] = 100,
            ["names"] = "Small Cart 4",
        },
        [2] = {
            ["coords"] = vector3(-5527.95, -3020.56, -1.67),
            ["heading"] = 288.48,
            ["model"] = "chuckwagon000x",
            ["price"] = 250,
            ["names"] = "Chuck Wagon",
        },
        [3] = {
            ["coords"] = vector3(-5524.13, -3033.15, -2.25),
            ["heading"] = 114.05,
            ["model"] = "wagontraveller01x",
            ["price"] = 150,
            ["names"] = "Travellers Wagon",
        },
        [4] = {

            ["coords"] = vector3(-5521.23, -3021.03, -2.24),
            ["heading"] = 199.99,
            ["model"] = "cart03",
            ["price"] = 100,
            ["names"] = "Small Cart 3",

        },
    }
}
  
    
--[[
wagontraveller01x IN USE
wagon06x IN USE
wagon05x
wagon04x IN USE
wagon03x IN USE
wagon02x IN USE
UTILLIWAG IN USE
supplywagon IN USE
stagecoach006x IN USE
stagecoach005x
stagecoach004x
stagecoach002x
stagecoach001x
logwagon
hutercart01
coach6
coach5 IN USE
coach4 IN USE
coach3 IN USE
coach2
chuckwagon002x
chuckwagon000x IN USE
cart08 IN USE
cart07 IN USE
cart06 IN USE
cart05 IN USE
cart04 IN USE
cart03 IN USE
cart02 IN USE
cart01 IN USE
buggy03 IN USE
buggy02 IN USE
buggy01 IN USE
]]
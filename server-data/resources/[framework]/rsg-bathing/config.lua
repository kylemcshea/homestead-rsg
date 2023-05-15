Config = {}

Config.NormalBathPrice = 1
Config.DeluxeBathPrice = 5

Config.BathingZones = {
    ["SaintDenis"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_ST_DENIS",
        rag = vector4(2629.4, -1223.33, 58.57, -92.66),
        consumer = vector3(2632.6, -1223.79, 59.59),
        lady = `CS_BATHINGLADIES_01`,
        guy = `CS_LeviSimon`,
        door = 779421929
    },
    ["Valentine"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_VALENTINE",
        rag = vector4(-317.37, 761.8, 116.44, 10.365),
        consumer = vector3(-320.56, 762.41, 117.44),
        lady = `CS_BATHINGLADIES_01`,
        guy = `CS_LeviSimon`,
        door = 142240370
    },
    ["Annesburg"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_ANNESBURG",
        rag = vector4(2952.65, 1334.7, 43.44, -291.27),
        consumer = vector3(2950.42, 1332.15, 44.44),
        lady = `CS_BATHINGLADIES_01`,
        guy = `CS_LeviSimon`,
        door = -201071322
    },
    ["Strawberry"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_STRAWBERRY",
        rag = vector4(-1812.83, -373.23, 165.5, 1.206),
        consumer = vector3(-1816.45, -372.44, 166.50),
        lady = `CS_BATHINGLADIES_01`,
        guy = `CS_LeviSimon`,
        door = 1256786197
    },
    ["Blackwater"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_BLACKWATER",
        rag = vector4(-823.86, -1318.84, 42.68, -0.459),
        consumer = vector3(-822.82, -1315.72, 43.58),
        lady = `CS_BATHINGLADIES_01`,
        guy = `CS_LeviSimon`,
        door = 1523300673
    },
    ["Vanhorn"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_VANHORN",
        rag = vector4(2987.62, 573.21, 46.86, 83.841),
        consumer = vector3(2986.31, 568.27, 47.85),
        lady = `CS_BATHINGLADIES_01`,
        guy = `CS_LeviSimon`,
        door = 1102743282
    },
    ["Rhodes"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_RHODES",
        rag = vector4(1336.85, -1378.04, 83.2897, 166.469),
        consumer = vector3(1340.11, -1379.6, 84.28),
        lady = `CS_BATHINGLADIES_01`,
        guy = `CS_LeviSimon`,
        door = -1847993131
    },
    --[[["Tumbleweed"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_TUMBLEWEED",
        rag = vector4(-5513.76, -2972.3, -1.78, 15.0),
        consumer = vector3(-5517.83, -2973.23, -0.78),
        lady = `CS_BATHINGLADIES_01`,
        door = 1682160693
    }]]
}

Config.BathingModes = {
    {
        transition = "Scrub_Head",
        scrub_freq = 0.75
    },
    {
        transition = "Scrub_Left_Arm",
        scrub_freq = 0.7,
        deluxe = true
    },
    {
        transition = "Scrub_Right_Arm",
        scrub_freq = 0.5,
        deluxe = true
    },
    {
        transition = "Scrub_Right_Leg",
        scrub_freq = 0.6,
        deluxe = true
    },
    {
        transition = "Scrub_Left_Leg",
        scrub_freq = 0.7,
        deluxe = true
    }
}

Config.DressElements = {}

Config.Prompts = {
    { label = ("Use the Bath (%s$)"):format(Config.NormalBathPrice), id = "START_BATHING" },
    { label = "Scrub ", id = "SCRUB", control = `INPUT_CONTEXT_X`, time = 2000 },
    { label = ("Luxury Service (%s$)"):format(Config.DeluxeBathPrice), id = "REQUEST_DELUXE_BATHING" },
    { label = "Get Out", id = "STOP_BATHING", control = `INPUT_INTERACT_NEG` }
}

Config.CreatedEntries = {}

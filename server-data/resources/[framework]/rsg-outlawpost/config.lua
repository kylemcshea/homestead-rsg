Config = {}

Config.GoldBarPrice = 800 -- amount of cash per 1 gold bar
Config.BloodMoneyPrice = 1 -- amount of cash per 1 blood money
Config.BloodMoneyImage = "qr-inventory/html/images/bloodmoney.png"
Config.BloodMoneyLabel = "Wash Blood Money"
Config.GoldBarImage = "qr-inventory/html/images/goldbar.png"
Config.GoldBarLabel = "Trade Gold Bars"
Config.MoneyType = 'bloodmoney'
Config.GoldType = 'goldbar'

Config.Mission1Npcs = {
    [1] = { ["Model"] = "G_M_O_UniExConfeds_01", ["Pos"] = vector3(1931.4353, 1949.5598, 265.98077 -1), ["Heading"] = 359.69161 },
    [2] = { ["Model"] = "G_M_Y_UniExConfeds_01", ["Pos"] = vector3(1930.9908, 1945.5352, 273.34613 -1), ["Heading"] = 103.16332 },
    [3] = { ["Model"] = "CS_exconfedsleader_01", ["Pos"] = vector3(1935.9511, 1945.3104, 273.34613 -1), ["Heading"] = 279.25952 },
    [4] = { ["Model"] = "G_M_Y_UNIEXCONFEDS_02", ["Pos"] = vector3(1933.7839, 1947.347, 273.34613 -1), ["Heading"] = 10.081657 },
    [5] = { ["Model"] = "U_M_M_UniExConfedsBounty_01", ["Pos"] = vector3(1933.241, 1943.338, 273.34613 -1), ["Heading"] = 188.71681 },
}

Config.HostileZones = {
    [1] = {
        zones = { -- hostile zone 1
            vector2(1877.1036376953, 1971.1844482422),
            vector2(1890.7808837891, 1923.84765625),
            vector2(1924.1072998047, 1898.5238037109),
            vector2(1956.9752197266, 1913.1842041016),
            vector2(1981.9665527344, 1937.1500244141),
            vector2(1973.2219238281, 2007.2391357422)
        },
        name = "hostile1",
        minZ = 246.91162109375,
        maxZ = 265.93811035156
    },
}

-- outlaw posts
Config.OutlawLocations = {
    {name = 'Outlaw Post',    location = 'outlaw-1',    coords = vector3(1934.1502, 1947.014, 263.01205),    showblip = true},
}

-- outlaw shop
Config.OutlawShop = {
    [1] = { name = "weapon_thrown_bolas",             price = 5, amount = 100, info = {}, type = "weapon", slot = 1, },
    [2] = { name = "weapon_thrown_bolas_hawkmoth",    price = 5, amount = 100, info = {}, type = "weapon", slot = 2, },
    [3] = { name = "weapon_thrown_bolas_ironspiked",  price = 5, amount = 100, info = {}, type = "weapon", slot = 3, },
    [4] = { name = "weapon_thrown_bolas_intertwined", price = 5, amount = 100, info = {}, type = "weapon", slot = 4, },
    [5] = { name = "weapon_thrown_dynamite",          price = 5, amount = 100, info = {}, type = "weapon", slot = 5, },
    [6] = { name = "weapon_thrown_molotov",           price = 5, amount = 100, info = {}, type = "weapon", slot = 6, },
    [7] = { name = "weapon_thrown_poisonbottle",      price = 5, amount = 100, info = {}, type = "weapon", slot = 7, },
    [8] = { name = "weapon_thrown_throwing_knives",   price = 5, amount = 100, info = {}, type = "weapon", slot = 8, },
    [9] = { name = "weapon_thrown_tomahawk",          price = 5, amount = 100, info = {}, type = "weapon", slot = 9, },
}
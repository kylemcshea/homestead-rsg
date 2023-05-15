Config = {}

Config.Debug            = false

-- settings
Config.BillingCycle     = 1 -- will remove credit every x hour/s
Config.LandTaxPerCycle  = 1 -- $ amount of tax added per cycle
Config.StartCredit      = 10
Config.CreditWarning    = 5 -- 5 x Config.LandTaxPerCycle amount : warning will trigger when < : example 5 x 1 = 5 so telegram will trigger on 4 hours
Config.SellBack         = 0.8 -- example: 0.5 = 50% of the buy price / 0.8 = 80% of the buy price
Config.StorageMaxWeight = 4000000
Config.StorageMaxSlots  = 50
Config.OwnedHouseBlips  = true -- when set to true, only the owned house will show the blip

-- blip settings
Config.Blip =
{
    blipName            = 'Estate Agent', -- Config.Blip.blipName
    blipSprite          = 'blip_robbery_home', -- Config.Blip.blipSprite
    blipScale           = 0.2 -- Config.Blip.blipScale
}

-- prompt locations
Config.EstateAgents =
{
    {    --valentine
        name            = 'Estate Agent',
        prompt          = 'valestateagent',
        coords          = vector3(-250.8893, 743.20239, 118.08129),
        location        = 'newhanover', -- state
        showblip        = true
    },
    {    --blackwater
        name            = 'Estate Agent',
        prompt          = 'blkestateagent',
        coords          = vector3(-792.3216, -1203.232, 43.645206),
        location        = 'westelizabeth', -- state
        showblip        = true
    },
    {    --armadillo
        name            = 'Estate Agent',
        prompt          = 'armestateagent',
        coords          = vector3(-3658.934, -2620.835, -13.3414),
        location        = 'newaustin', -- state
        showblip        = true
    },
    {    --hagen
        name            = 'Estate Agent',
        prompt          = 'hagestateagent',
        coords          = vector3(-1347.746, 2405.7084, 307.06127),
        location        = 'ambarino', -- state
        showblip        = true
    },
    {    --saint denis
        name            = 'Estate Agent',
        prompt          = 'stdenisestateagent',
        coords          = vector3(2596.5463, -1299.845, 52.817153),
        location        = 'lemoyne', -- state
        showblip        = true
    }
}

-- house config
Config.Houses =
{
    {    -- house1
        name            = 'House1',
        houseid         = 'house1',
        houseprompt     = 'houseprompt1',
        menucoords      = vector3(220.0229, 984.58837, 190.89463),
        blipcoords      = vector3(215.80004882813, 988.06512451172, 189.9015045166),
        showblip        = true
    },
    {    -- house2
        name            = 'House2',
        houseid         = 'house2',
        houseprompt     = 'houseprompt2',
        menucoords      = vector3(-608.9351, -33.68871, 85.995544),
        blipcoords      = vector3(-615.93969726563, -27.086599349976, 84.997604370117),
        showblip        = true
    },
    {    -- house3
        name            = 'House3',
        houseid         = 'house3',
        houseprompt     = 'houseprompt3',
        menucoords      = vector3(1887.1403, 300.56072, 77.066558),
        blipcoords      = vector3(1888.1700439453,297.95916748047,76.076202392578),
        showblip        = true
    },
    {    -- house4
        name            = 'House4',
        houseid         = 'house4',
        houseprompt     = 'houseprompt4',
        menucoords      = vector3(1787.467, -81.54805, 56.802436),
        blipcoords      = vector3(1781.1064453125,-89.115615844727,55.815963745117),
        showblip        = true
    },
    {    -- house5
        name            = 'House5',
        houseid         = 'house5',
        houseprompt     = 'houseprompt5',
        menucoords      = vector3(1269.6508, -412.1731, 97.596702),
        blipcoords      = vector3(1264.1951904297,-404.07095336914,96.595031738281),
        showblip        = true
    },
    {    -- house6
        name            = 'House6',
        houseid         = 'house6',
        houseprompt     = 'houseprompt6',
        menucoords      = vector3(1619.2441, -364.0213, 75.897171),
        blipcoords      = vector3(1627.2501220703,-366.25610351563,74.909873962402),
        showblip        = true
    },
    {    -- house7
        name            = 'House7',
        houseid         = 'house7',
        houseprompt     = 'houseprompt7',
        menucoords      = vector3(-2367.865, -2394.804, 62.278335),
        blipcoords      = vector3(-2368.841796875,-2390.40625,61.520217895508),
        showblip        = true
    },
    {    -- house8
        name            = 'House8',
        houseid         = 'house8',
        houseprompt     = 'houseprompt8',
        menucoords      = vector3(1120.2464, 492.69769, 97.284187),
        blipcoords      = vector3(1114.0626220703,493.74633789063,96.290939331055),
        showblip        = true
    },
    {    -- house9
        name            = 'House9',
        houseid         = 'house9',
        houseprompt     = 'houseprompt9',
        menucoords      = vector3(-63.72145, -392.5166, 72.218261),
        blipcoords      = vector3(-64.242599487305,-393.56112670898,71.248695373535),
        showblip        = true
    },
    {    -- house10
        name            = 'House10',
        houseid         = 'house10',
        houseprompt     = 'houseprompt10',
        menucoords      = vector3(339.88751, -667.7122, 42.811027),
        blipcoords      = vector3(338.25341796875,-669.94842529297,41.821144104004),
        showblip        = true
    },
    {    -- house11
        name            = 'House11',
        houseid         = 'house11',
        houseprompt     = 'houseprompt11',
        menucoords      = vector3(1111.6049, -1304.963, 66.403602),
        blipcoords      = vector3(1111.4659423828,-1297.5782470703,65.41828918457),
        showblip        = true
    },
    {    -- house12
        name            = 'House12',
        houseid         = 'house12',
        houseprompt     = 'houseprompt12',
        menucoords      = vector3(1369.3358, -870.8798, 70.127265),
        blipcoords      = vector3(1365.4197998047,-872.88018798828,69.162147521973),
        showblip        = true
    },
    {    -- house13
        name            = 'House13',
        houseid         = 'house13',
        houseprompt     = 'houseprompt13',
        menucoords      = vector3(2064.4531, -854.3615, 43.360958),
        blipcoords      = vector3(2068.3598632813,-847.32141113281,42.350879669189),
        showblip        = true
    },
    {    -- house14
        name            = 'House14',
        houseid         = 'house14',
        houseprompt     = 'houseprompt14',
        menucoords      = vector3(2254.1096, -795.2846, 44.226325),
        blipcoords      = vector3(2253.8466796875,-797.30505371094,43.133113861084),
        showblip        = true
    },
    {    -- house15
        name            = 'House15',
        houseid         = 'house15',
        houseprompt     = 'houseprompt15',
        menucoords      = vector3(2373.1706, -862.4254, 43.020359),
        blipcoords      = vector3(2370.9301757813,-857.48553466797,42.043087005615),
        showblip        = true
    },
    {    -- house16
        name            = 'House16',
        houseid         = 'house16',
        houseprompt     = 'houseprompt16',
        menucoords      = vector3(1706.3145, -1004.643, 43.473499),
        blipcoords      = vector3(1709.3989257813,-1003.7617797852,42.480758666992),
        showblip        = true
    },
    {    -- house17
        name            = 'House17',
        houseid         = 'house17',
        houseprompt     = 'houseprompt17',
        menucoords      = vector3(2624.0607, 1696.1097, 115.70227),
        blipcoords      = vector3(2628.2214355469,1694.3289794922,114.66619110107),
        showblip        = true
    },
    {    -- house18
        name            = 'House18',
        houseid         = 'house18',
        houseprompt     = 'houseprompt18',
        menucoords      = vector3(2990.2619, 2184.7788, 166.74037),
        blipcoords      = vector3(2993.4243164063,2188.4375,165.73570251465),
        showblip        = true
    },
    {    -- house19
        name            = 'House19',
        houseid         = 'house19',
        houseprompt     = 'houseprompt19',
        menucoords      = vector3(2477.8996, 1998.1372, 168.2523),
        blipcoords      = vector3(2473.8527832031,1996.4063720703,167.22595214844),
        showblip        = true
    },
    {    -- house20
        name            = 'House20',
        houseid         = 'house20',
        houseprompt     = 'houseprompt20',
        menucoords      = vector3(-422.9819, 1738.1881, 216.55885),
        blipcoords      = vector3(-422.6643371582,1733.5697021484,215.59002685547),
        showblip        = true
    },
    {    -- house21
        name            = 'House21',
        houseid         = 'house21',
        houseprompt     = 'houseprompt21',
        menucoords      = vector3(897.28363, 261.66098, 116.00907),
        blipcoords      = vector3(900.34381103516,265.21841430664,115.04807281494),
        showblip        = true
    },
    {    -- house22
        name            = 'House22',
        houseid         = 'house22',
        houseprompt     = 'houseprompt22',
        menucoords      = vector3(-1353.182, 2436.3557, 308.40505),
        blipcoords      = vector3(-1347.9483642578,2435.2036132813,307.49612426758),
        showblip        = true
    },
    {    -- house23
        name            = 'House23',
        houseid         = 'house23',
        houseprompt     = 'houseprompt23',
        menucoords      = vector3(-553.2758, 2701.4128, 320.41564),
        blipcoords      = vector3(-556.41680908203,2698.8635253906,319.38018798828),
        showblip        = true
    },
    {    -- house24
        name            = 'House24',
        houseid         = 'house24',
        houseprompt     = 'houseprompt24',
        menucoords      = vector3(-1021.677, 1695.299, 244.31025),
        blipcoords      = vector3(-1019.1105957031,1688.2989501953,243.27978515625),
        showblip        = true
    },
    {    -- house25
        name            = 'House25',
        houseid         = 'house25',
        houseprompt     = 'houseprompt25',
        menucoords      = vector3(-1819.195, 657.87084, 131.85984),
        blipcoords      = vector3(-1815.1489257813,654.96380615234,130.88250732422),
        showblip        = true
    },
    {    -- house26
        name            = 'House26',
        houseid         = 'house26',
        houseprompt     = 'houseprompt26',
        menucoords      = vector3(-2173.403, 715.4107, 122.61867),
        blipcoords      = vector3(-2182.5109863281,716.46356201172,121.62875366211),
        showblip        = true
    },
    {    -- house27
        name            = 'House27',
        houseid         = 'house27',
        houseprompt     = 'houseprompt27',
        menucoords      = vector3(-2579.494, -1380.417, 149.2548),
        blipcoords      = vector3(-2575.826171875,-1379.3582763672,148.27227783203),
        showblip        = true
    },
    {    -- house28
        name            = 'House28',
        houseid         = 'house28',
        houseprompt     = 'houseprompt28',
        menucoords      = vector3(-2375.747, -1591.876, 154.28628),
        blipcoords      = vector3(-2374.3642578125,-1592.6021728516,153.29959106445),
        showblip        = true
    },
    {    -- house29
        name            = 'House29',
        houseid         = 'house29',
        houseprompt     = 'houseprompt29',
        menucoords      = vector3(-1410.868, -2671.971, 42.17152),
        blipcoords      = vector3(-1410.5717773438,-2674.2229003906,41.185203552246),
        showblip        = true
    },
    {    -- house30
        name            = 'House30',
        houseid         = 'house30',
        houseprompt     = 'houseprompt30',
        menucoords      = vector3(-3960.028, -2124.254, -4.076438),
        blipcoords      = vector3(-3958.3901367188,-2129.3940429688,-5.235463142395),
        showblip        = true
    },
    {    -- house31
        name            = 'House31',
        houseid         = 'house31',
        houseprompt     = 'houseprompt31',
        menucoords      = vector3(-4370.378, -2415.955, 20.399623),
        blipcoords      = vector3(-4366.0122070313,-2416.3056640625,19.423376083374),
        showblip        = true
    },
    {    -- house32
        name            = 'House32',
        houseid         = 'house32',
        houseprompt     = 'houseprompt32',
        menucoords      = vector3(-5549.529, -2399.353, -8.745719),
        blipcoords      = vector3(-5552.146484375,-2401.5205078125,-9.7140893936157),
        showblip        = true
    },
    {    -- house33
        name            = 'House33',
        houseid         = 'house33',
        houseprompt     = 'houseprompt33',
        menucoords      = vector3(-3550.882, -3008.228, 11.887498),
        blipcoords      = vector3(-3552.3842773438,-3012.0998535156,10.820337295532),
        showblip        = true
    },
    {    -- house34
        name            = 'House34',
        houseid         = 'house34',
        houseprompt     = 'houseprompt34',
        menucoords      = vector3(-1962.949, 2157.6286, 327.58007),
        blipcoords      = vector3(-1959.1854248047,2160.2043457031,326.55380249023),
        showblip        = true
    },
    {    -- house35
        name            = 'House35',
        houseid         = 'house35',
        houseprompt     = 'houseprompt35',
        menucoords      = vector3(-1488.904, 1248.895, 314.49044),
        blipcoords      = vector3(-1494.4030761719,1246.7662353516,313.5432434082),
        showblip        = true
    },
    {    -- house36
        name            = 'House36',
        houseid         = 'house36',
        houseprompt     = 'houseprompt36',
        menucoords      = vector3(3028.9965, 1780.9338, 84.127723),
        blipcoords      = vector3(3024.1213378906,1777.0731201172,83.169136047363),
        showblip        = true
    },
    {    -- house37
        name            = 'House37',
        houseid         = 'house37',
        houseprompt     = 'houseprompt37',
        menucoords      = vector3(1984.8593, 1196.9948, 171.40205),
        blipcoords      = vector3(1981.9653320313,1195.0833740234,170.41778564453),
        showblip        = true
    },
    {    -- house38
        name            = 'House38',
        houseid         = 'house38',
        houseprompt     = 'houseprompt38',
        menucoords      = vector3(2718.0898, 710.00518, 79.543266),
        blipcoords      = vector3(2716.8154296875,708.16693115234,78.605178833008),
        showblip        = true
    },
    {    -- house39
        name            = 'House39',
        houseid         = 'house39',
        houseprompt     = 'houseprompt39',
        menucoords      = vector3(2823.6367, 275.38955, 48.096889),
        blipcoords      = vector3(2824.4970703125,270.89910888672,47.120807647705),
        showblip        = true
    },
    {    -- house40
        name            = 'House40',
        houseid         = 'house40',
        houseprompt     = 'houseprompt40',
        menucoords      = vector3(1391.1662, -2085.114, 52.56631),
        blipcoords      = vector3(1387.3020019531,-2077.4401855469,51.581089019775),
        showblip        = true
    },
    -- 41 spare
    {    -- house42
        name            = 'House42',
        houseid         = 'house42',
        houseprompt     = 'houseprompt42',
        menucoords      = vector3(1700.9014, 1512.7069, 147.86967),
        blipcoords      = vector3(1697.4683837891,1508.2376708984,146.8824005127),
        showblip        = true
    },
    {    -- house43
        name            = 'House43',
        houseid         = 'house43',
        houseprompt     = 'houseprompt43',
        menucoords      = vector3(-3402.104, -3304.445, -4.457978),
        blipcoords      = vector3(-3400.0258789063,-3302.1235351563,-5.3948922157288),
        showblip        = true
    },
    {    -- house44
        name            = 'House44',
        houseid         = 'house44',
        houseprompt     = 'houseprompt44',
        menucoords      = vector3(-819.3696, 356.07235, 98.078361),
        blipcoords      = vector3(-818.61383056641,351.16165161133,97.108840942383),
        showblip        = true
    },
    {    -- house45
        name            = 'House45',
        houseid         = 'house45',
        houseprompt     = 'houseprompt45',
        menucoords      = vector3(2712.8942, -1288.714, 60.344982),
        blipcoords      = vector3(2711.4370117188,-1293.0838623047,59.458484649658),
        showblip        = true
    }
}

-- door config
Config.HouseDoors =
{
    ---------------------------------------------------------------------------
    {
        houseid         = 'house1',
        name            = 'House 1',
        doorid          = 3598523785,
        doorcoords = vector3(215.80004882813, 988.06512451172, 189.9015045166)
    },
    {
        houseid         = 'house1',
        name            = 'House 1',
        doorid          = 2031215067,
        doorcoords = vector3(222.8265838623, 990.53399658203, 189.9015045166)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house2',
        name            = 'House 2',
        doorid          = 1189146288,
        doorcoords = vector3(-615.93969726563, -27.086599349976, 84.997604370117)
    },
    {
        houseid         = 'house2',
        name            = 'House 2',
        doorid          = 906448125,
        doorcoords = vector3(-608.73846435547, -26.612947463989, 84.997634887695)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house3',
        name            = 'House 3',
        doorid          = 2821676992,
        doorcoords = vector3(1888.1700439453,297.95916748047,76.076202392578)
    },
    {
        houseid         = 'house3',
        name            = 'House 3',
        doorid          = 1510914117,
        doorcoords = vector3(1891.0832519531,302.62200927734,76.091575622559)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house4',
        name            = 'House 4',
        doorid          = 3549587335,
        doorcoords = vector3(1781.1064453125,-89.115615844727,55.815963745117)
    },
    {
        houseid         = 'house4',
        name            = 'House 4',
        doorid          = 3000692149,
        doorcoords = vector3(1781.3618164063,-82.687698364258,55.798538208008)
    },
    {
        houseid         = 'house4',
        name            = 'House 4',
        doorid          = 1928053488,
        doorcoords = vector3(1792.0642089844,-83.22380065918,55.798538208008)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house5',
        name            = 'House 5',
        doorid          = 772977516,
        doorcoords = vector3(1264.1951904297,-404.07095336914,96.595031738281)
    },
    {
        houseid         = 'house5',
        name            = 'House 5',
        doorid          = 527767089,
        doorcoords = vector3(1266.837890625,-412.62899780273,96.595031738281),
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house6',
        name            = 'House 6',
        doorid          = 3468185317,
        doorcoords = vector3(1627.2501220703,-366.25610351563,74.909873962402)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house7',
        name            = 'House 7',
        doorid          = 2779142555,
        doorcoords = vector3(-2368.841796875,-2390.40625,61.520217895508)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house8',
        name            = 'House 8',
        doorid          = 1239033969,
        doorcoords = vector3(1114.0626220703,493.74633789063,96.290939331055)
    },
    {
        houseid         = 'house8',
        name            = 'House 8',
        doorid          = 1597362984,
        doorcoords = vector3(1116.3991699219,485.99212646484,96.306297302246)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house9',
        name            = 'House 9',
        doorid          = 1299456376,
        doorcoords = vector3(-64.242599487305,-393.56112670898,71.248695373535)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house10',
        name            = 'House 10',
        doorid          = 2933656395,
        doorcoords = vector3(338.25341796875,-669.94842529297,41.821144104004)
    },
    {
        houseid         = 'house10',
        name            = 'House 10',
        doorid          = 3238637478,
        doorcoords = vector3(347.24737548828,-666.05346679688,41.822761535645)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house11',
        name            = 'House 11',
        doorid          = 3544613794,
        doorcoords = vector3(1111.4659423828,-1297.5782470703,65.41828918457)
    },
    {
        houseid         = 'house11',
        name            = 'House 11',
        doorid          = 1485561723,
        doorcoords = vector3(1114.6071777344,-1305.0754394531,65.41828918457)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house12',
        name            = 'House 12',
        doorid          = 1511858696,
        doorcoords = vector3(1365.4197998047,-872.88018798828,69.162147521973)
    },
    {
        houseid         = 'house12',
        name            = 'House 12',
        doorid          = 1282705079,
        doorcoords = vector3(1376.0239257813,-873.24206542969,69.11506652832)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house13',
        name            = 'House 13',
        doorid          = 2238665296,
        doorcoords = vector3(2068.3598632813,-847.32141113281,42.350879669189)
    },
    {
        houseid         = 'house13',
        name            = 'House 13',
        doorid          = 2080980868,
        doorcoords = vector3(2069.7229003906,-847.31500244141,42.350879669189)
    },
    {
        houseid         = 'house13',
        name            = 'House 13',
        doorid          = 2700347737,
        doorcoords = vector3(2064.388671875,-847.32141113281,42.350879669189)
    },
    {
        houseid         = 'house13',
        name            = 'House 13',
        doorid          = 2544301759,
        doorcoords = vector3(2065.7514648438,-847.31500244141,42.350879669189)
    },
    {
        houseid         = 'house13',
        name            = 'House 13',
        doorid          = 3720952508,
        doorcoords = vector3(2069.7219238281,-855.87939453125,42.350879669189)
    },
    {
        houseid         = 'house13',
        name            = 'House 13',
        doorid          = 350169319,
        doorcoords = vector3(2068.3588867188,-855.8857421875,42.350879669189)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house14',
        name            = 'House 14',
        doorid          = 984852093,
        doorcoords = vector3(2253.8466796875,-797.30505371094,43.133113861084)
    },
    {
        houseid         = 'house14',
        name            = 'House 14',
        doorid          = 3473362722,
        doorcoords = vector3(2257.2678222656,-792.70416259766,43.167179107666)
    },
    {
        houseid         = 'house14',
        name            = 'House 14',
        doorid          = 686097120,
        doorcoords = vector3(2257.9418945313,-786.59753417969,43.184906005859)
    },
    {
        houseid         = 'house14',
        name            = 'House 14',
        doorid          = 3107660458,
        doorcoords = vector3(2254.5458984375,-781.7353515625,43.165546417236)
    },
    {
        houseid         = 'house14',
        name            = 'House 14',
        doorid          = 3419719645,
        doorcoords = vector3(2252.3625488281,-781.66015625,43.165538787842)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house15',
        name            = 'House 15',
        doorid          = 3945582303,
        doorcoords = vector3(2370.9301757813,-857.48553466797,42.043087005615)
    },
    {
        houseid         = 'house15',
        name            = 'House 15',
        doorid          = 862008394,
        doorcoords = vector3(2370.8708496094,-864.43804931641,42.040088653564)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house16',
        name            = 'House 16',
        doorid          = 1661737397,
        doorcoords = vector3(1709.3989257813,-1003.7617797852,42.480758666992)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house17',
        name            = 'House 17',
        doorid          = 1574473390,
        doorcoords = vector3(2628.2214355469,1694.3289794922,114.66619110107)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house18',
        name            = 'House 18',
        doorid          = 3731688048,
        doorcoords = vector3(2993.4243164063,2188.4375,165.73570251465)
    },
    {
        houseid         = 'house18',
        name            = 'House 18',
        doorid          = 344028824,
        doorcoords = vector3(2989.1081542969,2193.7414550781,165.73979187012)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house19',
        name            = 'House 19',
        doorid          = 2652873387,
        doorcoords = vector3(2473.8527832031,1996.4063720703,167.22595214844)
    },
    {
        houseid         = 'house19',
        name            = 'House 19',
        doorid          = 2061942857,
        doorcoords = vector3(2472.6179199219,2001.7778320313,167.22595214844)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house20',
        name            = 'House 20',
        doorid          = 3702071668,
        doorcoords = vector3(-422.6643371582,1733.5697021484,215.59002685547)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house21',
        name            = 'House 21',
        doorid          = 1934463007,
        doorcoords = vector3(900.34381103516,265.21841430664,115.04807281494)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house22',
        name            = 'House 22',
        doorid          = 2183007198,
        doorcoords = vector3(-1347.9483642578,2435.2036132813,307.49612426758)
    },
    {
        houseid         = 'house22',
        name            = 'House 22',
        doorid          = 4288310487,
        doorcoords = vector3(-1348.2998046875,2447.0854492188,307.48056030273)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house23',
        name            = 'House 23',
        doorid          = 872775928,
        doorcoords = vector3(-556.41680908203,2698.8635253906,319.38018798828)
    },
    {
        houseid         = 'house23',
        name            = 'House 23',
        doorid          = 2385374047,
        doorcoords = vector3(-557.96398925781,2708.9880371094,319.43182373047)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house24',
        name            = 'House 24',
        doorid          = 3167436574,
        doorcoords = vector3(-1019.1105957031,1688.2989501953,243.27978515625)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house25',
        name            = 'House 25',
        doorid          = 1195519038,
        doorcoords = vector3(-1815.1489257813,654.96380615234,130.88250732422)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house26',
        name            = 'House 26',
        doorid          = 2212914984,
        doorcoords = vector3(-2182.5109863281,716.46356201172,121.62875366211)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house27',
        name            = 'House 27',
        doorid          = 562830153,
        doorcoords = vector3(-2575.826171875,-1379.3582763672,148.27227783203)
    },
    {
        houseid         = 'house27',
        name            = 'House 27',
        doorid          = 663425326,
        doorcoords = vector3(-2578.7858886719,-1385.2464599609,148.26223754883)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house28',
        name            = 'House 28',
        doorid          = 1171581101,
        doorcoords = vector3(-2374.3642578125,-1592.6021728516,153.29959106445)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house29',
        name            = 'House 29',
        doorid          = 52014802,
        doorcoords = vector3(-1410.5717773438,-2674.2229003906,41.185203552246)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house30',
        name            = 'House 30',
        doorid          = 4164042403,
        doorcoords = vector3(-3958.3901367188,-2129.3940429688,-5.235463142395)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house31',
        name            = 'House 31',
        doorid          = 2047072501,
        doorcoords = vector3(-4366.0122070313,-2416.3056640625,19.423376083374)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house32',
        name            = 'House 32',
        doorid          = 2715667864,
        doorcoords = vector3(-5552.146484375,-2401.5205078125,-9.7140893936157)
    },
    {
        houseid         = 'house32',
        name            = 'House 32',
        doorid          = 1263476860,
        doorcoords = vector3(-5555.2666015625,-2397.3522949219,-9.7149391174316)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house33',
        name            = 'House 33',
        doorid          = 1894337720,
        doorcoords = vector3(-3552.3842773438,-3012.0998535156,10.820337295532)
    },
    {
        houseid         = 'house33',
        name            = 'House 33',
        doorid          = 120764251,
        doorcoords = vector3(-3555.4401855469,-3007.9375,10.820337295532)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house34',
        name            = 'House 34',
        doorid          = 943176298,
        doorcoords = vector3(-1959.1854248047,2160.2043457031,326.55380249023)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house35',
        name            = 'House 35',
        doorid          = 2971757040,
        doorcoords = vector3(-1494.4030761719,1246.7662353516,313.5432434082)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house36',
        name            = 'House 36',
        doorid          = 1973911195,
        doorcoords = vector3(3024.1213378906,1777.0731201172,83.169136047363)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house37',
        name            = 'House 37',
        doorid          = 784290387,
        doorcoords = vector3(1981.9653320313,1195.0833740234,170.41778564453)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house38',
        name            = 'House 38',
        doorid          = 843137708,
        doorcoords = vector3(2716.8154296875,708.16693115234,78.605178833008)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house39',
        name            = 'House 39',
        doorid          = 4275653891,
        doorcoords = vector3(2824.4970703125,270.89910888672,47.120807647705)
    },
    {
        houseid         = 'house39',
        name            = 'House 39',
        doorid          = 1431398235,
        doorcoords = vector3(2820.5607910156,278.90881347656,50.09118270874)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house40',
        name            = 'House 40',
        doorid          = 896012811,
        doorcoords = vector3(1387.3020019531,-2077.4401855469,51.581089019775)
    },
    {
        houseid         = 'house40',
        name            = 'House 40',
        doorid          = 2813949612,
        doorcoords = vector3(1385.0637207031,-2085.1806640625,51.583812713623)
    },
    ---------------------------------------------------------------------------
    -- 41 spare
    ---------------------------------------------------------------------------
    {
        houseid         = 'house42',
        name            = 'House 42',
        doorid          = 868379185,
        doorcoords = vector3(1697.4683837891,1508.2376708984,146.8824005127)
    },
    {
        houseid         = 'house42',
        name            = 'House 42',
        doorid          = 640077562,
        doorcoords = vector3(1702.7976074219,1514.3333740234,146.87799072266)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house43',
        name            = 'House 43',
        doorid          = 3045682143,
        doorcoords = vector3(-3400.0258789063,-3302.1235351563,-5.3948922157288)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house44',
        name            = 'House 44',
        doorid          = 1915887592,
        doorcoords = vector3(-818.61383056641,351.16165161133,97.108840942383)
    },
    {
        houseid         = 'house44',
        name            = 'House 44',
        doorid          = 3324299212,
        doorcoords = vector3(-819.14367675781,358.73443603516,97.10627746582)
    },
    ---------------------------------------------------------------------------
    {
        houseid         = 'house45',
        name            = 'House 45',
        doorid          = 1180868565,
        doorcoords = vector3(2711.4370117188,-1293.0838623047,59.458484649658)
    }
}

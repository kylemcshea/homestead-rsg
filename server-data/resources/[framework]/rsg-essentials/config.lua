Config = Config or {}

Config.Debug = false

ConsumeablesEat = {
    ["bread"] = math.random(20, 40),
    ["stew"] = math.random(80, 100),
    ["cooked_meat"] = math.random(30, 60),
    ["cooked_fish"] = math.random(30, 60),
}

ConsumeablesDrink = {
    ["water"] = math.random(35, 54),
}

Config.Discord = {
    ["discord_id"]              = 12345678910,
    ["discord_joinurl"]         = "",
    ["discord_connecturl"]      = "https://example.org",
    ["discord_big_image"]       = "dc_rich",
    ["discord_small_image"]     = "dc_rich_small",
}

-- discord webhook config
Config.DiscordWHImage = 'https://cdn.discordapp.com/attachments/1032260791669375006/1066811751389208596/rsg256x256.png'
Config.DiscordWHLogUserName = 'Rexshack Gaming Logs'
Config.DiscordWHAuthorName = 'Rexshack Gaming'

-- density config
Config.Density = {
    -- Ambient Animal Density
    [1] = 1.0,
    -- Scenario Animal Density
    [2] = 1.0,
    -- Ambient Human Density
    [3] = 1.0,
    -- Scenario Human Density
    [4] = 1.0,
    -- Ambient Ped Density
    [5] = 1.0,
    -- Scenario Ped Density
    [6] = 1.0,
    -- Parked Vehicle Density
    [7] = 1.0,
    -- Random Vehicle Density
    [8] = 1.0,
    -- Vehicle Density
    [9] = 1.0,
}

-- water types config
Config.WaterTypes = {
    [1] =  {["name"] = "Sea of Coronado",       ["waterhash"] = -247856387,     ["watertype"] = "sea"},
    [2] =  {["name"] = "San Luis River",        ["waterhash"] = -1504425495,    ["watertype"] = "river"},
    [3] =  {["name"] = "Lake Don Julio",        ["waterhash"] = -1369817450,    ["watertype"] = "lake"},
    [4] =  {["name"] = "Flat Iron Lake",        ["waterhash"] = -1356490953,    ["watertype"] = "lake"},
    [5] =  {["name"] = "Upper Montana River",   ["waterhash"] = -1781130443,    ["watertype"] = "river"},
    [6] =  {["name"] = "Owanjila",              ["waterhash"] = -1300497193,    ["watertype"] = "river"},
    [7] =  {["name"] = "HawkEye Creek",         ["waterhash"] = -1276586360,    ["watertype"] = "river"},
    [8] =  {["name"] = "Little Creek River",    ["waterhash"] = -1410384421,    ["watertype"] = "river"},
    [9] =  {["name"] = "Dakota River",          ["waterhash"] = 370072007,      ["watertype"] = "river"},
    [10] =  {["name"] = "Beartooth Beck",       ["waterhash"] = 650214731,      ["watertype"] = "river"},
    [11] =  {["name"] = "Lake Isabella",        ["waterhash"] = 592454541,      ["watertype"] = "lake"},
    [12] =  {["name"] = "Cattail Pond",         ["waterhash"] = -804804953,     ["watertype"] = "lake"},
    [13] =  {["name"] = "Deadboot Creek",       ["waterhash"] = 1245451421,     ["watertype"] = "river"},
    [14] =  {["name"] = "Spider Gorge",         ["waterhash"] = -218679770,     ["watertype"] = "river"},
    [15] =  {["name"] = "O'Creagh's Run",       ["waterhash"] = -1817904483,    ["watertype"] = "lake"},
    [16] =  {["name"] = "Moonstone Pond",       ["waterhash"] = -811730579,     ["watertype"] = "lake"},
    [17] =  {["name"] = "Roanoke Valley",       ["waterhash"] = -1229593481,    ["watertype"] = "river"},
    [18] =  {["name"] = "Elysian Pool",         ["waterhash"] = -105598602,     ["watertype"] = "lake"},
    [19] =  {["name"] = "Lannahechee River",    ["waterhash"] = -2040708515,    ["watertype"] = "river"},
    [20] =  {["name"] = "Random1",              ["waterhash"] = 231313522,      ["watertype"] = "river"},
    [21] =  {["name"] = "Random2",              ["waterhash"] = 2005774838,     ["watertype"] = "river"},
    [22] =  {["name"] = "Random3",              ["waterhash"] = -1287619521,    ["watertype"] = "river"},
    [23] =  {["name"] = "Random4",              ["waterhash"] = -1308233316,    ["watertype"] = "river"},
    [24] =  {["name"] = "Random5",              ["waterhash"] = -196675805,     ["watertype"] = "river"},
    [25] =  {["name"] = "Bahia De La Paz",      ["waterhash"] = -1168459546,    ["watertype"] = "sea"},
    [26] =  {["name"] = "Arroyo De La Vibora",  ["waterhash"] = -49694339,      ["watertype"] = "river"},
}

Config.Emotes = {
    Actions = {
        ['banjo'] = {
            desc = 'Do the Banjo Emote',
            anim = -1861447822
        },
        ['becon'] = {
            desc = 'Do the becon Emote',
            anim = 2143329621
        },
        ['goldcoin'] = {
            desc = 'Do the goldcoin Emote',
            anim = 397025279
        },
        ['blowkiss'] = {
            desc = 'Do the blowkiss Emote',
            anim = 1927505461
        },
        ['boast'] = {
            desc = 'Do the boast Emote',
            anim = -1252070669
        },
        ['watch'] = {
            desc = 'Do the watch Emote',
            anim = -380388425
        },
        ['coinflip'] = {
            desc = 'Do the coinflip Emote',
            anim = -667707842
        },
        ['fistpump'] = {
            desc = 'Do the fistpump Emote',
            anim = -402959
        },
        ['flex'] = {
            desc = 'Do the flex Emote',
            anim = -773960361
        },
        ['followme'] = {
            desc = 'Do the followme Emote',
            anim = 1115379199
        },
        ['hissyfit'] = {
            desc = 'Do the hissyfit Emote',
            anim = 796723886
        },
        ['howl'] = {
            desc = 'Do the howl Emote',
            anim = 877603501
        },
        ['hypnowatch'] = {
            desc = 'Do the hypnowatch Emote',
            anim = -869481556
        },
        ['idea'] = {
            desc = 'Do the idea Emote',
            anim = -289055561
        },
        ['letscraft'] = {
            desc = 'Do the letscraft Emote',
            anim = -415456998
        },
        ['letsfish'] = {
            desc = 'Do the letsfish Emote',
            anim = 1159716480
        },
        ['letsgo'] = {
            desc = 'Do the letsgo Emote',
            anim = 1593752891
        },
        ['letsplaycards'] = {
            desc = 'Do the letsplaycards Emote',
            anim = -843470756
        },
        ['listen'] = {
            desc = 'Do the listen Emote',
            anim = -1251254114
        },
        ['lookdistance'] = {
            desc = 'Do the lookdistance Emote',
            anim = 935157006
        },
        ['lookyonder'] = {
            desc = 'Do the lookyonder Emote',
            anim = 7918540
        },
        ['newthreads'] = {
            desc = 'Do the newthreads Emote',
            anim = -919436740
        },
        ['point'] = {
            desc = 'Do the point Emote',
            anim = 486225122
        },
        ['posseup'] = {
            desc = 'Do the posseup Emote',
            anim = 474409519
        },
        ['prayer'] = {
            desc = 'Do the prayer Emote',
            anim = 844130790
        },
        ['jig'] = {
            desc = 'Do the jig Emote',
            anim = 1307697675
        },
        ['rps'] = {
            desc = 'Do the rps Emote',
            anim = -1219119695
        },
        ['scheme'] = {
            desc = 'Do the scheme Emote',
            anim = 589481092
        },
        ['shoothip'] = {
            desc = 'Do the shoothip Emote',
            anim = 1639456476
        },
        ['skyshoot'] = {
            desc = 'Do the skyshoot Emote',
            anim = 1939251934
        },
        ['smokecigar'] = {
            desc = 'Do the smokecigar Emote',
            anim = -2124325981
        },
        ['smokecigarette'] = {
            desc = 'Do the smokecigarette Emote',
            anim = -1954574613
        },
        ['snotrocket'] = {
            desc = 'Do the snotrocket Emote',
            anim = 1695841551
        },
        ['spinaim'] = {
            desc = 'Do the spinaim Emote',
            anim = 988397866
        },
        ['slit'] = {
            desc = 'Do the slit Emote',
            anim = 1256841324
        },
        ['spooky'] = {
            desc = 'Do the spooky Emote',
            anim = -799896264
        },
        ['stophere'] = {
            desc = 'Do the stophere Emote',
            anim = -1691237868
        },
        ['takenotes'] = {
            desc = 'Do the takenotes Emote',
            anim = -1169051375
        },
        ['wetwhistle'] = {
            desc = 'Do the wetwhistle Emote',
            anim = -1548499813
        },
    },
    Greeting = {
        ['fancybow'] = {
            desc = 'Do the fancybow Emote',
            anim = -2121881035
        },
        ['flyingkiss'] = {
            desc = 'Do the flyingkiss Emote',
            anim = 1329464356
        },
        ['gentalwave'] = {
            desc = 'Do the gentalwave Emote',
            anim = 901097731
        },
        ['getoverhere'] = {
            desc = 'Do the getoverhere Emote',
            anim = -1666834415
        },
        ['glad'] = {
            desc = 'Do the glad Emote',
            anim = 523585988
        },
        ['handshake'] = {
            desc = 'Do the handshake Emote',
            anim = 1785080714
        },
        ['hatflick'] = {
            desc = 'Do the hatflick Emote',
            anim = -511010399
        },
        ['hattip'] = {
            desc = 'Do the hattip Emote',
            anim = -1457020913
        },
        ['heyyou'] = {
            desc = 'Do the heyyou Emote',
            anim = 831975651
        },
        ['outpour'] = {
            desc = 'Do the outpour Emote',
            anim = -427334733
        },
        ['roughhousing'] = {
            desc = 'Do the roughhousing Emote',
            anim = -1389921219
        },
        ['seven'] = {
            desc = 'Do the seven Emote',
            anim = 1018554126
        },
        ['sutlewave'] = {
            desc = 'Do the sutlewave Emote',
            anim = -1551032732
        },
        ['tada'] = {
            desc = 'Do the tada Emote',
            anim = -462132925
        },
        ['thumbsdown'] = {
            desc = 'Do the thumbsdown Emote',
            anim = 1509171361
        },
        ['thumbsup'] = {
            desc = 'Do the thumbsup Emote',
            anim = 425751659
        },
        ['wavenear'] = {
            desc = 'Do the wavenear Emote',
            anim = -339257980
        },
    },
    Reactions = {
        ['amazed'] = {
            desc = 'Do the amazed Emote',
            anim = -48594731
        },
        ['applause'] = {
            desc = 'Do the applause Emote',
            anim = -221241824
        },
        ['begmercy'] = {
            desc = 'Do the begmercy Emote',
            anim = 164860528
        },
        ['clapalong'] = {
            desc = 'Do the clapalong Emote',
            anim = -934299978
        },
        ['facepalm'] = {
            desc = 'Do the facepalm Emote',
            anim = -1384541404
        },
        ['hangover'] = {
            desc = 'Do the hangover Emote',
            anim = -78874669
        },
        ['howdareyou'] = {
            desc = 'Do the howdareyou Emote',
            anim = 1802342943
        },
        ['hurl'] = {
            desc = 'Do the hurl Emote',
            anim = -1118911493
        },
        ['hushyourmouth'] = {
            desc = 'Do the hushyourmouth Emote',
            anim = -1644757697
        },
        ['joviallaugh'] = {
            desc = 'Do the joviallaugh Emote',
            anim = 296809845
        },
        ['nodhead'] = {
            desc = 'Do the nodhead Emote',
            anim = -822629770
        },
        ['phew'] = {
            desc = 'Do the phew Emote',
            anim = -1362920197
        },
        ['pointlaugh'] = {
            desc = 'Do the pointlaugh Emote',
            anim = 803206066
        },
        ['scared'] = {
            desc = 'Do the scared Emote',
            anim = -1312563584
        },
        ['shakehead'] = {
            desc = 'Do the shakehead Emote',
            anim = -653113914
        },
        ['shot'] = {
            desc = 'Do the shot Emote',
            anim = -110352861
        },
        ['shrug'] = {
            desc = 'Do the shrug Emote',
            anim = 772373429
        },
        ['shuffle'] = {
            desc = 'Do the shuffle Emote',
            anim = -1000272583
        },
        ['slowclap'] = {
            desc = 'Do the slowclap Emote',
            anim = 1023735814
        },
        ['sniffing'] = {
            desc = 'Do the sniffing Emote',
            anim = -1343104589
        },
        ['sob'] = {
            desc = 'Do the sob Emote',
            anim = 81347960
        },
        ['surrender'] = {
            desc = 'Do the surrender Emote',
            anim = -1023149885
        },
        ['thanks'] = {
            desc = 'Do the thanks Emote',
            anim = 2144049308
        },
        ['thisguy'] = {
            desc = 'Do the thisguy Emote',
            anim = 593885605
        },
        ['wagfinger'] = {
            desc = 'Do the wagfinger Emote',
            anim = -12201726
        },
        ['whome'] = {
            desc = 'Do the whome Emote',
            anim = 329631369
        },
        ['yeehaw'] = {
            desc = 'Do the yeehaw Emote',
            anim = 445839715
        },
    },
    Taunting = {
        ['bestshot'] = {
            desc = 'Do the bestshot Emote',
            anim = 1582069421
        },
        ['boohoo'] = {
            desc = 'Do the boohoo Emote',
            anim = 246916594
        },
        ['chicken'] = {
            desc = 'Do the chicken Emote',
            anim = 1825177171
        },
        ['cocksnook'] = {
            desc = 'Do the cocksnook Emote',
            anim = 1379772889
        },
        ['cougarsnarl'] = {
            desc = 'Do the cougarsnarl Emote',
            anim = 698079535
        },
        ['cruisingbrusing'] = {
            desc = 'Do the cruisingbrusing Emote',
            anim = 456609832
        },
        ['cuckoo'] = {
            desc = 'Do the cuckoo Emote',
            anim = -1570999495
        },
        ['fiddlehead'] = {
            desc = 'Do the fiddlehead Emote',
            anim = 541002968
        },
        ['fingerslinger'] = {
            desc = 'Do the fingerslinger Emote',
            anim = -795365613
        },
        ['flipoff'] = {
            desc = 'Do the flipoff Emote',
            anim = 969312568
        },
        ['frighten'] = {
            desc = 'Do the frighten Emote',
            anim = -1169275072
        },
        ['gorillachest'] = {
            desc = 'Do the gorillachest Emote',
            anim = 1897736735
        },
        ['watchingyou'] = {
            desc = 'Do the watchingyou Emote',
            anim = -553424129
        },
        ['insignificant'] = {
            desc = 'Do the insignificant Emote',
            anim = 547084638
        },
        ['provoke'] = {
            desc = 'Do the provoke Emote',
            anim = 1533402397
        },
        ['ripper'] = {
            desc = 'Do the ripper Emote',
            anim = 1814567801
        },
        ['throatslit'] = {
            desc = 'Do the throatslit Emote',
            anim = 1256841324
        },
        ['upyours'] = {
            desc = 'Do the upyours Emote',
            anim = 354512356
        },
        ['versus'] = {
            desc = 'Do the versus Emote',
            anim = -2104721573
        },
        ['warcry'] = {
            desc = 'Do the warcry Emote',
            anim = 987239450
        },
        ['youstink'] = {
            desc = 'Do the youstink Emote',
            anim = -166523388
        },
    },
    Dancing = {
        ['dance1'] = {
            desc = 'dance emote one',
            anim = "script_mp@emotes@dance@carefree@a@male@unarmed@full",
            dict = "fullbody",
            duration = 9000,
        },
        ['dance2'] = {
            desc = 'dance emote two',
            anim = "script_mp@emotes@dance@carefree@b@male@unarmed@full",
            dict = "fullbody",
            duration = 9000,
        },
    },
}

-- map zones
Config.Zones = {
--AMBARINO
    {Hash = 0x3B8DD21A, Color = 'BLIP_MODIFIER_MP_COLOR_1'}, --STATE_AMBARINO
    {Hash = 0x3BBA228A, Color = 'BLIP_MODIFIER_MP_COLOR_13'}, --LBS_AMBARINO_BOUNTY
    --{Hash = 0x9125D14C, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_GRIZZLIES
    --{Hash = 0x943198D3, Color = 'BLIP_MODIFIER_MP_COLOR_1'}, --DISTRICT_GRIZZLIES_EAST
    --{Hash = 0xD41D039A, Color = 'BLIP_MODIFIER_MP_COLOR_21'}, --DISTRICT_GRIZZLIES_WEST
    --{Hash = 0xBB785C8A, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_GRZ_WAPITI
    --{Hash = 0x4F45BE43, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --OUTLINE_WAPITI

--LEMOYNE
    {Hash = 0x945395DF, Color = 'BLIP_MODIFIER_MP_COLOR_3'}, --STATE_LEMOYNE
    {Hash = 0x0F32B44D, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --LBS_LEMOYNE_BOUNTY
    --{Hash = 0x2843E325, Color = 'BLIP_MODIFIER_MP_COLOR_3'}, --DISTRICT_BAYOU_NWA
    --{Hash = 0x024C01CA, Color = 'BLIP_MODIFIER_MP_COLOR_14'}, --DISTRICT_BLUEGILL_MARSH
    --{Hash = 0x0BB92EEF, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_SCARLETT_MEADOWS
    --{Hash = 0x9652B96E, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_BAY_LAGRAS
    --{Hash = 0x049BBBD4, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_LAGRAS
    --{Hash = 0x2A6CBBA2, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_BAY_SAINT_DENIS
    --{Hash = 0xC354EAC2, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_SAINT_DENIS
    --{Hash = 0x2D1A7AF2, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_BLU_SISIKA
    --{Hash = 0xFC531E7A, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_SCM_BRAITHWAITEMANOR
    --{Hash = 0x5E68036B, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_BRAITHWAITEMANOR
    --{Hash = 0xD218D90D, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_SCM_CALIGAHALL
    --{Hash = 0xE074391B, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_CALIGAHALL
    --{Hash = 0xD3F2B8A7, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_SCM_RHODES
    --{Hash = 0x09FAE063, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_RHODES


--NEW AUSTIN
    {Hash = 0x41759831, Color = 'BLIP_MODIFIER_MP_COLOR_4'}, --STATE_NEW_AUSTIN
    {Hash = 0xD339F6AB, Color = 'BLIP_MODIFIER_MP_COLOR_16'}, --LBS_NEW_AUSTIN_BOUNTY
    --{Hash = 0x99B6A1E6, Color = 'BLIP_MODIFIER_MP_COLOR_4'}, --DISTRICT_CHOLLA_SPRINGS
    --{Hash = 0x3AC128F9, Color = 'BLIP_MODIFIER_MP_COLOR_30'}, --DISTRICT_GAPTOOTH_RIDGE
    --{Hash = 0x33D88587, Color = 'BLIP_MODIFIER_MP_COLOR_18'}, --DISTRICT_HENNIGANS_STEAD
    --{Hash = 0xD428627B, Color = 'BLIP_MODIFIER_MP_COLOR_29'}, --DISTRICT_RIO_BRAVO


--NEW HANOVER
    {Hash = 0x41332496, Color = 'BLIP_MODIFIER_MP_COLOR_8'}, --STATE_NEW_HANOVER
    {Hash = 0x5CD2A36F, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --LBS_NEW_HANOVER_BOUNTY

    --{Hash = 0x717F4A96, Color = 'BLIP_MODIFIER_MP_COLOR_11'}, --DISTRICT_CUMBERLAND_FOREST
    --{Hash = 0x724E7654, Color = 'BLIP_MODIFIER_MP_COLOR_8'}, --DISTRICT_HEARTLAND
    --{Hash = 0x30FAE29B, Color = 'BLIP_MODIFIER_MP_COLOR_19'}, --DISTRICT_ROANOKE_RIDGE
    --{Hash = 0x1BDD5A12, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_CML_OLDFORTWALLACE
    --{Hash = 0x2FE84F0E, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --OUTLINE_OLDFORTWALLACE
    --{Hash = 0x7B23B4C7, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_HRT_CORNWALLKEROSENE
    --{Hash = 0x150D72E9, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_CORNWALLKEROSEN
    --{Hash = 0x6E7BDAC4, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_HRT_EMERALDRANCH
    --{Hash = 0x13A98173, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_EMERALD
    --{Hash = 0x0079B7EE, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_HRT_VALENTINE
    --{Hash = 0x2A24C8D9, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_VALENTINE
    --{Hash = 0x0A8B2CBE, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_ROA_ANNESBURG
    --{Hash = 0x9CC09C3D, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_ANNESBURG
    --{Hash = 0xA053D058, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_ROA_BUTCHERCREEK
    --{Hash = 0xB6831F62, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_BUTCHERCREEK
    --{Hash = 0x507B5360, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_ROA_VANHORNPOST
    --{Hash = 0x194E52AF, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --OUTLINE_VANHORNPOST

--WEST ELIZABETH
    {Hash = 0xD69B5B49, Color = 'BLIP_MODIFIER_MP_COLOR_6'}, --STATE_WEST_ELIZABETH
    {Hash = 0xF030C0B2, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --LBS_W_ELIZABETH_BOUNTY
    --{Hash = 0x8DCC574F, Color = 'BLIP_MODIFIER_MP_COLOR_6'}, --DISTRICT_BIG_VALLEY
    --{Hash = 0x0E95FF51, Color = 'BLIP_MODIFIER_MP_COLOR_28'}, --DISTRICT_GREAT_PLAINS
    --{Hash = 0x763A8A87, Color = 'BLIP_MODIFIER_MP_COLOR_31'}, --DISTRICT_TALL_TREES
    --{Hash = 0x4663EEB9, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --REGION_BGV_STRAWBERRY
    --{Hash = 0x3B4A5D5B, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --OUTLINE_STRAWBERRY
    --{Hash = 0x5647E155, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --REGION_GRT_BLACKWATER
    --{Hash = 0x129E1411, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --OUTLINE_BLACKWATER
    --{Hash = 0xDC87C0C8, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --REGION_TAL_MANZANITAPOST


--GUARMA
    --{Hash = 0x9307FD41, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --STATE_GUARMA
    --{Hash = 0x6009F334, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --LBS_GUARMA_BOUNTY

    --{Hash = 0x6E10D212, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --REGION_GUA_MANICATO


--NUEVO PARAÍSO
    --{Hash = 0x8966022D, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_DIEZ_CORONAS
    --{Hash = 0x27253ED3, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_PERDIDO
    --{Hash = 0x5046DD11, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_PUNTA_ORGULL


--UNKNOWN
    --{Hash = 0xFAF570C5, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --LOCKOUT_EASTSIDE
    --{Hash = 0xAF5E7C06, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --STATE_DEFAULT
    --{Hash = 0x21FE6ED8, Color = 'BLIP_MODIFIER_MP_COLOR_1'}, --¿?
    --{Hash = 0x28181665, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --¿?
    --{Hash = 0x33F2D34F, Color = 'BLIP_MODIFIER_MP_COLOR_3'}, --¿?
    --{Hash = 0x3FB16CC9, Color = 'BLIP_MODIFIER_MP_COLOR_4'}, --¿?
    --{Hash = 0x46837F42, Color = 'BLIP_MODIFIER_MP_COLOR_5'}, --¿?
    --{Hash = 0x703A27B1, Color = 'BLIP_MODIFIER_MP_COLOR_6'}, --¿?
    --{Hash = 0x89C0A213, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --¿?
    --{Hash = 0x90CA4AF8, Color = 'BLIP_MODIFIER_MP_COLOR_8'}, --¿?
    --{Hash = 0x95B1E77A, Color = 'BLIP_MODIFIER_MP_COLOR_9'}, --¿?
    --{Hash = 0xAE021C70, Color = 'BLIP_MODIFIER_MP_COLOR_10'}, --¿?
    --{Hash = 0xBBB91AAD, Color = 'BLIP_MODIFIER_MP_COLOR_11'}, --¿?
    --{Hash = 0xC1C68746, Color = 'BLIP_MODIFIER_MP_COLOR_12'}, --¿?
}

Config = {}

Config.Debug = false

-- settings
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)
Config.FadeIn = true

Config.PedList = {

	-- trappers
    {    -- trapper vendor Valentine 
        model = `U_M_M_SDTRAPPER_01`,
        coords = vector4(-333.9737, 773.49157, 116.22194, 111.8759),
    },
    {    -- trapper vendor Saint Denis 
        model = `U_M_M_SDTRAPPER_01`,
        coords = vector4(2832.3193, -1223.699, 47.654289, 190.36814),
    },
    {    -- trapper vendor Riggs Station 
        model = `U_M_M_SDTRAPPER_01`,
        coords = vector4(-1007.607, -549.5084, 99.39138, 282.4226),
    },
    {    -- trapper vendor West Elizabeth 
        model = `U_M_M_SDTRAPPER_01`,
        coords = vector4(-2844.197, 142.13876, 184.61907, 255.25524),
    },
    {    -- trapper vendor Stawberry 
        model = `U_M_M_SDTRAPPER_01`,
        coords = vector4(-1745.992, -388.9831, 156.59568, 107.79673),
    },
    {    -- trapper vendor Tumbleweed 
        model = `U_M_M_SDTRAPPER_01`,
        coords = vector4(-5511.721, -2951.048, -1.83548, 165.87483),
    },
	-- butchers
    {    -- butcher Valentine 
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-339.26, 767.7, 116.57, 103.16),
    },
    {    -- butcher Saint Denis
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(2817.6848, -1323.25, 46.607814, 54.587085),
    },
    {    -- butcher Rhodes
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(1297.3735, -1277.661, 75.876304, 158.4201),
    },
    {    -- butcher Annesburg
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(2934.1706, 1301.2891, 44.483638, 78.346809),
    },
    {    -- butcher Tumbleweed
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-5509.831, -2947.271, -1.89185, 256.48596),
    },
    {    -- butcher Blackwater
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-753.0086, -1284.84, 43.470008, 267.18395),
    },
    {    -- butcher Strawberry
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-1753.137, -392.8364, 156.24348, 189.32403),
    },
    {    -- butcher Van Horn
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(2992.4711, 572.20001, 44.365322, 263.94104),
    },
    {    -- butcher Spider Gorge
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-1356.811, 2420.0056, 307.49148, 301.39794),
    },
    {    -- butcher Riggs Station
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-1007.92, -541.2982, 99.108978, 281.41009),
    },
	-- fish vendor
    {    -- fish vendor Valentine 
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(-335.4444, 762.00537, 116.5845, 45.516292),
    },
    {    -- fish vendor Saint Denis 
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(2661.7463, -1506.055, 45.968948, 321.56686),
    },
    {    -- fish vendor Rhodes
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(1292.9885, -1273.963, 75.870391, 181.20063),
    },
    {    -- fish vendor Annesburg
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(3018.2368, 1352.096, 42.713443, 23.409223),
    },
    {    -- fish vendor Van Horn
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(2991.539, 558.93402, 44.357906, 4.9385623),
    },
    {    -- fish vendor Van Horn
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(2991.539, 558.93402, 44.357906, 4.9385623),
    },
    {    -- fish vendor Blackwater
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(-723.9387, -1254.361, 44.734092, 49.674472),
    },
    {    -- fish vendor Tumbleweed
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(-5513.404, -2944.167, -2.001027, 29.520355),
    },
    {    -- fish vendor Tumbleweed
        model = `CS_FISHCOLLECTOR`,
        coords = vector4(-1452.24, -2684.517, 41.256187, 221.86631),
    },
    {    -- vendor Valentine
        model = `A_M_M_BLWObeseMen_01`,
        coords = vector4(-355.8251, 774.5346, 116.28136, 357.04873),
    },
    {    -- vendor Mining
        model = `A_M_M_BLWObeseMen_01`,
        coords = vector4(2435.36, -1511.59, 45.97, 284.36),
    },
    {    -- pet vendor Valentine
        model = `A_F_M_BTCObeseWomen_01`,
        coords = vector4(-360.5959, 784.40875, 116.1548, 254.57247),
    },
    {    -- cart hire Valentine
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(-360.2623, 802.67987, 116.25743, 235.24334),
    },
    {    -- cart hire Rhodes
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(1326.7335, -1348.217, 78.428489, 177.17704),
    },
    {    -- cart hire St Denis
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(2497.8732, -1445.853, 46.326705, 101.40583),
    },
    {    -- cart hire Van Horn
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(2983.5461, 589.39678, 44.163356, 158.38249),
    },
    {    -- cart hire Annesburg
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(2984.8789, 1421.6295, 44.900459, 176.77442),
    },
    {    -- cart hire Strawberry
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(-1779.504, -441.5331, 155.0613, 89.00061),
    },
    {    -- cart hire Armadillo
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(-3676.43, -2605.17, -13.72507, 170.74371),
    },
    {    -- cart hire Tumbleweed
        model = `A_M_M_deliverytravelers_warm_01`,
        coords = vector4(-5512.877, -2929.122, -2.324135, 168.93939),
    },
    {    -- barber Valentine
        model = `s_m_m_barber_01`,
        coords = vector4(-307.96, 814.16, 118.99, 190.93),
    },
    {    -- barber Saint Denis
        model = `s_m_m_barber_01`,
        coords = vector4(2656.16, -1180.87, 53.28, 176.33),
    },
    {    -- barber Blackwater
        model = `s_m_m_barber_01`,
        coords = vector4(-815.88, -1364.72, 43.75, 268.01),
    },
    {    -- estate agent New Hanover
        model = `A_M_O_SDUpperClass_01`,
        coords = vector4(-250.8893, 743.20239, 118.08129, 105.66469),
    },
    {    -- estate agent West Elizabeth
        model = `A_M_O_SDUpperClass_01`,
        coords = vector4(-792.3216, -1203.232, 43.645206, 184.15261),
    },
    {    -- estate agent New Austin
        model = `A_M_O_SDUpperClass_01`,
        coords = vector4(-3658.934, -2620.835, -13.3414, 8.4051847),
    },
    {    -- estate agent Ambarino
        model = `A_M_O_SDUpperClass_01`,
        coords = vector4(-1347.746, 2405.7084, 307.06127, 296.02886),
    },
    {    -- estate agent Lemoyne
        model = `A_M_O_SDUpperClass_01`,
        coords = vector4(2596.5463, -1299.845, 52.817153, 304.04638),
    },
    {   -- delivery Saint Denis
        model = `A_M_M_SDDockForeman_01`,
        coords = vector4(2904.1989, -1169.292, 46.112228, 96.722068),
    },
    {   -- delivery Valentine 
        model = `A_M_M_FOREMAN`,
        coords = vector4(-339.0577, 814.22424, 116.96039, 125.19566),
    },
    {   -- delivery Blackwater 
        model = `A_M_M_FOREMAN`,
        coords = vector4(-743.7046, -1218.822, 43.29129, 94.302909),
    },
    {   -- delivery Strawberry
        model = `U_M_M_BiVForeman_01`,
        coords = vector4(-1798.899, -425.6275, 156.37739, 352.46316),
    },
    {   -- delivery Mcfarlands Ranch
        model = `U_M_M_BiVForeman_01`,
        coords = vector4(-2357.585, -2367.583, 62.18066, 168.52516),
    },
    {   -- delivery Tumbleweed
        model = `A_M_M_SDDockForeman_01`,
        coords = vector4(-5529.143, -2932.52, -1.95342, 212.60365),
    },
    {   -- delivery Oil Fields
        model = `U_M_M_HtlForeman_01`,
        coords = vector4(444.06781, 695.92626, 116.71598, 91.313453),
    },
}

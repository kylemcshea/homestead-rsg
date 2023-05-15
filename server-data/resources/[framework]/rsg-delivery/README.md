# RexshackGaming
- discord : https://discord.gg/s5uSk56B65
- github : https://github.com/Rexshack-RedM

# Warning
- this resource is still in development / testing
- do NOT use in production

# Dependancies
- rsg-core
- rsg-npcs

# Installation
- ensure that the dependancies are added and started
- add rsg-delivery to your resources folder
- add the NPCs Config to rsg-npcs -> config.lua

# Starting the resource
- add the following to your server.cfg file : ensure rsg-delivery

# NPCs Config
```lua
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
```
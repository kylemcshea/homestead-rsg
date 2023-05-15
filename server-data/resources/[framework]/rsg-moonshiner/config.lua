Config = {}

-- settings
Config.Prop = 'p_still03x' -- prop used for the moonshine
Config.LawJobName = 'police' -- job that can distroy moonshines
Config.BrewTime = 30000 -- brewtime in milliseconds

Config.MoonshineVendor = {
    
    { -- lemoyne moonshine vendor
        uid = "lemoyne-moonshine",  -- must be unique
        header = "Lemoyne Moonshine Vendor", -- menu header
        pos = vector3(1789.4877, -817.1411, 189.40167), -- location of sell shop
        showmarker = true,
        blip = { -- blip settings
            enable = false,
            blipSprite = 'blip_moonshine',
            blipScale = 0.2,
            bliptext = Lang:t('blip.moonshine_vendor'),
        },
        shopdata = { -- shop data
            {
                title = "Moonshine",
                description = Lang:t('menu.sell_moonshine'),
                price = 6,
                item = "moonshine",
                image = "moonshine.png"
            },
        },
    },
    { -- cattail pond moonshine vendor
        uid = "cattailpond-moonshine",  -- must be unique
        header = "Cattail Pond Moonshine Vendor", -- menu header
        pos = vector3(-1091.136, 711.75817, 81.036636), -- location of sell shop
        showmarker = true,
        blip = { -- blip settings
            enable = false,
            blipSprite = 'blip_moonshine',
            blipScale = 0.2,
            bliptext = Lang:t('blip.moonshine_vendor'),
        },
        shopdata = { -- shop data
            {
                title = "Moonshine",
                description = Lang:t('menu.sell_moonshine'),
                price = 6,
                item = "moonshine",
                image = "moonshine.png"
            },
        },
    },
    { -- new austin moonshine vendor
        uid = "newaustin-moonshine",  -- must be unique
        header = "New Austin Moonshine Vendor", -- menu header
        pos = vector3(-2775.057, -3046.294, -11.89815), -- location of sell shop
        showmarker = true,
        blip = { -- blip settings
            enable = false,
            blipSprite = 'blip_moonshine',
            blipScale = 0.2,
            bliptext = Lang:t('blip.moonshine_vendor'),
        },
        shopdata = { -- shop data
            {
                title = "Moonshine",
                description = Lang:t('menu.sell_moonshine'),
                price = 6,
                item = "moonshine",
                image = "moonshine.png"
            },
        },
    },
    { -- hanover moonshine vendor
        uid = "hanover-moonshine",  -- must be unique
        header = "Hanover Moonshine Vendor", -- menu header
        pos = vector3(1629.6535, 828.49346, 121.74415), -- location of sell shop
        showmarker = true,
        blip = { -- blip settings
            enable = false,
            blipSprite = 'blip_moonshine',
            blipScale = 0.2,
            bliptext = Lang:t('blip.moonshine_vendor'),
        },
        shopdata = { -- shop data
            {
                title = "Moonshine",
                description = Lang:t('menu.sell_moonshine'),
                price = 6,
                item = "moonshine",
                image = "moonshine.png"
            },
        },
    },
    { -- manzanita post moonshine vendor
        uid = "manzanitapost-moonshine",  -- must be unique
        header = "Manzanita Post Moonshine Vendor", -- menu header
        pos = vector3(-1864.511, -1727.998, 86.057472), -- location of sell shop
        showmarker = true,
        blip = { -- blip settings
            enable = false,
            blipSprite = 'blip_moonshine',
            blipScale = 0.2,
            bliptext = Lang:t('blip.moonshine_vendor'),
        },
        shopdata = { -- shop data
            {
                title = "Moonshine",
                description = Lang:t('menu.sell_moonshine'),
                price = 6,
                item = "moonshine",
                image = "moonshine.png"
            },
        },
    },
    
}
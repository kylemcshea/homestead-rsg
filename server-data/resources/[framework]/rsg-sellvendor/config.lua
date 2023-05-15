Config = {}

Config.VendorShops = {
    -- valentine
    {
        prompt = "val-sellshop",  -- must be unique
        header = "Valentine Vendor", -- menu header
        coords = vector3(-355.7784, 775.41345, 116.23655 -0.8), -- location of sell shop
        blip = { -- blip settings
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = "Valentine Vendor",
        },
        showblip = true,
        shopdata = { -- shop data
            {
                title = "Bread",
                description = "sell bread",
                price = 0.03,
                item = "bread",
            image = "bread.png"
            },
            {
                title = "Water",
                description = "sell water",
                price = 0.03,
                item = "water",
                image = "water.png"
            },
        },
    },
    -- mining vendor
    {
        prompt = "mining1-sellshop",  -- must be unique
        header = "Mining Vendor", -- menu header
        coords = vector3(2435.36, -1511.59, 45.97), -- location of sell shop
        blip = { -- blip settings
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = "Mining Vendor",
        },
        showblip = true,
        shopdata = { -- shop data
            {
                title = "Copper",
                description = "sell copper",
                price = 0.25,
                item = "copper",
            image = "copper.png"
            },
            {
                title = "Aluminum",
                description = "sell aluminum",
                price = 0.30,
                item = "aluminum",
                image = "aluminum.png"
            },
            {
                title = "Iron",
                description = "sell iron",
                price = 0.40,
                item = "iron",
                image = "iron.png"
            },
            {
                title = "Steel",
                description = "sell steel",
                price = 0.50,
                item = "steel",
                image = "steel.png"
            },
        },
    },
    -- guarma trade point
    {
        prompt = "guarma-sellshop",  -- must be unique
        header = "Guarma Vendor", -- menu header
        coords = vector3(1284.16, -6871.74, 43.4), -- location of sell shop
        blip = { -- blip settings
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = "Guarma Vendor",
        },
        showblip = true,
        shopdata = { -- shop data
            {
                title = "Box of Cigars",
                description = "sell your cigar boxes",
                price = 20,
                item = "cigarbox",
                image = "cigarbox.png"
            },
        },
    },
}

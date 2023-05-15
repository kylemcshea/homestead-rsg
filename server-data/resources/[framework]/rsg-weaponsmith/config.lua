Config = {}

-- debug
Config.Debug = false

-- settings
Config.StorageMaxWeight = 4000000
Config.StorageMaxSlots = 48

-- blip settings
Config.Blip = {
    blipName = 'Weaponsmith', -- Config.Blip.blipName
    blipSprite = 'blip_shop_gunsmith', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

Config.WeaponCraftingPoint = {

    {   -- valentine
        name = 'Valentine Weapon Crafting', 
        prompt = 'weaponsmith-1',
        job = 'valweaponsmith',
        coords = vector3(-277.2185, 779.09729, 119.50399), 
        showblip = false, 
        showmarker = true
    },
    {   -- rhodes
        name = 'Rhodes Weapon Crafting', 
        prompt = 'weaponsmith-2',
        job = 'rhoweaponsmith',
        coords = vector3(1327.1809, -1322.01, 77.888885), 
        showblip = false, 
        showmarker = true
    },

}

Config.WeaponPartsCrafting = {

    -- base weapon items
    ['trigger'] = {
        name = 'trigger',
        lable = 'Trigger',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'steel', amount = 1 },
        },
        receive = 'trigger'
    },
    
    ['hammer'] = {
        name = 'hammer',
        lable = 'Hammer',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'steel', amount = 1 },
        },
        receive = 'hammer'
    },
    
    ['barrel'] = {
        name = 'barrel',
        lable = 'Barrel',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'steel', amount = 1 },
        },
        receive = 'barrel'
    },
    
    ['spring'] = {
        name = 'spring',
        lable = 'Spring',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'steel', amount = 1 },
        },
        receive = 'spring'
    },
    
    ['frame'] = {
        name = 'frame',
        lable = 'Frame',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'steel', amount = 1 },
        },
        receive = 'frame'
    },

    ['grip'] = {
        name = 'grip',
        lable = 'Grip',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'steel', amount = 1 },
            [2] = { item = 'wood', amount = 1 },
        },
        receive = 'grip'
    },

    ['cylinder'] = {
        name = 'cylinder',
        lable = 'Cylinder',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'steel', amount = 1 },
        },
        receive = 'cylinder'
    },
    
}

Config.RevloverCrafting = {
    
    -- revlover crafting
    ['weapon_revolver_navy'] = {
        name = 'weapon_revolver_navy',
        lable = 'Navy Revolver',
        crafttime = 20000,
        craftitems = {
            [1] = { item = 'trigger',  amount = 1 },
            [2] = { item = 'hammer',   amount = 1 },
            [3] = { item = 'barrel',   amount = 1 },
            [4] = { item = 'frame',    amount = 1 },
            [5] = { item = 'grip',     amount = 1 },
            [6] = { item = 'cylinder', amount = 1 },
        },
        receive = 'weapon_revolver_navy'
    },
    
}

Config.PistolCrafting = {
    
    -- pistol crafting

}

Config.RepeaterCrafting = {
    
    -- repeater crafting

}

Config.RifleCrafting = {
    
    -- rifle crafting

}

Config.ShotgunCrafting = {
    
    -- shotgun crafting

}

Config = {}

Config.EnableExtraMenu = false

Config.MenuItems = {
    [1] = {
        id = 'world',
        title = 'World',
        icon = 'globe',
        items = {
        },
    }, 
    [2] = {
        id = 'horse',
        title = 'Horse',
        icon = 'horse-head',
        items = {
            {
                id = 'horselantern',
                title = 'Horse Lantern',
                icon = 'lightbulb',
                type = 'client',
                event = 'rsg-horses:client:equipHorseLantern',
                shouldClose = true
            },
            {
                id = 'horseinventory',
                title = 'Inventory',
                icon = 'box',
                type = 'client',
                event = 'rsg-horses:client:inventoryHorse',
                shouldClose = true
            },
        },
    },
    [3] = {
        id = 'user',
        title = 'User',
        icon = 'user',
        items = {
            {     
                id = 'walkstyles',
                title = 'Walk Styles',
                icon = 'person-walking',
                items = {
                    {
                        id = 'normal',
                        title = 'Normal',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'walkstyles:client:normal',
                        shouldClose = true
                    },
                    {
                        id = 'angry',
                        title = 'Angry',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'walkstyles:client:angry',
                        shouldClose = true
                    },
                    {
                        id = 'war_veteran',
                        title = 'Veteran',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'walkstyles:client:war_veteran',
                        shouldClose = true
                    },
                    {
                        id = 'gold_panner',
                        title = 'Gold Panner',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'walkstyles:client:gold_panner',
                        shouldClose = true
                    },
                    {
                        id = 'lost_Man',
                        title = 'Lost',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'walkstyles:client:lost_Man',
                        shouldClose = true
                    },
                    {
                        id = 'murfree',
                        title = 'Murfree',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'walkstyles:client:murfree',
                        shouldClose = true
                    },
                    {
                        id = 'primate',
                        title = 'Primate',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'walkstyles:client:primate',
                        shouldClose = true
                    },
                }
            },
            {
                id = 'emotes',
                title = 'Emotes',
                icon = 'hand',
                type = 'command',
                event = 'em',
                shouldClose = true
            },
            {
                id = 'contraband',
                title = 'Contraband',
                icon = 'skull-crossbones',
                type = 'command',
                event = 'sellcontraband',
                shouldClose = true
            },
            {
                id = 'pvptoggle',
                title = 'Toggle PVP on/off',
                icon = 'hand-holding-hand',
                type = 'client',
                event = 'rsg-pvp:client:pvpToggle',
                shouldClose = true
            },
            {
                id = 'billing',
                title = 'Billing',
                icon = 'file-invoice-dollar',
                type = 'client',
                event = 'rsg-billing:client:billingMenu',
                shouldClose = true
            },
            {
                id= 'adressbook',
                title = 'Adress book',
                icon = 'address-book',
                type = 'client',
                event = 'rsg-telegram:client:OpenAddressbook',
                shouldClose = true
            },
        },
    },
    [4] = {
        id = 'clothing',
        title = 'Clothing',
        icon = 'shirt',
        items = {
            {
                id = 'onoffhat',
                title = 'Hat',
                icon = 'hat-cowboy',
                type = 'command',
                event = 'hat',
                shouldClose = true
            },
            {
                id = 'onoffvest',
                title = 'Vest',
                icon = 'vest',
                type = 'command',
                event = 'vest',
                shouldClose = true
            },
            {
                id = 'onoffboots',
                title = 'Boots',
                icon = 'shoe-prints',
                type = 'command',
                event = 'boots',
                shouldClose = true
            },
            {
                id = 'onoffpants',
                title = 'Pants',
                icon = 'circle-user',
                type = 'command',
                event = 'pants',
                shouldClose = true
            },
            {
                id = 'onoffshirt',
                title = 'Shirt',
                icon = 'shirt',
                type = 'command',
                event = 'shirt',
                shouldClose = true
            },
            {
                id = 'onoffgunbelt',
                title = 'Gun Belt',
                icon = 'gun',
                type = 'command',
                event = 'gunbelt',
                shouldClose = true
            },
            {
                id = 'onoffmask',
                title = 'Mask',
                icon = 'masks-theater',
                type = 'command',
                event = 'mask',
                shouldClose = true
            },
            {
                id = 'onoffcoat',
                title = 'Coat',
                icon = 'vest-patches',
                type = 'command',
                event = 'coat',
                shouldClose = true
            },
            {
                id = 'onoffclosedcoat',
                title = 'Closed Coat',
                icon = 'vest-patches',
                type = 'command',
                event = 'closedcoat',
                shouldClose = true
            },
        },
    },
}

Config.JobInteractions = {
    ["medic"] = {
        {
            id = 'medicbutton',
            title = 'Emergency Button',
            icon = 'exclamation',
            type = 'client',
            event = 'rsg-radialmenu:client:SendMedicEmergencyAlert',
            shouldClose = true
        },{
            id = 'revivep',
            title = 'Revive',
            icon = 'user-doctor',
            type = 'client',
            event = 'rsg-medic:client:RevivePlayer',
            shouldClose = true
        },{
            id = 'treatwounds',
            title = 'Heal wounds',
            icon = 'bandage',
            type = 'client',
            event = 'rsg-medic:client:TreatWounds',
            shouldClose = true
        }
    },
    ["police"] = {
        {
            id = 'policebutton',
            title = 'Emergency Button',
            icon = 'exclamation',
            type = 'client',
            event = 'rsg-radialmenu:client:SendPoliceEmergencyAlert',
            shouldClose = true
        },{
            id = 'handcuff',
            title = 'Cuff',
            icon = 'user-lock',
            type = 'client',
            event = 'police:client:CuffPlayerSoft',
            shouldClose = true
        },{
            id = 'checkstatus',
            title = 'Check status',
            icon = 'question',
            type = 'client',
            event = 'police:client:CheckStatus',
            shouldClose = true
        },{
            id = 'escort',
            title = 'Escort',
            icon = 'user-group',
            type = 'client',
            event = 'police:client:EscortPlayer',
            shouldClose = true
        }, {
            id = 'searchplayer',
            title = 'Search Player',
            icon = 'magnifying-glass',
            type = 'client',
            event = 'police:client:SearchPlayer',
            shouldClose = true
        }, {
            id = 'searchhorse',
            title = 'Search Horse',
            icon = 'magnifying-glass',
            type = 'client',
            event = 'police:client:SearchHorse',
            shouldClose = true
        }, {
            id = 'jailplayer',
            title = 'Jail',
            icon = 'user-lock',
            type = 'client',
            event = 'police:client:JailPlayer',
            shouldClose = true
        }, {
            id = 'lawbadge',
            title = 'Badge On/Off',
            icon = 'id-badge',
            type = 'command',
            event = 'lawbadge',
            shouldClose = true
        }, 
    },
    ["horsetrainer"] = {
        {
            id = 'starttraining',
            title = 'Toggle Training On/Off',
            icon = 'horse-head',
            type = 'client',
            event = 'rsg-horsetrainer:client:startTraining',
            shouldClose = true
        },
        {
            id = 'trainerbrush',
            title = 'Trainer Brush',
            icon = 'horse-head',
            type = 'client',
            event = 'rsg-horsetrainer:client:brushHorse',
            shouldClose = true
        },
        {
            id = 'trainercarrot',
            title = 'Trainer Carrot',
            icon = 'horse-head',
            type = 'client',
            event = 'rsg-horsetrainer:client:feedHorse',
            shouldClose = true
        },
        {
            id = 'checkhorsexp',
            title = 'Check Horse EXP',
            icon = 'horse-head',
            type = 'client',
            event = 'rsg-horsetrainer:client:checkHorseEXP',
            shouldClose = true
        }
    },
}

local RSGCore = exports['rsg-core']:GetCoreObject()
local PlayerData = RSGCore.Functions.GetPlayerData()
local bpos
local crafting

--------------------------------------------------------------------------

-- start invension shop
Citizen.CreateThread(function()
    for bpos, v in pairs(Config.InvensionShopLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], Lang:t('menu.open') .. v.name, {
            type = 'client',
            event = 'rsg-crafting:client:OpenInvensionShop',
        })
        if v.showblip == true then
            local StoreBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(StoreBlip, 1475879922, 1)
            SetBlipScale(StoreBlip, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, StoreBlip, v.name)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        local sleep = 0
        for bpos, v in pairs(Config.InvensionShopLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('rsg-crafting:client:OpenInvensionShop')
AddEventHandler('rsg-crafting:client:OpenInvensionShop', function()
    local ShopItems = {}
    ShopItems.label = "Invension Shop"
    ShopItems.items = Config.InvensionShop
    ShopItems.slots = #Config.InvensionShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "InvensionShop_"..math.random(1, 99), ShopItems)
end)
-- end invension shop

--------------------------------------------------------------------------

-- crafting locations
Citizen.CreateThread(function()
    for crafting, v in pairs(Config.CraftingLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-crafting:client:OpenMenu',
        })
        if v.showblip == true then
            local CraftingBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(CraftingBlip, 3535996525, 1)
            SetBlipScale(CraftingBlip, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, CraftingBlip, v.name)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        local sleep = 0
        for crafting, v in pairs(Config.CraftingLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

-- crafting menu
RegisterNetEvent('rsg-crafting:client:OpenMenu', function()
    exports['rsg-menu']:openMenu({
        {
            header = Lang:t('menu.crafting_menu'),
            isMenuHeader = true,
        },
        {
            header = Lang:t('menu.craft_shovel'),
            icon = "fas fa-cog",
            txt = Lang:t('text.xbpc_xsteel_xwood'),
            params = {
                event = "rsg-crafting:client:craftshovel"
            }
        },
        {
            header = Lang:t('menu.craft_axe'),
            icon = "fas fa-cog",
            txt = Lang:t('text.xbpc_xsteel_xwood'),
            params = {
                event = "rsg-crafting:client:craftaxe"
            }
        },
        {
            header = Lang:t('menu.craft_pickAxe'),
            icon = "fas fa-cog",
            txt = Lang:t('text.xbpc_xsteel_xwood'),
            params = {
                event = "rsg-crafting:client:craftpickaxe"
            }
        },
    })
end)

--------------------------------------------------------------------------

-- make copy from blueprint original
RegisterNetEvent('rsg-crafting:client:makecopy')
AddEventHandler('rsg-crafting:client:makecopy', function(bpo, bpc, name)
    local hasItem = RSGCore.Functions.HasItem(bpo, 1)
    if hasItem then
        RSGCore.Functions.Progressbar(Lang:t('progressbar.copy')..name, Lang:t('progressbar.making_copy_of')..name..'..', Config.BPOCopyTime, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('rsg-crafting:server:givecopy', bpc)
        end)
    else
        RSGCore.Functions.Notify(Lang:t('error.you_dont_have_this_blueprint_original'), 'error')
    end
end)

--------------------------------------------------------------------------

-- shovel crafting
RegisterNetEvent('rsg-crafting:client:craftshovel')
AddEventHandler('rsg-crafting:client:craftshovel', function()
    local hasItem1 = RSGCore.Functions.HasItem('bpcshovel', 1)
    local hasItem2 = RSGCore.Functions.HasItem('steel', 3)
    local hasItem3 = RSGCore.Functions.HasItem('wood', 1)
    if hasItem1 and hasItem2 and hasItem3 then
        RSGCore.Functions.Progressbar("crafting-shovel", Lang:t('progressbar.crafting_shovel'), Config.ShovelCraftTime, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('rsg-crafting:server:craftshovel')
        end)
    else
        RSGCore.Functions.Notify(Lang:t('error.need_more_crafting_items'), 'error')
    end
end)

--------------------------------------------------------------------------

-- axe crafting
RegisterNetEvent('rsg-crafting:client:craftaxe')
AddEventHandler('rsg-crafting:client:craftaxe', function()
    local hasItem1 = RSGCore.Functions.HasItem('bpcaxe', 1)
    local hasItem2 = RSGCore.Functions.HasItem('steel', 3)
    local hasItem3 = RSGCore.Functions.HasItem('wood', 1)
    if hasItem1 and hasItem2 and hasItem3 then
        RSGCore.Functions.Progressbar("crafting-axe", Lang:t('progressbar.crafting_axe'), Config.AxeCraftTime, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('rsg-crafting:server:craftaxe')
        end)
    else
        RSGCore.Functions.Notify(Lang:t('error.need_more_crafting_items'), 'error')
    end
end)

--------------------------------------------------------------------------

-- pickaxe crafting
RegisterNetEvent('rsg-crafting:client:craftpickaxe')
AddEventHandler('rsg-crafting:client:craftpickaxe', function()
    local hasItem1 = RSGCore.Functions.HasItem('bpcpickaxe', 1)
    local hasItem2 = RSGCore.Functions.HasItem('steel', 3)
    local hasItem3 = RSGCore.Functions.HasItem('wood', 1)
    if hasItem1 and hasItem2 and hasItem3 then
        RSGCore.Functions.Progressbar("crafting-pickaxe", Lang:t('progressbar.crafting_pickAxe'), Config.PickAxeCraftTime, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('rsg-crafting:server:craftpickaxe')
        end)
    else
        RSGCore.Functions.Notify(Lang:t('error.need_more_crafting_items'), 'error')
    end
end)

--------------------------------------------------------------------------

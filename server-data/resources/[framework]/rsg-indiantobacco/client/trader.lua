local RSGCore = exports['rsg-core']:GetCoreObject()
local indiantrader

-- prompts
Citizen.CreateThread(function()
    for indiantrader, v in pairs(Config.IndianTraderLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-indiantrader:client:openMenu',
            args = {},
        })
        if v.showblip == true then
            local IndianTraderBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(IndianTraderBlip, Config.Blip.blipSprite, 1)
            SetBlipScale(IndianTraderBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, IndianTraderBlip, Config.Blip.blipName)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        local sleep = 0
        for indiantrader, v in pairs(Config.IndianTraderLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

-- outlaw menu
RegisterNetEvent('rsg-indiantrader:client:openMenu', function(data)
    exports['rsg-menu']:openMenu({
        {
            header = "| Indian Trader Menu |",
            isMenuHeader = true,
        },
        {
            header = "Trade 10 Indian Tobacco",
            txt = "trade 10 tobacco for 1 indian cigars",
            params = {
                event = 'rsg-indiantrader:server:tradetobacco',
                isServer = true,
                args = {trade = 1}
            }
        },
        {
            header = "Trade 50 Indian Tobacco",
            txt = "trade 50 tobacco for 5 indian cigars",
            params = {
                event = 'rsg-indiantrader:server:tradetobacco',
                isServer = true,
                args = {trade = 5}
            }
        },
        {
            header = "Trade 100 Indian Tobacco",
            txt = "trade 10 tobacco for 10 indian cigars",
            params = {
                event = 'rsg-indiantrader:server:tradetobacco',
                isServer = true,
                args = {trade = 10}
            }
        },
        {
            header = "Open Trader Shop",
            txt = "buy indian trade items",
            params = {
                event = 'rsg-indiantrader:client:OpenIndianShop',
                isServer = false,
                args = {}
            }
        },
        {
            header = "Close Menu",
            txt = '',
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
end)

-- indian trader shop
RegisterNetEvent('rsg-indiantrader:client:OpenIndianShop')
AddEventHandler('rsg-indiantrader:client:OpenIndianShop', function()
    local ShopItems = {}
    ShopItems.label = "Indian Trader"
    ShopItems.items = Config.IndianTraderShop
    ShopItems.slots = #Config.IndianTraderShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "IndianTraderShop_"..math.random(1, 99), ShopItems)
end)
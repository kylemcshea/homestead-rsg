local RSGCore = exports['rsg-core']:GetCoreObject()
local PlayerData = RSGCore.Functions.GetPlayerData()
local currentjob

-----------------------------------------------------------------------------------

-- wholesale prompts and blips
Citizen.CreateThread(function()
    for wholesale, v in pairs(Config.WholesaleLocations) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-wholesaletrader:client:openMenu',
            args = { v.job },
        })
        if v.showblip == true then
            local WholesaleTraderBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(WholesaleTraderBlip, GetHashKey(Config.WholesaleBlip.blipSprite), true)
            SetBlipScale(WholesaleTraderBlip, Config.WholesaleBlip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, WholesaleTraderBlip, Config.WholesaleBlip.blipName)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        Wait(1)
        for trapper, v in pairs(Config.WholesaleLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
    end
end)

-----------------------------------------------------------------------------------

-- wholesale trader menu
RegisterNetEvent('rsg-wholesaletrader:client:openMenu', function(job)
    local playerjob = RSGCore.Functions.GetPlayerData().job.name
    if playerjob == job then
        currentjob = job
        exports['rsg-menu']:openMenu({
            {
                header = Lang:t('menu.wholesale_trader'),
                isMenuHeader = true,
            },
            {
                header = Lang:t('menu.wholesale_storage'),
                txt = "",
                icon = "fas fa-box",
                params = {
                    event = 'rsg-wholesaletrader:client:storage',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = Lang:t('menu.wholesale_imports'),
                txt = "",
                icon = "fas fa-box",
                params = {
                    event = 'rsg-wholesaletrader:client:openShop',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = Lang:t('menu.job_management'),
                txt = "",
                icon = "fas fa-user-circle",
                params = {
                    event = 'rsg-bossmenu:client:OpenMenu',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = Lang:t('menu.job_wagon'),
                txt = "",
                icon = "fas fa-horse",
                params = {
                    event = 'rsg-jobwagon:client:openWagonMenu',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = Lang:t('menu.close_menu'),
                txt = '',
                params = {
                    event = 'rsg-menu:closeMenu',
                }
            },
        })
    else
        RSGCore.Functions.Notify(Lang:t('error.not_authorised'), 'error')
    end
end)

-----------------------------------------------------------------------------------

-- wholesale shop
RegisterNetEvent('rsg-wholesaletrader:client:openShop')
AddEventHandler('rsg-wholesaletrader:client:openShop', function()
    local job = RSGCore.Functions.GetPlayerData().job.name
    if job == currentjob then
        local ShopItems = {}
        ShopItems.label = "Wholesale Shop"
        ShopItems.items = Config.WholesaleShop
        ShopItems.slots = #Config.WholesaleShop
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "WholesaleShop_"..math.random(1, 99), ShopItems)
    else
        RSGCore.Functions.Notify(Lang:t('error.not_authorised'), 'error')
    end
end)

-----------------------------------------------------------------------------------

-- wholesale trader general storage
RegisterNetEvent('rsg-wholesaletrader:client:storage', function()
    local job = RSGCore.Functions.GetPlayerData().job.name
    if job == currentjob then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", currentjob, {
            maxweight = Config.StorageMaxWeight,
            slots = Config.StorageMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", currentjob)
    end
end)

-----------------------------------------------------------------------------------

local RSGCore = exports['rsg-core']:GetCoreObject()
local butcher
local name

-- prompts
Citizen.CreateThread(function()
    for butcher, v in pairs(Config.ButcherLocations) do
        local name = v.name
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'],  Lang:t('menu.open') .. v.name, {
            type = 'client',
            event = 'rsg-butcher:client:menu',
            args = { name },
        })
        if v.showblip == true then
            local ButcherBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(ButcherBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(ButcherBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, ButcherBlip, Config.Blip.blipName)
        end
    end
end)

-- butcher menu
RegisterNetEvent('rsg-butcher:client:menu', function(butchername)
    exports['rsg-menu']:openMenu({
        {
            header = butchername,
            isMenuHeader = true,
        },
        {
            header = Lang:t('menu.sell_animal'),
            txt = Lang:t('menu.sell_your_animal_the_butcher'),
            icon = "fas fa-paw",
            params = {
                event = 'rsg-butcher:client:sellanimal',
                isServer = false,
                args = {}
            }
        },
        {
            header = Lang:t('menu.open_shop'),
            txt = Lang:t('menu.buy_items_from_butcher'),
            icon = "fas fa-shopping-basket",
            params = {
                event = 'rsg-butcher:client:OpenButcherShop',
                isServer = false,
                args = {}
            }
        },
        {
            header =  Lang:t('menu.close_menu'),
            txt = '',
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
end)

RegisterNetEvent('rsg-butcher:client:sellanimal')
AddEventHandler('rsg-butcher:client:sellanimal', function()
    local ped = PlayerPedId()
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- GetFirstEntityPedIsCarrying
    local model = GetEntityModel(holding)
    local quality = Citizen.InvokeNative(0x7BCC6087D130312A, holding)
    if Config.Debug == true then
        print("model: "..tostring(model))
        print("quality: "..tostring(quality))
    end    
    if holding ~= false then
        for i = 1, #Config.Animal do
            if model == Config.Animal[i].model then
                local rewardmoney = Config.Animal[i].rewardmoney
                local rewarditem = Config.Animal[i].rewarditem
                local name = Config.Animal[i].name
                if Config.Debug == true then
                    print("reward money: "..tostring(rewardmoney))
                    print("reward item: "..tostring(rewarditem))
                    print("name: "..tostring(name))
                end
                RSGCore.Functions.Progressbar('sell-carcass',  Lang:t('progressbar.selling')..name..'..', Config.SellTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    local deleted = DeleteThis(holding)
                    if deleted then
                        if quality == false then
                            TriggerServerEvent('rsg-butcher:server:reward', rewardmoney, rewarditem, 'poor') -- poor quality reward
                        end
                        if quality == 0 then
                            TriggerServerEvent('rsg-butcher:server:reward', rewardmoney, rewarditem, 'poor') -- poor quality reward
                        end
                        if quality == 1 then
                            TriggerServerEvent('rsg-butcher:server:reward', rewardmoney, rewarditem, 'good') -- good quality reward
                        end
                        if quality == 2 then
                            TriggerServerEvent('rsg-butcher:server:reward', rewardmoney, rewarditem, 'perfect') -- perfect quality reward
                        end
                        if quality == -1 then
                            TriggerServerEvent('rsg-butcher:server:reward', rewardmoney, rewarditem, 'perfect') -- perfect quality reward
                        end
                    else
                        RSGCore.Functions.Notify(Lang:t('error.something_went_wrong'), 'error')
                    end
                end)
            end
        end
    else
        RSGCore.Functions.Notify(Lang:t('error.dont_have_animal'), 'error')
    end
end)

function DeleteThis(holding)
    NetworkRequestControlOfEntity(holding)
    SetEntityAsMissionEntity(holding, true, true)
    Wait(100)
    DeleteEntity(holding)
    Wait(500)
    local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    local holdingcheck = GetPedType(entitycheck)
    if holdingcheck == 0 then
        return true
    else
        return false
    end
end

RegisterNetEvent('rsg-butcher:client:OpenButcherShop')
AddEventHandler('rsg-butcher:client:OpenButcherShop', function()
    local ShopItems = {}
    ShopItems.label = Lang:t('menu.butcher_shop')
    ShopItems.items = Config.ButcherShop
    ShopItems.slots = #Config.ButcherShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "ButcherShop_"..math.random(1, 99), ShopItems)
end)

--  0: "PED_QUALITY_LOW"
--  1: "PED_QUALITY_MEDIUM"
--  2: "PED_QUALITY_HIGH"
-- -1: you should interpret as "PED_QUALITY_HIGH"

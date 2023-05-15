local RSGCore = exports['rsg-core']:GetCoreObject()
local isLoggedIn = false

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

--------------------------------------------------------------------------------------------------

-- hotel prompts
Citizen.CreateThread(function()
    for hotel, v in pairs(Config.HotelLocations) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], Lang:t('menu.open') .. v.name, {
            type = 'client',
            event = 'rsg-hotel:client:menu',
            args = { v.name, v.location },
        })
        if v.showblip == true then
            local HotelBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(HotelBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(HotelBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, HotelBlip, Config.Blip.blipName)
        end
    end
end)

-- hotel menu
RegisterNetEvent('rsg-hotel:client:menu', function(hotelname, hotellocation)
    exports['rsg-menu']:openMenu({
        {
            header = hotelname,
            isMenuHeader = true,
        },
        {
            header = Lang:t('menu.check_in'),
            txt = '',
            icon = "fas fa-concierge-bell",
            params = {
                event = 'rsg-hotel:server:CheckIn',
                isServer = true,
                args = { location = hotellocation }
            }
        },
        {
            header = Lang:t('menu.rent_room_deposit',{startCredit = Config.StartCredit}),
            txt = '',
            icon = "fas fa-bed",
            params = {
                event = 'rsg-hotel:server:RentRoom',
                isServer = true,
                args = { location = hotellocation }
            }
        },
        {
            header = Lang:t('menu.close_menu'),
            txt = '',
            icon = "fas fa-times",
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
    
end)

--------------------------------------------------------------------------------------------------

-- transfer player to room
RegisterNetEvent('rsg-hotel:client:gotoRoom', function(location)
    if location == 'valentine' then
        DoScreenFadeOut(500)
        Wait(1000)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-323.935, 767.02294, 121.6327, 102.64147))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if location == 'strawberry' then
        DoScreenFadeOut(500)
        Wait(1000)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-1813.903, -370.0737, 166.49919, 269.52258))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if location == 'rhodes' then
        DoScreenFadeOut(500)
        Wait(1000)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(1331.4257, -1371.862, 80.490127, 259.164))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if location == 'stdenis' then
        DoScreenFadeOut(500)
        Wait(1000)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(2637.925, -1222.1, 59.600513, 179.36787))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if location == 'blackwater' then
        DoScreenFadeOut(500)
        Wait(1000)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-820.16, -1324.35, 47.97, 90.93))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if location == 'tumbleweed' then
        DoScreenFadeOut(500)
        Wait(1000)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-5513.73, -2972.29, 2.22, 21.03))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if location == 'annesburg' then
        DoScreenFadeOut(500)
        Wait(1000)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(2946.09, 1330.59, 44.46, 167.87))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
end)

--------------------------------------------------------------------------------------------------

-- room menu prompt
Citizen.CreateThread(function()
    for hotelexit, v in pairs(Config.HotelRoom) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], Lang:t('menu.room_menu'), {
            type = 'client',
            event = 'rsg-hotel:client:roommenu',
            args = { v.location },
        })
    end
end)

-- room menu
RegisterNetEvent('rsg-hotel:client:roommenu', function()
    RSGCore.Functions.TriggerCallback('rsg-hotel:server:GetActiveRoom', function(result)
        local activeRoom = {
            {
                header = Lang:t('menu.hotel_room')..result.roomid,
                txt = '',
                isMenuHeader = true
            },
        }
        activeRoom[#activeRoom+1] = {
            header = Lang:t('menu.add_credit'),
            txt = Lang:t('text.current_credit')..result.credit,
            icon = "fas fa-dollar-sign",
            params = {
                event = "rsg-hotel:client:addcredit",
                isServer = false,
                args = { room = result.roomid, credit = result.credit },
            }
        }
        activeRoom[#activeRoom+1] = {
            header = Lang:t('menu.wardrobe'),
            txt = '',
            icon = "fas fa-hat-cowboy-side",
            params = {
                event = "rsg-clothes:OpenOutfits",
                isServer = false,
                args = {},
            }
        }
        activeRoom[#activeRoom+1] = {
            header = Lang:t('menu.room_locker'),
            txt = '',
            icon = "fas fa-box",
            params = {
                event = "rsg-hotel:client:roomlocker",
                isServer = false,
                args = { roomid = result.roomid, location = result.location },
            }
        }
        activeRoom[#activeRoom+1] = {
            header = 'Mini-Bar',
            txt = '',
            icon = "fas fa-glass-cheers",
            params = {
                event = "rsg-hotel:client:minibar",
                isServer = false,
                args = { roomid = result.roomid },
            }
        }
        activeRoom[#activeRoom+1] = {
            header =  Lang:t('menu.leave_room'),
            txt = '',
            icon = "fas fa-door-open",
            params = {
                event = 'rsg-hotel:client:leaveroom',
                isServer = false,
                args = { exitroom = result.location }
            }
        }
        activeRoom[#activeRoom+1] = {
            header = Lang:t('menu.close_menu'),
            txt = '',
            icon = "fas fa-times",
            params = {
                event = 'rsg-menu:closeMenu',
            }
        }
        exports['rsg-menu']:openMenu(activeRoom)
    end)
end)

--------------------------------------------------------------------------------------------------

RegisterNetEvent('rsg-hotel:client:addcredit', function(data)
    local dialog = exports['rsg-input']:ShowInput({
        header = Lang:t('menu.add_credit_room')..data.room,
        submitText = "",
        inputs = {
            {
                text = Lang:t('text.amount'),
                name = "addcredit",
                type = "number",
                isRequired = true,
                default = 10,
            },
        }
    })
    if dialog ~= nil then
        for k,v in pairs(dialog) do
            if Config.Debug == true then
                print(dialog.addcredit)
                print(data.room)
            end
            local newcredit = (data.credit + dialog.addcredit)
            TriggerServerEvent('rsg-hotel:server:addcredit', tonumber(newcredit), tonumber(dialog.addcredit), data.room)
        end
    end
end)

--------------------------------------------------------------------------------------------------

-- leave room
RegisterNetEvent('rsg-hotel:client:leaveroom')
AddEventHandler('rsg-hotel:client:leaveroom', function(data)
    if Config.Debug == true then
        print(data.exitroom)
    end
    local roomlocation = data.exitroom
    if roomlocation == 'valentine' then
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent('rsg-hotel:server:setdefaultbucket')
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-328.99, 772.95, 117.45, 13.64))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if roomlocation == 'strawberry' then
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent('rsg-hotel:server:setdefaultbucket')
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-1814.274, -369.9327, 162.88313, 277.07699))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if roomlocation == 'rhodes' then
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent('rsg-hotel:server:setdefaultbucket')
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(1334.2458, -1368.744, 80.490165, 258.45336))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if roomlocation == 'stdenis' then
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent('rsg-hotel:server:setdefaultbucket')
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(2633.2497, -1223.527, 59.594661, 176.20422))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if roomlocation == 'blackwater' then
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent('rsg-hotel:server:setdefaultbucket')
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-819.7, -1313.11, 43.77, 248.03))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if roomlocation == 'tumbleweed' then
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent('rsg-hotel:server:setdefaultbucket')
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(-5518.85, -2976.54, -0.78, 108.9))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
    if roomlocation == 'annesburg' then
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent('rsg-hotel:server:setdefaultbucket')
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector4(2946.28, 1333.36, 44.45, 55.87))
        Wait(1500)
        DoScreenFadeIn(1800)
    end
end)

--------------------------------------------------------------------------------------------------

-- room storage locker
RegisterNetEvent('rsg-hotel:client:roomlocker', function(data)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'room_'..data.roomid..'_'..data.location, {
        maxweight = Config.StorageMaxWeight,
        slots = Config.StorageMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'room_'..data.roomid..'_'..data.location)
end)

RegisterNetEvent('rsg-hotel:client:minibar')
AddEventHandler('rsg-hotel:client:minibar', function(data)
    local ShopItems = {}
    ShopItems.label = Lang:t('menu.room')..data.roomid..' Mini-Bar'
    ShopItems.items = Config.MiniBar
    ShopItems.slots = #Config.MiniBar
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Config.MiniBar_"..math.random(1, 99), ShopItems)
end)

--------------------------------------------------------------------------------------------------

-- lock hotel doors
Citizen.CreateThread(function()
    for k,v in pairs(Config.HotelDoors) do
        Citizen.InvokeNative(0xD99229FE93B46286, v, 1,1,0,0,0,0)
        DoorSystemSetDoorState(v, 1) 
    end
end)

--[[
    DOORSTATE_INVALID = -1,
    0 = DOORSTATE_UNLOCKED,
    1 = DOORSTATE_LOCKED_UNBREAKABLE,
    2 = DOORSTATE_LOCKED_BREAKABLE,
    3 = DOORSTATE_HOLD_OPEN_POSITIVE,
    4 = DOORSTATE_HOLD_OPEN_NEGATIVE
--]]

--------------------------------------------------------------------------------------------------

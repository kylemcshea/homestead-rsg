local RSGCore = exports['rsg-core']:GetCoreObject()
local speed = 0.0
local radarActive = false
local stress = 0
local hunger = 100
local thirst = 100
local cashAmount = 0
local bankAmount = 0
local isLoggedIn = false
local youhavemail = false
local incinematic = false
local inBathing = false
local showUI = true

RegisterNetEvent("HideAllUI")
AddEventHandler("HideAllUI", function()
    showUI = not showUI
end)

-- functions
local function GetShakeIntensity(stresslevel)
    local retval = 0.05
    for _, v in pairs(Config.Intensity['shake']) do
        if stresslevel >= v.min and stresslevel <= v.max then
            retval = v.intensity
            break
        end
    end
    return retval
end

local function GetEffectInterval(stresslevel)
    local retval = 60000
    for _, v in pairs(Config.EffectInterval) do
        if stresslevel >= v.min and stresslevel <= v.max then
            retval = v.timeout
            break
        end
    end
    return retval
end

-- Events

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateThirst', function(newThirst)
    thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)

-- Player HUD
CreateThread(function()
    while true do
        Wait(500)
        if LocalPlayer.state['isLoggedIn'] and incinematic == false and inBathing == false and showUI then
            local show = true
            local player = PlayerPedId()
            local playerid = PlayerId()
            if IsPauseMenuActive() then
                show = false
            end
            local voice = 0
            local talking = Citizen.InvokeNative(0x33EEF97F, playerid)
            if LocalPlayer.state['proximity'] then
                voice = LocalPlayer.state['proximity'].distance
            end
            SendNUIMessage({
                action = 'hudtick',
                show = show,
                health = GetEntityHealth(player) / 6, -- health in red dead max health is 600 so dividing by 6 makes it 100 here
                armor = Citizen.InvokeNative(0x2CE311A7, player),
                thirst = thirst,
                hunger = hunger,
                stress = stress,
                talking = talking,
                voice = voice,
                youhavemail = youhavemail,
            })
        else
            SendNUIMessage({
                action = 'hudtick',
                show = false,
            })
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000)

        local ped = PlayerPedId()
        local isMounted = IsPedOnMount(ped) or IsPedInAnyVehicle(ped)
        local IsBirdPostApproaching = exports['rsg-telegram']:IsBirdPostApproaching()

        if isMounted or IsBirdPostApproaching then
            if Config.MounttMinimap and showUI then
                if Config.MountCompass then
                    SetMinimapType(3)
                else
                    SetMinimapType(1)
                end
            else
                SetMinimapType(0)
            end
        else
            if Config.OnFootMinimap and showUI then
                SetMinimapType(1)
            else
                if Config.OnFootCompass and showUI then
                    SetMinimapType(3)
                else
                    SetMinimapType(0)
                end
            end
        end
    end
end)

-- Money HUD
RegisterNetEvent('hud:client:ShowAccounts', function(type, amount)
    if type == 'cash' then
        SendNUIMessage({
            action = 'show',
            type = 'cash',
            cash = string.format("%.2f", amount)
        })
    elseif type == 'bloodmoney' then
        SendNUIMessage({
            action = 'show',
            type = 'bloodmoney',
            bloodmoney = string.format("%.2f", amount)
        })
    elseif type == 'bank' then
        SendNUIMessage({
            action = 'show',
            type = 'bank',
            bank = string.format("%.2f", amount)
        })
    end
end)

RegisterNetEvent('hud:client:OnMoneyChange', function(type, amount, isMinus)
    RSGCore.Functions.GetPlayerData(function(PlayerData)
        cashAmount = PlayerData.money['cash']
        bloodmoneyAmount = PlayerData.money['bloodmoney']
        bankAmount = PlayerData.money['bank']
    end)
    SendNUIMessage({
        action = 'update',
        cash = RSGCore.Shared.Round(cashAmount, 2),
        bloodmoney = RSGCore.Shared.Round(bloodmoneyAmount, 2),
        bank = RSGCore.Shared.Round(bankAmount, 2),
        amount = RSGCore.Shared.Round(amount, 2),
        minus = isMinus,
        type = type,
    })
end)

-- Stress Gain

CreateThread(function() -- Speeding
    while true do
        if RSGCore ~= nil --[[ and isLoggedIn ]] then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                speed = GetEntitySpeed(GetVehiclePedIsIn(ped, false)) * 2.237 --mph
                if speed >= Config.MinimumSpeed then
                    TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                end
            end
        end
        Wait(20000)
    end
end)

CreateThread(function() -- Shooting
    while true do
        if RSGCore ~= nil --[[ and isLoggedIn ]] then
            if IsPedShooting(PlayerPedId()) then
                if math.random() < Config.StressChance then
                    TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                end
            end
        end
        Wait(6)
    end
end)

-- Stress Screen Effects
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local sleep = GetEffectInterval(stress)

        if stress >= 100 then
            local ShakeIntensity = GetShakeIntensity(stress)
            local FallRepeat = math.random(2, 4)
            local RagdollTimeout = (FallRepeat * 1750)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)

            if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                local player = PlayerPedId()
                SetPedToRagdollWithFall(player, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
            end

            Wait(500)
            for i = 1, FallRepeat, 1 do
                Wait(750)
                DoScreenFadeOut(200)
                Wait(1000)
                DoScreenFadeIn(200)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            end
        elseif stress >= Config.MinimumStress then
            local ShakeIntensity = GetShakeIntensity(stress)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
        end
        Wait(sleep)
    end
end)

-- check telegrams
CreateThread(function()
    while true do
        if isLoggedIn == true then
            RSGCore.Functions.TriggerCallback('hud:server:getTelegramsAmount', function(amount)
                if amount > 0 then
                    youhavemail = true
                else
                    youhavemail = false
                end
            end)
        end
        Wait(Config.TelegramCheck)
    end
end)

-- check cinematic and hide hud
CreateThread(function()
    while true do
        if LocalPlayer.state['isLoggedIn'] then
            local cinematic = Citizen.InvokeNative(0xBF7C780731AADBF8, Citizen.ResultAsInteger())
            local isBathingActive = exports['rsg-bathing']:IsBathingActive()

            if cinematic == 1 then
                incinematic = true
            else
                incinematic = false
            end

            if isBathingActive then
                inBathing = true
            else
                inBathing = false
            end
        end

        Wait(500)
    end
end)

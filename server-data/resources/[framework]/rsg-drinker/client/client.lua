local RSGCore = exports['rsg-core']:GetCoreObject()
local alcoholCount = 0
local effectActive = false

Citizen.CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then
            Wait(5000)
            alcoholCount = alcoholCount -1
            if Config.Debug == true then
                print("alcohol count: "..alcoholCount)
                Wait(1000)
            end
            if alcoholCount > Config.Drunk and alcoholCount < Config.PassOut then
                Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.95) --drunk
                if Config.DrunkEffect == true and effectActive == false then
                    AnimpostfxPlay("PlayerDrunk01") -- start screen effect
                    effectActive = true
                end
            elseif alcoholCount > Config.PassOut then
                TriggerEvent('rsg-drinker:client:puke')
                Wait(10000)
                TriggerEvent('rsg-drinker:client:cancelemote')
                TriggerEvent('rsg-drinker:client:sleep')
                Wait(30000)
                TriggerEvent('rsg-drinker:client:cancelemote')
                alcoholCount = Config.WakeUp
            else
                Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.0) --not drunk
                if Config.DrunkEffect == true and effectActive == true then
                    AnimpostfxStop("PlayerDrunk01") -- stop screen effect
                    effectActive = false
                end
            end
        else
            Wait(2000)
        end
    end
end)

RegisterNetEvent("rsg-drinker:client:DrinkWhiskey")
AddEventHandler("rsg-drinker:client:DrinkWhiskey", function()
    local modelhash = GetHashKey('p_bottleJD01x')
    RequestModel(modelhash)
    while not HasModelLoaded(modelhash) do
        Wait(10)
    end
    local propEntity = CreateObject(modelhash, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleJD01x_ph_r_hand'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_CHUG_TRANS'), 1, 0, -1.0)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1204708816 then
            alcoholCount = alcoholCount + Config.WhiskeyIncrease
            TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + Config.AddThurst)            
        end
    end
end)

RegisterNetEvent("rsg-drinker:client:DrinkBeer")
AddEventHandler("rsg-drinker:client:DrinkBeer", function()
    local modelhash = GetHashKey('p_bottleBeer01x')
    RequestModel(modelhash)
    while not HasModelLoaded(modelhash) do
        Wait(10)
    end
    local propEntity = CreateObject(modelhash, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_SALOON_BEER"), propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), 1587785400, 1, 0, -1082130432)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1183277175 then
            alcoholCount = alcoholCount + Config.BeerIncrease
            TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + Config.AddThurst)
        end
    end
end)

RegisterNetEvent("rsg-drinker:client:DrinkCoffee")
AddEventHandler("rsg-drinker:client:DrinkCoffee", function()
    local modelhash = GetHashKey('P_MUGCOFFEE01X')
    RequestModel(modelhash)
    while not HasModelLoaded(modelhash) do
        Wait(10)
    end
    local propEntity = CreateObject(modelhash, GetEntityCoords(PlayerPedId()), true, false, false, false, true)
    Citizen.InvokeNative(0x669655FFB29EF1A9, propEntity, 0, "CTRL_cupFill", 1.0)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_COFFEE"), propEntity, GetHashKey("P_MUGCOFFEE01X_PH_R_HAND"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1082130432)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + Config.AddThurst)
end)

RegisterNetEvent("rsg-drinker:client:DrinkMoonshine")
AddEventHandler("rsg-drinker:client:DrinkMoonshine", function()
    local dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a"
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local prop = GetHashKey("p_masonjarmoonshine01x")
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    RequestModel(prop)
    while not HasModelLoaded(prop) do
        Wait(10)
    end
    local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.05, -0.07, -0.05, -75.0, 60.0, 0.0, true, true, false, true,  1, true)
    TaskPlayAnim(PlayerPedId(), dict, "idle_a", 1.0, 8.0, -1, 31, 0, false, false, false)
    Wait(10000)
    ClearPedTasks(playerPed)
    DeleteObject(tempObj2)
    SetModelAsNoLongerNeeded(prop)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + Config.AddThurst)
    alcoholCount = alcoholCount + Config.MoonshineIncrease
end)

RegisterNetEvent('rsg-drinker:client:puke')
AddEventHandler('rsg-drinker:client:puke', function()
    loadAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
    TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_vomit@male_a@idle_b", "idle_f", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
end)

RegisterNetEvent('rsg-drinker:client:sleep')
AddEventHandler('rsg-drinker:client:sleep', function()
    loadAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
    TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@male_b@idle_b', 'idle_f', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
end)

RegisterNetEvent('rsg-drinker:client:cancelemote')
AddEventHandler('rsg-drinker:client:cancelemote', function()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
end)

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
end
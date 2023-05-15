local RSGCore = exports['rsg-core']:GetCoreObject()
local WashPrompt
local DrinkPrompt
local RiverGroup = GetRandomIntInRange(0, 0xffffff)

-- set wash prompt
function WashPrompt()
    Citizen.CreateThread(function()
        local str ="Wash"
        local wait = 0
        WashPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(WashPrompt, RSGCore.Shared.Keybinds['ENTER'])
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(WashPrompt, str)
        PromptSetEnabled(WashPrompt, true)
        PromptSetVisible(WashPrompt, true)
        PromptSetHoldMode(WashPrompt, true)
        PromptSetGroup(WashPrompt, RiverGroup)
        PromptRegisterEnd(WashPrompt)
    end)
end

-- set drink prompt
function DrinkPrompt()
    Citizen.CreateThread(function()
        local str ="Drink"
        local wait = 0
        DrinkPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(DrinkPrompt, RSGCore.Shared.Keybinds['J'])
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DrinkPrompt, str)
        PromptSetEnabled(DrinkPrompt, true)
        PromptSetVisible(DrinkPrompt, true)
        PromptSetHoldMode(DrinkPrompt, true)
        PromptSetGroup(DrinkPrompt, RiverGroup)
        PromptRegisterEnd(DrinkPrompt)
    end)
end

-- find water and set prompt
Citizen.CreateThread(function()
    WashPrompt()
    DrinkPrompt()

    while true do
        Wait(4)

        local playerPed = PlayerPedId()
        local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, playerPed)
        local weaponName = Citizen.InvokeNative(0x89CF5FF3D363311E, weapon, Citizen.ResultAsString())
        local coords = GetEntityCoords(playerPed)
        local water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
        local running = IsControlPressed(0, 0x8FFC75D6) or IsDisabledControlPressed(0, 0x8FFC75D6)

        if running or weaponName == "WEAPON_FISHINGROD" then goto continue end

        for k,v in pairs(Config.WaterTypes) do 
            if water == Config.WaterTypes[k]["waterhash"]  then
                if IsPedOnFoot(playerPed) then
                    if IsEntityInWater(playerPed) then
                        -- wash
                        local Wash = CreateVarString(10, 'LITERAL_STRING', Config.WaterTypes[k]["name"])
                        PromptSetActiveGroupThisFrame(RiverGroup, Wash)
                        
                        if PromptHasHoldModeCompleted(WashPrompt) then
                            StartWash("amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d", "idle_l")
                        end
                        -- drink
                        local drink = CreateVarString(10, 'LITERAL_STRING', Config.WaterTypes[k]["name"])
                        PromptSetActiveGroupThisFrame(RiverGroup, drink)
                        
                        if PromptHasHoldModeCompleted(DrinkPrompt) then
                            TriggerEvent('rsg-river:client:drink')    
                        end
                    end
                end
            end
        end

        ::continue::
    end
end)

-- drink action
AddEventHandler('rsg-river:client:drink', function()
    local src = source
    if drink ~= 0 then
        SetEntityAsMissionEntity(drink)
        DeleteObject(nativerioprop)
        drink = 0
    end
    local playerPed = PlayerPedId()
    Citizen.Wait(0)
    if IsPedMale(playerPed) then
        TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_DRINK_GROUND'), -1, true, false, false, false)
    else
        TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
    end
    Citizen.Wait(17000)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + math.random(50, 100))
    ClearPedTasks(PlayerPedId())
end)

-- wash action
StartWash = function(dic, anim)
    LoadAnim(dic)
    TaskPlayAnim(PlayerPedId(), dic, anim, 1.0, 8.0, 5000, 0, 0.0, false, false, false)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    ClearPedEnvDirt(PlayerPedId())
    ClearPedBloodDamage(PlayerPedId())
    N_0xe3144b932dfdff65(PlayerPedId(), 0.0, -1, 1, 1)
    ClearPedDamageDecalByZone(PlayerPedId(), 10, "ALL")
    Citizen.InvokeNative(0x7F5D88333EE8A86F, PlayerPedId(), 1)
end

LoadAnim = function(dic)
    RequestAnimDict(dic)
    while not (HasAnimDictLoaded(dic)) do
        Citizen.Wait(0)
    end
end

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

-- debug water hash
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
        local water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
        if Config.Debug == true then
            print("water: "..tostring(water))
            Wait(5000)
        end
    end
end)

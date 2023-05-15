local RSGCore = exports['rsg-core']:GetCoreObject()
isLoggedIn = false
local isBusy = false
PlayerJob = {}

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded')
AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = RSGCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('RSGCore:Client:OnJobUpdate')
AddEventHandler('RSGCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

local SpawnedPlants = {}
local InteractedPlant = nil
local HarvestedPlants = {}
local canHarvest = true
local closestPlant = nil
local isDoingAction = false

Citizen.CreateThread(function()
    while true do
    Wait(150)

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inRange = false

    for i = 1, #Config.Plants do
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)

        if dist < 50.0 then
            inRange = true
            local hasSpawned = false
            local needsUpgrade = false
            local upgradeId = nil
            local tableRemove = nil

            for z = 1, #SpawnedPlants do
                local p = SpawnedPlants[z]
                if p.id == Config.Plants[i].id then
                    hasSpawned = true
                end
            end

            if not hasSpawned then
                local hash = GetHashKey('indtobacco_p')
                while not HasModelLoaded(hash) do
                    Wait(10)
                    RequestModel(hash)
                end
                RequestModel(hash)
                local data = {}
                data.id = Config.Plants[i].id
                data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z -1.2, false, false, false) 
                SetEntityAsMissionEntity(data.obj, true)
                FreezeEntityPosition(data.obj, true)
                table.insert(SpawnedPlants, data)
                hasSpawned = false
            end
        end
    end
    if not InRange then
        Wait(5000)
    end
    end
end)

-- destroy plant
function DestroyPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = PlayerPedId()
        isDoingAction = true
        TriggerServerEvent('rsg-indiantobacco:server:plantHasBeenHarvested', plant.id)
        TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
        Wait(5000)
        ClearPedTasks(ped)
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        TriggerServerEvent('rsg-indiantobacco:server:destroyPlant', plant.id)
        isDoingAction = false
        canHarvest = true
    else
        RSGCore.Functions.Notify('error', 'error')
    end
end

-- havest plants
function HarvestPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = PlayerPedId()
        isDoingAction = true
        TriggerServerEvent('rsg-indiantobacco:server:plantHasBeenHarvested', plant.id)
        TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
        Wait(10000)
        ClearPedTasks(ped)
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        TriggerServerEvent('rsg-indiantobacco:server:harvestPlant', plant.id)
        isDoingAction = false
        canHarvest = true
    else
        RSGCore.Functions.Notify('error', 'error')
    end
end

function RemovePlantFromTable(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
end

-- trigger actions
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local InRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for k, v in pairs(Config.Plants) do
            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1.3 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(PlayerPedId(), false) then
                if PlayerJob.name == 'police' then
                    local plant = GetClosestPlant()
                    DrawText3D(v.x, v.y, v.z, 'Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '%')
                    DrawText3D(v.x, v.y, v.z - 0.18, 'Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality.. '%')
                    DrawText3D(v.x, v.y, v.z - 0.36, 'Destroy Plant [G]')
                    if IsControlJustPressed(0, RSGCore.Shared.Keybinds['G']) then
                        if v.id == plant.id then
                            DestroyPlant()
                        end
                    end
                else
                    if v.growth < 100 then
                        local plant = GetClosestPlant()
                        DrawText3D(v.x, v.y, v.z, 'Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '%')
                        DrawText3D(v.x, v.y, v.z - 0.18, 'Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality.. '%')
                        DrawText3D(v.x, v.y, v.z - 0.36, 'Water [G] : Feed [J]')
                        if IsControlJustPressed(0, RSGCore.Shared.Keybinds['G']) then
                            if v.id == plant.id then
                                TriggerEvent('rsg-indiantobacco:client:waterPlant')
                            end
                        elseif IsControlJustPressed(0, RSGCore.Shared.Keybinds['J']) then
                            if v.id == plant.id then
                                TriggerEvent('rsg-indiantobacco:client:feedPlant')
                            end
                        end
                    else
                        DrawText3D(v.x, v.y, v.z, '[Quality: ' .. v.quality .. ']')
                        DrawText3D(v.x, v.y, v.z - 0.18, 'Harvest [E]')
                        if IsControlJustReleased(0, RSGCore.Shared.Keybinds['E']) and canHarvest then
                            local plant = GetClosestPlant()
                            local callpolice = math.random(1,100)
                            if v.id == plant.id then
                                HarvestPlant()
                                if callpolice > 95 then
                                    local coords = GetEntityCoords(PlayerPedId())
                                    -- alert police action here
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

function GetClosestPlant()
    local dist = 1000
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local plant = {}
    for i = 1, #Config.Plants do
        local xd = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
        if xd < dist then
            dist = xd
            plant = Config.Plants[i]
        end
    end
    return plant
end

RegisterNetEvent('rsg-indiantobacco:client:removePlantObject')
AddEventHandler('rsg-indiantobacco:client:removePlantObject', function(plant)
    for i = 1, #SpawnedPlants do
        local o = SpawnedPlants[i]
        if o.id == plant then
            SetEntityAsMissionEntity(o.obj, false)
            FreezeEntityPosition(o.obj, false)
            DeleteObject(o.obj)
        end
    end
end)

-- water plants
RegisterNetEvent('rsg-indiantobacco:client:waterPlant')
AddEventHandler('rsg-indiantobacco:client:waterPlant', function()
    local entity = nil
    local plant = GetClosestPlant()
    local ped = PlayerPedId()
    isDoingAction = true
    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
    local hasItem = RSGCore.Functions.HasItem('water', 1)
    if hasItem then
        Citizen.InvokeNative(0x5AD23D40115353AC, ped, entity, -1)
        TaskStartScenarioInPlace(ped, `WORLD_HUMAN_BUCKET_POUR_LOW`, 0, true)
        Wait(10000)
        ClearPedTasks(ped)
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        TriggerServerEvent('rsg-indiantobacco:server:waterPlant', plant.id)
        isDoingAction = false
    else
        RSGCore.Functions.Notify('You don\'t have any water!', 'error')
        Wait(5000)
        isDoingAction = false
    end
end)

-- feed plants
RegisterNetEvent('rsg-indiantobacco:client:feedPlant')
AddEventHandler('rsg-indiantobacco:client:feedPlant', function()
    local entity = nil
    local plant = GetClosestPlant()
    local ped = PlayerPedId()
    isDoingAction = true
    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
    local hasItem = RSGCore.Functions.HasItem('fertilizer', 1)
    if hasItem then
        Citizen.InvokeNative(0x5AD23D40115353AC, ped, entity, -1)
        TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FEED_PIGS`, 0, true)
        Wait(14000)
        ClearPedTasks(ped)
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        TriggerServerEvent('rsg-indiantobacco:server:feedPlant', plant.id)
        isDoingAction = false
    else
        RSGCore.Functions.Notify('You don\'t have any fertilizer!', 'error')
        Wait(5000)
        isDoingAction = false
    end
end)

RegisterNetEvent('rsg-indiantobacco:client:updatePlantData')
AddEventHandler('rsg-indiantobacco:client:updatePlantData', function(data)
    Config.Plants = data
end)

RegisterNetEvent('rsg-indiantobacco:client:plantNewSeed')
AddEventHandler('rsg-indiantobacco:client:plantNewSeed', function(type)
    local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
    local ped = PlayerPedId()
    if CanPlantSeedHere(pos) and not IsPedInAnyVehicle(PlayerPedId(), false) then
        TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FARMER_RAKE`, 0, true)
        Wait(10000)
        ClearPedTasks(ped)
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FARMER_WEEDING`, 0, true)
        Wait(20000)
        ClearPedTasks(ped)
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        TriggerServerEvent('rsg-indiantobacco:server:plantNewSeed', type, pos)
    else
        RSGCore.Functions.Notify('too close to another plant!', 'error')
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.25, 0.25)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

function CanPlantSeedHere(pos)
    local canPlant = true

    for i = 1, #Config.Plants do
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true) < 1.3 then
            canPlant = false
        end
    end

    return canPlant
end

----------------------------------------------------------------------------------------------

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

RegisterNetEvent('rsg-indiantobacco:client:SmokeIndian')
AddEventHandler('rsg-indiantobacco:client:SmokeIndian', function()
    local dict = "amb_rest@world_human_smoke_cigar@male_a@idle_a"
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local prop = GetHashKey("P_CIGAR02X")
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
    AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.12, -0.03, -0.06, 0.0, 0.0, 200.0, true, true, false, true,  1, true)
    TaskPlayAnim(PlayerPedId(), dict, "idle_a", 1.0, 8.0, -1, 31, 0, false, false, false)
    Wait(30000)
    ClearPedTasks(PlayerPedId())
    DeleteObject(tempObj2)
    SetModelAsNoLongerNeeded(prop)
    TriggerServerEvent('rsg-indiantobacco:server:removeitem', 'indiancigar', 1)
    -- fill up cores
    Citizen.InvokeNative(0xC6258F41D86676E0, playerPed, 0, 100) -- ATTRIBUTE_CORE_HEALTH
    Citizen.InvokeNative(0xC6258F41D86676E0, playerPed, 1, 100) -- ATTRIBUTE_CORE_STAMINA
    EnableAttributeOverpower(playerPed, 0, 900.0) -- 3x
    EnableAttributeOverpower(playerPed, 1, 900.0) -- 3x
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 0, 900.0) -- ATTRIBUTE_CORE_HEALTH
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 1, 900.0) -- ATTRIBUTE_CORE_STAMINA
    -- play core fillup sound
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
    -- do drug effect (optional true or false)
    if Config.DrugEffect == true then
        AnimpostfxPlay("MP_MoonshineToxic") -- start screen effect
        Wait(Config.DrugEffectTime) -- drug effect time
        AnimpostfxStop("MP_MoonshineToxic") -- stop screen effect
    end
end)
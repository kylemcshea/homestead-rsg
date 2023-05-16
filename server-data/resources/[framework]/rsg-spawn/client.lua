local camZPlus1 = 1500
local camZPlus2 = 50
local pointCamCoords = 75
local pointCamCoords2 = 0
local cam1Time = 500
local cam2Time = 1000
local choosingSpawn = false
local newPlayer = false
local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-spawn:client:openUI', function(value)
    SetEntityVisible(PlayerPedId(), false)
    DoScreenFadeOut(250)
    Wait(1000)
    DoScreenFadeIn(250)
    RSGCore.Functions.GetPlayerData(function(PlayerData)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + camZPlus1, -85.00, 0.00, 0.00, 100.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    end)
    Wait(500)
    SetDisplay(value)
end)

RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        status = false
    })
    choosingSpawn = false
end)

local cam = nil
local cam2 = nil

RegisterNUICallback('setCam', function(data)
    local location = tostring(data.posname)
    local type = tostring(data.type)

    DoScreenFadeOut(200)
    Wait(500)
    DoScreenFadeIn(200)

    if DoesCamExist(cam) then
        DestroyCam(cam, true)
    end

    if DoesCamExist(cam2) then
        DestroyCam(cam2, true)
    end

    if type == "current" then
        RSGCore.Functions.GetPlayerData(function(PlayerData)
            cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
            PointCamAtCoord(cam2, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + pointCamCoords)
            SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
            if DoesCamExist(cam) then
                DestroyCam(cam, true)
            end
            Wait(cam1Time)

            cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
            PointCamAtCoord(cam, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + pointCamCoords2)
            SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
            SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
            TriggerServerEvent("rsg-appearance:LoadSkin")
        end)
    elseif type == "house" then
        local campos = Config.Houses[location].coords.enter

        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam2, campos.x, campos.y, campos.z + pointCamCoords)
        SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
        Wait(cam1Time)

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam, campos.x, campos.y, campos.z + pointCamCoords2)
        SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
        SetEntityCoords(PlayerPedId(), campos.x, campos.y, campos.z)
        TriggerServerEvent("rsg-appearance:LoadSkin")
    elseif type == "normal" then
        local campos = RSG.Spawns[location].coords

        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam2, campos.x, campos.y, campos.z + pointCamCoords)
        SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
        Wait(cam1Time)

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam, campos.x, campos.y, campos.z + pointCamCoords2)
        SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
        SetEntityCoords(PlayerPedId(), campos.x, campos.y, campos.z)
        TriggerServerEvent("rsg-appearance:LoadSkin")
    elseif type == "appartment" then
        local campos = Apartments.Locations[location].coords.enter

        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam2, campos.x, campos.y, campos.z + pointCamCoords)
        SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
        Wait(cam1Time)

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam, campos.x, campos.y, campos.z + pointCamCoords2)
        SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
        SetEntityCoords(PlayerPedId(), campos.x, campos.y, campos.z)
        TriggerServerEvent("rsg-appearance:LoadSkin")
    end
end)

RegisterNUICallback('chooseApartment', function(data)
    local appaYeet = data.appType
    SetDisplay(false)
    DoScreenFadeOut(500)
    Wait(5000)
    TriggerServerEvent("apartments:server:CreateApartment", appaYeet, Apartments.Locations[appaYeet].label)
    TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
    TriggerEvent('RSGCore:Client:OnPlayerLoaded')
    FreezeEntityPosition(ped, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(PlayerPedId(), true)
    TriggerServerEvent("rsg-appearance:LoadSkin")
end)

RegisterNUICallback('spawnplayer', function(data)
    local location = tostring(data.spawnloc)
    local type = tostring(data.typeLoc)
    local ped = PlayerPedId()
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local insideMeta = PlayerData.metadata['inside']
    local isJailed = PlayerData.metadata["injail"]
    if type == "current" then
        SetDisplay(false)
        DoScreenFadeOut(500)
        Wait(2000)
        SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
        SetEntityHeading(PlayerPedId(), PlayerData.position.w)
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
        TriggerEvent('RSGCore:Client:OnPlayerLoaded')
        FreezeEntityPosition(ped, false)
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
        SetEntityVisible(PlayerPedId(), true)
        Wait(500)
        DoScreenFadeIn(250)
        TriggerServerEvent("rsg-appearance:LoadSkin")
    elseif type == "house" then
        SetDisplay(false)
        DoScreenFadeOut(500)
        Wait(2000)
        TriggerEvent('rsg-houses:client:enterOwnedHouse', location)
        TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
        TriggerEvent('RSGCore:Client:OnPlayerLoaded')
        TriggerServerEvent('rsg-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('rsg-apartments:server:SetInsideMeta', 0, 0, false)
        FreezeEntityPosition(ped, false)
        FreezeEntityPosition(PlayerPedId(), false)
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
        SetEntityVisible(PlayerPedId(), true)
        Wait(500)
        DoScreenFadeIn(250)
        TriggerServerEvent("rsg-appearance:LoadSkin")
    elseif type == "normal" then
        local pos = RSG.Spawns[location].coords
        SetDisplay(false)
        DoScreenFadeOut(500)
        Wait(2000)
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
        TriggerEvent('RSGCore:Client:OnPlayerLoaded')
        TriggerServerEvent('rsg-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('rsg-apartments:server:SetInsideMeta', 0, 0, false)
        Wait(500)
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        SetEntityHeading(ped, pos.h)
        FreezeEntityPosition(ped, false)
        FreezeEntityPosition(PlayerPedId(), false)
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
        SetEntityVisible(PlayerPedId(), true)
        Wait(500)
        DoScreenFadeIn(250)
        TriggerServerEvent("rsg-appearance:LoadSkin")
    end

    if newPlayer then
        TriggerServerEvent("rsg-clothes:LoadClothes", 2)
        newPlayer = false
    end
    
    if isJailed > 0 then
        Wait(2000)
        TriggerEvent('rsg-prison:client:prisonclothes')
    end

    TriggerEvent('rsg-houses:client:BlipsOnSpawn')

    if RSG.AutoDualWield then
        Wait(2000)

        TriggerEvent('rsg-weapons:client:AutoDualWield')
    end
end)

function SetDisplay(bool)
    choosingSpawn = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool
    })
end

CreateThread(function()
    while true do
        if choosingSpawn then
            DisableAllControlActions(0)
        else
            Wait(1000)
        end
        Wait(0)
    end
end)

RegisterNetEvent('rsg-spawn:client:SpawnOnLastLocationOnly', function()
    local ped = PlayerPedId()
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local isJailed = PlayerData.metadata["injail"]

    SetDisplay(false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
    SetEntityHeading(PlayerPedId(), PlayerData.position.w)
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
    TriggerEvent('RSGCore:Client:OnPlayerLoaded')
    FreezeEntityPosition(ped, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
    TriggerServerEvent("rsg-appearance:LoadSkin")

    if isJailed > 0 then
        Wait(2000)
        TriggerEvent('rsg-prison:client:prisonclothes')
    end

    TriggerEvent('rsg-houses:client:BlipsOnSpawn')

    if RSG.AutoDualWield then
        Wait(2000)

        TriggerEvent('rsg-weapons:client:AutoDualWield')
    end
end)

RegisterNetEvent('rsg-houses:client:setHouseConfig', function(houseConfig)
    Config.Houses = houseConfig
end)

RegisterNetEvent('rsg-spawn:client:setupSpawnUI', function(cData, new)
    if not new and RSG.SpawnOnLastLocationOnly then
        TriggerEvent('rsg-spawn:client:SpawnOnLastLocationOnly')
        return
    end

    if not RSG.EnableApartments then
        TriggerEvent('rsg-spawn:client:setupSpawns', cData, new, nil)
        TriggerEvent('rsg-spawn:client:openUI', true)
        return
    end

    RSGCore.Functions.TriggerCallback('apartments:GetOwnedApartment', function(result)
        if result == nil then
            TriggerEvent('rsg-spawn:client:setupSpawns', cData, true, Apartments.Locations)
            TriggerEvent('rsg-spawn:client:openUI', true)
            return
        end

        TriggerEvent('rsg-spawn:client:setupSpawns', cData, false, nil)
        TriggerEvent('rsg-spawn:client:openUI', true)
        TriggerEvent("apartments:client:SetHomeBlip", result.type)
    end, cData.citizenid)
end)

RegisterNetEvent('rsg-spawn:client:setupSpawns', function(cData, new, apps)
    newPlayer = new
    if not new then
        if RSG.EnableHouses then
            RSGCore.Functions.TriggerCallback('rsg-spawn:server:getOwnedHouses', function(houses)
                local myHouses = {}
                if houses ~= nil then
                    for i = 1, (#houses), 1 do
                        table.insert(myHouses, {
                            house = houses[i].house,
                            label = Config.Houses[houses[i].house].adress,
                        })
                    end
                end

                Wait(500)
                SendNUIMessage({
                    action = "setupLocations",
                    locations = RSG.Spawns,
                    houses = myHouses,
                })
            end, cData.citizenid)
        else
            SendNUIMessage({
                action = "setupLocations",
                locations = RSG.Spawns,
                houses = {},
            })
        end
    elseif new and RSG.EnableApartments then
        SendNUIMessage({
            action = "setupAppartements",
            locations = apps,
        })
    else
        SendNUIMessage({
            action = "setupnewplayerLocations",
            locations = RSG.Spawns,
            houses = {},
        })
    end
end)

-----------------
-- DEV TOOLING --
-----------------

local IS_DEV_MODE = true

if (IS_DEV_MODE) then
    local mockData = {
        id = 144,
        position = {x = 1416.5933837890626, y = 266.980224609375, z = 89.6527099609375},
        metadata = {
        bloodtype = "B-",
        fitbit = {},
        hunger = 66.39999999999998,
        stress = 0,
        walletid = "rsg-23130964",
        armor = 0,
        dealerrep = 0,
        licences = {weapon = false},
        tracker = false,
        levels = {mining = 0, crafting = 0, cooking = 0, herbalism = 0, main = 0},
        injail = 0,
        callsign = "NO CALLSIGN",
        inside = {apartment = {}},
        thirst = 54.40000000000003,
        attachmentcraftingrep = 0,
        commandbinds = {},
        house = "none",
        health = 550,
        ishandcuffed = false,
        jobrep = {trucker = 0, hotdog = 0, tow = 0, taxi = 0},
        fingerprint = "BB682R72MOI5423",
        xp = {mining = 0, crafting = 0, cooking = 0, herbalism = 0, main = 0},
        inlaststand = false,
        phone = {},
        craftingrep = 0,
        status = {},
        isdead = false,
        criminalrecord = {hasRecord = false},
        jailitems = {}
        },
        gang = {
        isboss = false,
        grade = {level = 0, name = "none"},
        name = "none",
        label = "No Gang Affiliaton"
        },
        job = {
        label = "Civilian",
        type = "none",
        isboss = false,
        grade = {level = 0, name = "Freelancer"},
        name = "unemployed",
        payment = 10,
        onduty = true
        },
        last_updated = 1684271398000,
        citizenid = "XPM93928",
        charinfo = {
        phone = "3777794588",
        lastname = "jenkins",
        nationality = "mexico",
        birthdate = "1800-01-01",
        firstname = "kale",
        account = "RSG36308560325",
        backstory = "placeholder backstory",
        gender = "undefined",
        cid = "1"
        },
        license = "license:46ca2ee691979f22f88bf78660ad25d4e6e3b923",
        inventory = {
        {name = "bread", info = {quality = 100}, slot = 1, type = "item", amount = 3},
        {name = "water", info = {quality = 100}, slot = 2, type = "item", amount = 4}
        },
        name = "broski i really dooby high af fr",
        money = {cash = 432, bloodmoney = 0, bank = 5070},
        cid = 1
    }

    RegisterCommand("showspawn", function()
        TriggerEvent('rsg-spawn:client:setupSpawnUI', mockData, false)
    end)
end
local RSGCore = exports['rsg-core']:GetCoreObject()
local miningstarted = false
local mining
local testAnimDict = 'amb_work@world_human_pickaxe@wall@male_d@base'
local testAnim = 'base'

local LoadAnimDict = function(dict)
    local isLoaded = HasAnimDictLoaded(dict)

    while not isLoaded do
        RequestAnimDict(dict)
        Wait(5)
        isLoaded = not isLoaded
    end
end

--------------------------------------------------------------------------

-- mining locations
Citizen.CreateThread(function()
    for mining, v in pairs(Config.MiningLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], Lang:t('menu.start') .. v.name, {
            type = 'client',
            event = 'rsg-mining:client:StartMining',
        })
        if v.showblip == true then
            local MiningBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(MiningBlip, GetHashKey("blip_ambient_tracking"), 1)
            SetBlipScale(MiningBlip, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, MiningBlip, v.name)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        local sleep = 0
        for mining, v in pairs(Config.MiningLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

--------------------------------------------------------------------------

-- start mining
RegisterNetEvent('rsg-mining:client:StartMining')
AddEventHandler('rsg-mining:client:StartMining', function()
    local player = PlayerPedId()
    local hasItem = RSGCore.Functions.HasItem('pickaxe', 1)
    if miningstarted == false then
        if hasItem then
            local randomNumber = math.random(1,100)
            if randomNumber > 90 then -- 10% chance of pickace breaking
                TriggerServerEvent('rsg-mining:server:removeitem', 'pickaxe')
            else
                local coords = GetEntityCoords(player)
                local boneIndex = GetEntityBoneIndexByName(player, "SKEL_R_Finger00")
                local prop = CreateObject(GetHashKey("p_pickaxe01x"), coords, true, true, true)
                miningstarted = true

                SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
                FreezeEntityPosition(player, true)
                ClearPedTasksImmediately(player)
                AttachEntityToEntity(prop, player, boneIndex, -0.35, -0.21, -0.39, -8.0, 47.0, 11.0, true, false, true, false, 0, true)

                TriggerEvent('rsg-mining:client:MiningAnimation')

                RSGCore.Functions.Progressbar("mining", "Mining...", 18000, false, true,
                {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    ClearPedTasksImmediately(player)
                    FreezeEntityPosition(player, false)

                    TriggerServerEvent('rsg-mining:server:giveMiningReward')

                    SetEntityAsNoLongerNeeded(prop)
                    DeleteEntity(prop)
                    DeleteObject(prop)

                    miningstarted = false
                end)
            end
        else
            RSGCore.Functions.Notify(Lang:t('error.you_dont_have_pickaxe'), 'error')
        end
    else
        RSGCore.Functions.Notify(Lang:t('primary.you_are_busy_the_moment'), 'primary')
    end
end)

AddEventHandler('rsg-mining:client:MiningAnimation', function()
    local ped = PlayerPedId()

    LoadAnimDict(testAnimDict)

    Wait(100)

    TaskPlayAnim(ped, testAnimDict, testAnim, 3.0, 3.0, -1, 1, 0, false, false, false)
end)
local RSGCore = exports['rsg-core']:GetCoreObject()
local isLoggedIn = false
local PlayerData = {}
local carthash
local spawncoords
local cargohash
local lightupgardehash
local maxweight
local maxslots
local SpawnedWagon = nil
local wagonSpawned = false

-----------------------------------------------------------------------------------

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function() -- Don't use this with the native method
    isLoggedIn = true
    PlayerData = RSGCore.Functions.GetPlayerData()
    TriggerEvent('rsg-jobwagon:client:setupjobsystem')
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function() -- Don't use this with the native method
    isLoggedIn = false
    PlayerData = {}
end)

RegisterNetEvent('RSGCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    TriggerEvent('rsg-jobwagon:client:setupjobsystem')
end)

-----------------------------------------------------------------------------------

-- setup job system
RegisterNetEvent('rsg-jobwagon:client:setupjobsystem', function()
    local job = PlayerData.job.name
    for k, v in pairs(Config.JobsSettings) do
        if k == job then
            carthash = v.carthash
            spawncoords = v.spawncoords
            cargohash = v.cargohash
            lightupgardehash = v.lightupgardehash
            maxweight = v.maxweight
            maxslots = v.maxslots
        end
    end
end)

-----------------------------------------------------------------------------------

-- job wagon menu
RegisterNetEvent('rsg-jobwagon:client:openWagonMenu', function()
    exports['rsg-menu']:openMenu({
        {
            header = Lang:t('menu.wagon_menu'),
            isMenuHeader = true,
        },
        {
            header = Lang:t('menu.wagon_setup'),
            txt = "",
            icon = "fas fa-box",
            params = {
                event = 'rsg-jobwagon:server:SetupWagon',
                isServer = true,
                args = {},
            }
        },
        {
            header = Lang:t('menu.wagon_get'),
            txt = "",
            icon = "fas fa-box",
            params = {
                event = 'rsg-jobwagon:client:SpawnWagon',
                isServer = false,
                args = {},
            }
        },
        {
            header = Lang:t('menu.wagon_store'),
            txt = "",
            icon = "fas fa-box",
            params = {
                event = 'rsg-jobwagon:client:storewagon',
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
end)

-- spawn company wagon
RegisterNetEvent('rsg-jobwagon:client:SpawnWagon', function()
    RSGCore.Functions.TriggerCallback('rsg-jobwagon:server:GetActiveWagon', function(data)
        if data ~= nil then
            if wagonSpawned == false then
                local ped = PlayerPedId()
                local playerjob = RSGCore.Functions.GetPlayerData().job.name
                local plate = data.plate
                RequestModel(carthash)
                while not HasModelLoaded(carthash) do
                    Citizen.Wait(0)
                end
                local wagon = CreateVehicle(carthash, spawncoords, true, false)
                SetVehicleOnGroundProperly(wagon)
                Wait(200)
                SetPedIntoVehicle(ped, wagon, -1)
                SetModelAsNoLongerNeeded(carthash)
                Citizen.InvokeNative(0xD80FAF919A2E56EA, wagon, cargohash)
                Citizen.InvokeNative(0xC0F0417A90402742, wagon, lightupgardehash) 
                SpawnedWagon = wagon
                wagonSpawned = true
                RSGCore.Functions.Notify(Lang:t('primary.wagon_out'), 'primary')
            else
                RSGCore.Functions.Notify(Lang:t('primary.wagon_already_out'), 'primary')
            end
        else
            RSGCore.Functions.Notify(Lang:t('error.no_wagon_setup'), 'error')
        end
    end)
end)

-- open wagon menu
CreateThread(function()
    while true do
        Wait(1)
        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, RSGCore.Shared.Keybinds['B']) then -- IsDisabledControlJustPressed
            local playercoords = GetEntityCoords(PlayerPedId())
            local wagoncoords = GetEntityCoords(SpawnedWagon)
            if #(playercoords - wagoncoords) <= 2.0 then
                RSGCore.Functions.TriggerCallback('rsg-jobwagon:server:GetActiveWagon', function(data)
                    local wagonstash = data.plate
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", wagonstash, { maxweight = Config.MaxWeight, slots = Config.MaxSlots, })
                    TriggerEvent("inventory:client:SetCurrentStash", wagonstash)
                end)
            end
        end
    end
end)

-- store wagon
RegisterNetEvent('rsg-jobwagon:client:storewagon', function()
    if wagonSpawned == true then
        DeleteVehicle(SpawnedWagon)
        SetEntityAsNoLongerNeeded(SpawnedWagon)
        RSGCore.Functions.Notify(Lang:t('success.wagon_stored'), 'success')
        wagonSpawned = false
    end
end)

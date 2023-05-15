local RSGCore = exports['rsg-core']:GetCoreObject()

local scoreboardOpen = false
local PlayerOptin = {}

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded')
AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    RSGCore.Functions.TriggerCallback('rsg-scoreboard:server:GetConfig', function(config) Config.IllegalActions = config end)
end)

RegisterNetEvent('rsg-scoreboard:client:SetActivityBusy')
AddEventHandler('rsg-scoreboard:client:SetActivityBusy', function(activity, busy)
    Config.IllegalActions[activity].busy = busy
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, RSGCore.Shared.Keybinds['PGDN']) and IsInputDisabled(0) then -- PAGEDOWN
            if not scoreboardOpen then
                RSGCore.Functions.TriggerCallback('rsg-scoreboard:server:GetPlayersArrays', function(playerList)
                    RSGCore.Functions.TriggerCallback('rsg-scoreboard:server:GetActivity', function(police, medic)
                        RSGCore.Functions.TriggerCallback("rsg-scoreboard:server:GetCurrentPlayers", function(Players)
                            PlayerOptin = playerList
                            if Config.Debug == true then
                                print('current police '..police)
                                print('current medic '..medic)
                            end
                            SendNUIMessage({
                                action = "open",
                                players = Players,
                                maxPlayers = Config.MaxPlayers,
                                requiredPolice = Config.IllegalActions,
                                currentPolice = police,
                                currentMedic = medic
                            })
                            scoreboardOpen = true
                        end)
                    end)
                end)
            else
                SendNUIMessage({action = "close"})
                scoreboardOpen = false
            end
            if scoreboardOpen then
                for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0)) do
                    local PlayerId = GetPlayerServerId(player)
                    local PlayerPed = GetPlayerPed(player)
                    local PlayerName = GetPlayerName(player)
                    local PlayerCoords = GetEntityCoords(PlayerPed)
                    if not PlayerOptin[PlayerId].permission then
                        DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 1.0, '[' .. PlayerId .. ']')
                    end
                end
            end
        end
    end
end)

-- Functions

DrawText3D = function(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

GetPlayersFromCoords = function(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}

    if coords == nil then coords = GetEntityCoords(PlayerPedId()) end
    if distance == nil then distance = 5.0 end
    for _, player in pairs(players) do
        local target = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(target)
        local targetdistance = #(targetCoords - vector3(coords.x, coords.y, coords.z))
        if targetdistance <= distance then
            table.insert(closePlayers, player)
        end
    end

    return closePlayers
end

GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then table.insert(players, player) end
    end
    return players
end

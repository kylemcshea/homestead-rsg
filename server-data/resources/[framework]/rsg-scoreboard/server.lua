local RSGCore = exports['rsg-core']:GetCoreObject()

RSGCore.Functions.CreateCallback('rsg-scoreboard:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(RSGCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

RSGCore.Functions.CreateCallback('rsg-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local MedicCount = 0

    for k, v in pairs(RSGCore.Functions.GetPlayers()) do
        local Player = RSGCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                PoliceCount = PoliceCount + 1
            end

            if (Player.PlayerData.job.name == "medic" and Player.PlayerData.job.onduty) then
                MedicCount = MedicCount + 1
            end
        end
    end

    cb(PoliceCount, MedicCount)
end)

RSGCore.Functions.CreateCallback('rsg-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

RSGCore.Functions.CreateCallback('rsg-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(RSGCore.Functions.GetPlayers()) do
        local Player = RSGCore.Functions.GetPlayer(v)
        if Player ~= nil then
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = RSGCore.Functions.IsOptin(Player.PlayerData.source)
        end
    end
    cb(players)
end)

RegisterServerEvent('rsg-scoreboard:server:SetActivityBusy')
AddEventHandler('rsg-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('rsg-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

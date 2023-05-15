local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-delivery:server:givereward', function(cashreward)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash',cashreward)
end)
local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-cityhall:server:ApplyJob', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local ped = GetPlayerPed(src)
    Player.Functions.SetJob(data.job, 0)
    TriggerClientEvent('RSGCore:Notify', src, 'Your new job is '..data.lable)
end)

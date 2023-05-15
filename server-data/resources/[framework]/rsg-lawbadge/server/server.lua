local RSGCore = exports['rsg-core']:GetCoreObject()

RSGCore.Commands.Add("lawbadge", 'put on / take off badge', {}, false, function(source, args)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == Config.LawJob and Player.PlayerData.job.onduty then
        TriggerClientEvent("rsg-lawbadge:client:lawbadge", src)
    else
        TriggerClientEvent('RSGCore:Notify', src, 'you must be on duty to wear your badge', 'error')
    end
end)

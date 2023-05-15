local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('rsg-butcher:server:reward')
AddEventHandler('rsg-butcher:server:reward', function(rewardmoney, rewarditem, quality)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Config.Debug == true then
        print("money: "..tostring(rewardmoney))
        print("item: "..tostring(rewarditem))
        print("quality: "..tostring(quality))
    end
    if quality == 'poor' then
        Player.Functions.AddMoney('cash', rewardmoney * Config.PoorMultiplier)
        Player.Functions.AddItem(rewarditem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem], "add")
    end
    if quality == 'good' then
        Player.Functions.AddMoney('cash', rewardmoney * Config.GoodMultiplier)
        Player.Functions.AddItem(rewarditem, 2)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem], "add")
    end
    if quality == 'perfect' then
        Player.Functions.AddMoney('cash', rewardmoney * Config.PerfectMultiplier)
        Player.Functions.AddItem(rewarditem, 3)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem], "add")
    end
end)
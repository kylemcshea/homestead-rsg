local RSGCore = exports['rsg-core']:GetCoreObject()

-- give mining reward
RegisterServerEvent('rsg-mining:server:giveMiningReward')
AddEventHandler('rsg-mining:server:giveMiningReward', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local chance = math.random(1,100)
    if chance <= 50 then
        local item1 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        local item2 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        local item3 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        -- add items
        Player.Functions.AddItem(item1, Config.SmallRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
        Player.Functions.AddItem(item2, Config.SmallRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")
        Player.Functions.AddItem(item3, Config.SmallRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item3], "add")
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.small_haul_time'), 'primary')
    elseif chance >= 50 and chance <= 80 then -- medium reward
        local item1 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        local item2 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        local item3 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        -- add items
        Player.Functions.AddItem(item1, Config.MediumRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
        Player.Functions.AddItem(item2, Config.MediumRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")
        Player.Functions.AddItem(item3, Config.MediumRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item3], "add")
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.medium_haul_this_time'), 'primary')
    elseif chance > 80 then -- large reward
        local item1 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        local item2 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        local item3 = Config.MiningRewards[math.random(1, #Config.MiningRewards)]
        -- add items
        Player.Functions.AddItem(item1, Config.LargeRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
        Player.Functions.AddItem(item2, Config.LargeRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")
        Player.Functions.AddItem(item3, Config.LargeRewardAmount)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item3], "add")
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.largq_haul_this_time'), 'primary')
    end
end)

-- remove pickaxe if broken
RegisterServerEvent('rsg-mining:server:removeitem')
AddEventHandler('rsg-mining:server:removeitem', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if item == 'pickaxe' then
        Player.Functions.RemoveItem('pickaxe', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pickaxe'], "add")
        RSGCore.Functions.Notify(src, Lang:t('success.your_pickaxe_broke'), 'success')
    else
        RSGCore.Functions.Notify(src, Lang:t('error.something_went_wrong'), 'error')
        print('something went wrong with moonshine script could be exploint!')
    end
end)

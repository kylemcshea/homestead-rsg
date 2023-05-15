local RSGCore = exports['rsg-core']:GetCoreObject()

-- sell blood money
RegisterServerEvent('rsg-outlawpost:server:sellbloodmoney')
AddEventHandler('rsg-outlawpost:server:sellbloodmoney', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    local amountbloodmoney = Player.Functions.GetMoney('bloodmoney')
    if amountbloodmoney ~= nil then
        if amountbloodmoney >= amount then
            bloodmoneyprice = Config.BloodMoneyPrice
            totalcash = (amount * bloodmoneyprice)
            Player.Functions.RemoveMoney('bloodmoney', amount)
            Player.Functions.AddMoney('cash', totalcash)
            TriggerClientEvent('RSGCore:Notify', src, 'You sold ' ..amount.. ' blood money for $'..totalcash, 'success')
        else
            TriggerClientEvent('RSGCore:Notify', src, 'You do not have enough blood money to do that!', 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, 'You do not have any blood money!', 'error')
    end
end)

-- sell gold bars
RegisterServerEvent('rsg-outlawpost:server:sellgoldbars')
AddEventHandler('rsg-outlawpost:server:sellgoldbars', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    local checkbars = Player.Functions.GetItemByName("goldbar")
    if checkbars ~= nil then
        local amountbars = Player.Functions.GetItemByName('goldbar').amount
        if amountbars >= amount then
            goldbarprice = Config.GoldBarPrice
            totalcash = (amount * goldbarprice) 
            Player.Functions.RemoveItem('goldbar', amount)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['goldbar'], "remove")
            Player.Functions.AddMoney('cash', totalcash)
            TriggerClientEvent('RSGCore:Notify', src, 'You sold ' ..amount.. ' gold bars for $'..totalcash, 'success')
        else
            TriggerClientEvent('RSGCore:Notify', src, 'You do not have enough gold bars to do that!', 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, 'You do not have any gold bars!', 'error')
    end
end)

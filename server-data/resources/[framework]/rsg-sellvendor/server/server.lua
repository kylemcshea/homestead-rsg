local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('rsg-sellvendor:server:sellitem')
AddEventHandler('rsg-sellvendor:server:sellitem', function(amount, data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    local checkitem = Player.Functions.GetItemByName(data.item)
    if amount >= 0 then
        if checkitem ~= nil then
            local amountitem = Player.Functions.GetItemByName(data.item).amount
            if amountitem >= amount then
                totalcash = (amount * data.price) 
                Player.Functions.RemoveItem(data.item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[data.item], "remove")
                Player.Functions.AddMoney('cash', totalcash)
                TriggerClientEvent('RSGCore:Notify', src, 'You sold ' ..amount.. ' for  $'..totalcash, 'success')
            else
                TriggerClientEvent('RSGCore:Notify', src, 'You don\'t have that much on you.', 'error')
            end
        else
            TriggerClientEvent('RSGCore:Notify', src, 'You don\'t have an item on you', 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, 'must not be a negative value.', 'error')
    end
end)

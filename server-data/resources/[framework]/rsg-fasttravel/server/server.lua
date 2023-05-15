local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('rsg-fasttravel:server:buyTicket')
AddEventHandler('rsg-fasttravel:server:buyTicket', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local destination = data.destination
    local price = data.price
    local cashBalance = Player.PlayerData.money["cash"]
    if cashBalance >= price then
        Player.Functions.RemoveMoney("cash", price, "purchase-fasttravel")
        TriggerClientEvent('rsg-fasttravel:client:doTravel', src, destination)
    else 
        RSGCore.Functions.Notify(src, Lang:t('error.no_cash'), 'error')
    end
end)

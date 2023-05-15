local RSGCore = exports['rsg-core']:GetCoreObject()
local ResetStress = false

RSGCore.Commands.Add('cash', 'Check Cash Balance', {}, false, function(source, args)
    local Player = RSGCore.Functions.GetPlayer(source)
    local cashamount = Player.PlayerData.money.cash
    if cashamount ~= nil then
        TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
    else
        return
    end
end)

RSGCore.Commands.Add('bank', 'Check Bank Balance', {}, false, function(source, args)
    local Player = RSGCore.Functions.GetPlayer(source)
    local bankamount = Player.PlayerData.money.bank
    if bankamount ~= nil then
        TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
    else
        return
    end
end)

RSGCore.Commands.Add('bloodmoney', 'Check Bloodmoney Balance', {}, false, function(source, args)
    local Player = RSGCore.Functions.GetPlayer(source)
    local bloodmoneyamount = Player.PlayerData.money.bloodmoney
    if bloodmoneyamount ~= nil then
        TriggerClientEvent('hud:client:ShowAccounts', source, 'bloodmoney', bloodmoneyamount)
    else
        return
    end
end)

RegisterNetEvent('hud:server:GainStress', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil and Player.PlayerData.job.name ~= 'police' then
        if not ResetStress then
            if Player.PlayerData.metadata['stress'] == nil then
                Player.PlayerData.metadata['stress'] = 0
            end
            newStress = Player.PlayerData.metadata['stress'] + amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData('stress', newStress)
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("info.getstress"), 'primary')
    end
end)

RegisterNetEvent('hud:server:GainThirst', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local newThirst
    if Player ~= nil then
            if Player.PlayerData.metadata['thirst'] == nil then
                Player.PlayerData.metadata['thirst'] = 0
            end
            local thirst = Player.PlayerData.metadata['thirst']
            if newThirst <= 0 then
                newThirst = 0
            end
            if newThirst > 100 then
                newThirst = 100
            end
        Player.Functions.SetMetaData('thirst', newThirst)
        TriggerClientEvent('hud:client:UpdateThirst', src, newThirst)
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("info.thirsty"), 'primary')
    end
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata['stress'] == nil then
                Player.PlayerData.metadata['stress'] = 0
            end
            newStress = Player.PlayerData.metadata['stress'] - amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData('stress', newStress)
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("info.relaxing"), 'primary')
    end
end)

-- count telegrams for player
RSGCore.Functions.CreateCallback('hud:server:getTelegramsAmount', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local result = MySQL.prepare.await('SELECT COUNT(*) FROM telegrams WHERE citizenid = ? AND (status = ? OR birdstatus = ?)', {Player.PlayerData.citizenid, 0, 0})
    if result > 0 then
        cb(result)
    else
        cb(0)
    end
end)

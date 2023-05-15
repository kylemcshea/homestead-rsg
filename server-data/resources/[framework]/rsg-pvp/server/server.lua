local RSGCore = exports['rsg-core']:GetCoreObject()

RSGCore.Commands.Add("pvp", Lang:t('commands.toggle_pvp'), {}, false, function(source)
    local src = source
    TriggerClientEvent('rsg-pvp:client:pvpToggle', src)
end)

local RSGCore = exports['rsg-core']:GetCoreObject()

RSGCore.Commands.Add('bandana', 'Bandana on/off', {}, false, function(source)
    local src = source
    TriggerClientEvent('rsg-bandana:client:ToggleBandana', src)
end)

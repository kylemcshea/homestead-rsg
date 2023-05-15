local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('KickForAFK', function()
    DropPlayer(source, 'You Have Been Kicked For Being AFK')
end)

RSGCore.Functions.CreateCallback('rsg-afkkick:server:GetPermissions', function(source, cb)
    cb(RSGCore.Functions.GetPermission(source))
end)

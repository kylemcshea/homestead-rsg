local RSGCore = exports['rsg-core']:GetCoreObject()

-- use canoe
RSGCore.Functions.CreateUseableItem("canoe", function(source, item)
    local src = source
    TriggerClientEvent('rsg-canoe:client:lauchcanoe', src, item.name)
end)

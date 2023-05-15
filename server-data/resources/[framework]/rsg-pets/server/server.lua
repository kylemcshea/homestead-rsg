local RSGCore = exports['rsg-core']:GetCoreObject()

-- foxhound
RSGCore.Functions.CreateUseableItem("foxhound", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callfoxhound", source, item.name)
end)

-- sheperd
RSGCore.Functions.CreateUseableItem("sheperd", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callsheperd", source, item.name)
end)

-- coonhound
RSGCore.Functions.CreateUseableItem("coonhound", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callcoonhound", source, item.name)
end)

-- catahoulacur
RSGCore.Functions.CreateUseableItem("catahoulacur", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callcatahoulacur", source, item.name)
end)

-- bayretriever
RSGCore.Functions.CreateUseableItem("bayretriever", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callbayretriever", source, item.name)
end)

-- collie
RSGCore.Functions.CreateUseableItem("collie", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callcollie", source, item.name)
end)

-- hound
RSGCore.Functions.CreateUseableItem("hound", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callhound", source, item.name)
end)

-- husky
RSGCore.Functions.CreateUseableItem("husky", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callhusky", source, item.name)
end)

-- lab
RSGCore.Functions.CreateUseableItem("lab", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:calllab", source, item.name)
end)

-- poodle
RSGCore.Functions.CreateUseableItem("poodle", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callpoodle", source, item.name)
end)

-- street
RSGCore.Functions.CreateUseableItem("street", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-pets:client:callstreet", source, item.name)
end)
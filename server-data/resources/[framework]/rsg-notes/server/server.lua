local RSGCore = exports['rsg-core']:GetCoreObject()

local Notes = {}

RSGCore.Functions.CreateUseableItem("notepad", function(source, _)
    TriggerClientEvent("rsg-notes:client:CreateNote", source)
end)

RSGCore.Functions.CreateCallback('rsg-notes:server:SyncNotes', function(_, cb)
    cb(Notes)
end)

RegisterNetEvent("rsg-notes:server:CreateNote", function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local fullname = firstname..' '..lastname
    local rnd = math.random
    local charset =
    {
        "q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m",
        "Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M",
        "1","2","3","4","5","6","7","8","9","0"
    }

    local GeneratedID = ""

    for i = 1, 12 do GeneratedID = GeneratedID..charset[rnd(1, #charset)] end

    Notes[GeneratedID] =
    {
        id      = GeneratedID,
        coords  = data.coords,
        creator = fullname,
        message = data.message
    }

    TriggerClientEvent("rsg-notes:client:SyncNotes", -1, Notes)
end)

RegisterNetEvent("rsg-notes:server:DestroyNote", function(data)
    Notes[data] = nil

    TriggerClientEvent("rsg-notes:client:SyncNotes", -1, Notes)
end)

RegisterNetEvent("rsg-notes:server:ReadNote", function(data)
    local src = source

    TriggerClientEvent("rsg-notes:client:ReadNote", src, Notes[data.noteid])
end)
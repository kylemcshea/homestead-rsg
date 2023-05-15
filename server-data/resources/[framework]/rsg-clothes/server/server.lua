local RSGCore = exports['rsg-core']:GetCoreObject()
local foundResources = {}
local neededResources = {"rsg-menubase"}
local detectNeededResources = function()

for k, v in ipairs(neededResources) do
        if GetResourceState(v) == "started" then
            foundResources[v] = true
        else
        end
    end
end

detectNeededResources()
RegisterServerEvent('rsg-clothes:Save')
AddEventHandler('rsg-clothes:Save', function(Clothes, Name, price)
    local src = source
    local _Name = Name
    local encode = json.encode(Clothes)
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local license = RSGCore.Functions.GetIdentifier(src, 'license')
    local currentMoney = Player.Functions.GetMoney('cash')
    if currentMoney >= price then
        Player.Functions.RemoveMoney("cash", price)
        TriggerEvent("rsg-clothes:retrieveClothes", citizenid, license, function(call)
            if call then
                MySQL.Async.execute("UPDATE playerclothe SET `clothes` = ? WHERE `citizenid`= ? AND `license`= ?", {encode, citizenid, license})
            else
                MySQL.Async.insert('INSERT INTO playerclothe (citizenid, license, clothes) VALUES (?, ?, ?);', {citizenid, license, encode})
            end
        end)
        if _Name then
            TriggerEvent("rsg-clothes:retrieveOutfits", citizenid, license, _Name, function(call)
                if call then
                    MySQL.Async.execute("UPDATE playeroutfit SET `clothes` = ? WHERE `citizenid`= ? AND `license`= ? AND name = ?", {encode, citizenid, license, _Name})

                else
                    MySQL.Async.insert('INSERT INTO playeroutfit (citizenid, license, clothes, name) VALUES (?, ?, ?, ?);', {citizenid, license, encode, _Name})
                end
            end)
        end
    else
        TriggerClientEvent("rsg-appearance:LoadSkinClient", src)
    end
end)

RegisterServerEvent('rsg-clothes:LoadClothes')
AddEventHandler('rsg-clothes:LoadClothes', function(value)
    local _value = value
    local src = source
    local _clothes = nil
    local User = RSGCore.Functions.GetPlayer(source)
    local citizenid = User.PlayerData.citizenid
    local license = RSGCore.Functions.GetIdentifier(source, 'license')
    local _clothes =  MySQL.Sync.fetchAll('SELECT * FROM playerclothe WHERE citizenid = ? AND license = ?', {citizenid, license})
    if _clothes[1] then
        _clothes = json.decode(_clothes[1].clothes)
    else
        _clothes = {}
    end
    if _clothes ~= nil then
        if _value == 1 then
            TriggerClientEvent("rsg-clothes:ApplyClothes", src, _clothes)
        elseif _value == 2 then
            TriggerClientEvent("rsg-clothes:OpenClothingMenu", src, _clothes)
        end
    end
end)

RegisterServerEvent('rsg-clothes:SetOutfits')
AddEventHandler('rsg-clothes:SetOutfits', function(name)
    local src = source
    local _name = name
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local license = RSGCore.Functions.GetIdentifier(src, 'license')
    TriggerEvent('rsg-clothes:retrieveOutfits', citizenid, license, _name, function(call)
        if call then
            MySQL.Async.execute("UPDATE playerclothe SET `clothes` = ? WHERE `citizenid`= ? AND `license`= ? ", {call, citizenid, license})
            TriggerClientEvent("rsg-appearance:LoadSkinClient", src)
        end
    end)
end)

RegisterServerEvent('rsg-clothes:DeleteOutfit')
AddEventHandler('rsg-clothes:DeleteOutfit', function(name)
    local src = source
    local _name = name
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local license = RSGCore.Functions.GetIdentifier(src, 'license')
    MySQL.Async.fetchAll('DELETE FROM playeroutfit WHERE citizenid = ? AND license = ? AND name =  ?', {citizenid, license, _name})
end)

RegisterServerEvent('rsg-clothes:getOutfits')
AddEventHandler('rsg-clothes:getOutfits', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local license = RSGCore.Functions.GetIdentifier(src, 'license')
    local outfits = MySQL.Sync.fetchAll('SELECT * FROM playeroutfit WHERE citizenid = ? AND license = ?', {citizenid, license})
    if outfits[1] then
        TriggerClientEvent('rsg-clothes:putInTable', src, outfits)
    end
end)

AddEventHandler('rsg-clothes:retrieveClothes', function(citizenid, license, callback)
    local Callback = callback
    local clothes = MySQL.Sync.fetchAll('SELECT * FROM playerclothe WHERE citizenid = ? AND license = ?', {citizenid, license})
    if clothes[1] then
        Callback(clothes[1])
    else
        Callback(false)
    end
end)

AddEventHandler('rsg-clothes:retrieveOutfits', function(citizenid, license, name, callback)
    local Callback = callback
    local clothes = MySQL.Sync.fetchAll('SELECT * FROM playeroutfit WHERE citizenid = ? AND license = ? AND name = ?', {citizenid, license, name})
    if clothes[1] then
        Callback(clothes[1]["clothes"])
    else
        Callback(false)
    end
end)

RegisterServerEvent("rsg-clothes:deleteClothes")
AddEventHandler("rsg-clothes:deleteClothes", function(license, Callback)
    local src = source
    local id
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            id = v
            break
        end
    end
    local Callback = callback
    MySQL.Async.fetchAll('DELETE FROM playerclothe WHERE `citizenid`= ? AND`license`= ?;', {id, license})
    MySQL.Async.fetchAll('DELETE FROM playeroutfit WHERE `citizenid`= ? AND`license`= ?;', {id, license})
end)

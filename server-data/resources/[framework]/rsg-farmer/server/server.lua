local RSGCore = exports['rsg-core']:GetCoreObject()
local PlantsLoaded = false

-----------------------------------------------------------------------

-- cornseed
RSGCore.Functions.CreateUseableItem("cornseed", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-farmer:client:plantNewSeed', src, 'corn', 'CRP_CORNSTALKS_AB_SIM', 'cornseed')
end)

-- sugarseed
RSGCore.Functions.CreateUseableItem("sugarseed", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-farmer:client:plantNewSeed', src, 'sugar', 'CRP_SUGARCANE_AC_SIM', 'sugarseed')
end)

-- tobaccoseed
RSGCore.Functions.CreateUseableItem("tobaccoseed", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-farmer:client:plantNewSeed', src, 'tobacco', 'CRP_TOBACCOPLANT_AC_SIM', 'tobaccoseed')
end)

-- carrotseed
RSGCore.Functions.CreateUseableItem("carrotseed", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-farmer:client:plantNewSeed', src, 'carrot', 'CRP_CARROTS_AA_SIM', 'carrotseed')
end)

-- tomatoseed
RSGCore.Functions.CreateUseableItem("tomatoseed", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-farmer:client:plantNewSeed', src, 'tomato', 'CRP_TOMATOES_AA_SIM', 'tomatoseed')
end)

-- broccoliseed
RSGCore.Functions.CreateUseableItem("broccoliseed", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-farmer:client:plantNewSeed', src, 'broccoli', 'crp_broccoli_aa_sim', 'broccoliseed')
end)

-- potatoseed
RSGCore.Functions.CreateUseableItem("potatoseed", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-farmer:client:plantNewSeed', src, 'potato', 'crp_potato_aa_sim', 'potatoseed')
end)

-----------------------------------------------------------------------

-- remove seed item
RegisterServerEvent('rsg-farmer:server:removeitem')
AddEventHandler('rsg-farmer:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "remove")
end)

-----------------------------------------------------------------------

-- update plant data
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if PlantsLoaded then
            TriggerClientEvent('rsg-farmer:client:updatePlantData', -1, Config.FarmPlants)
        end
    end
end)

Citizen.CreateThread(function()
    TriggerEvent('rsg-farmer:server:getPlants')
    PlantsLoaded = true
end)

RegisterServerEvent('rsg-farmer:server:savePlant')
AddEventHandler('rsg-farmer:server:savePlant', function(data, plantId, citizenid)
    local data = json.encode(data)
    MySQL.Async.execute('INSERT INTO player_plants (properties, plantid, citizenid) VALUES (@properties, @plantid, @citizenid)', {
        ['@properties'] = data,
        ['@plantid'] = plantId,
        ['@citizenid'] = citizenid
    })
end)

-- plant seed
RegisterServerEvent('rsg-farmer:server:plantNewSeed')
AddEventHandler('rsg-farmer:server:plantNewSeed', function(planttype, location, hash)
    local src = source
    local plantId = math.random(111111, 999999)
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid 
    local SeedData = {
        id = plantId, 
        planttype = planttype,
        x = location.x, 
        y = location.y, 
        z = location.z, 
        hunger = Config.StartingHunger, 
        thirst = Config.StartingThirst, 
        growth = 0.0, 
        quality = 100.0,
        grace = true,
        hash = hash,
        beingHarvested = false, 
        planter = Player.PlayerData.citizenid,
        planttime = os.time(),
    }

    local PlantCount = 0

    for k, v in pairs(Config.FarmPlants) do
        if v.planter == Player.PlayerData.citizenid then
            PlantCount = PlantCount + 1
        end
    end

    if PlantCount >= Config.MaxPlantCount then
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_already_have_plants_down',{MaxPlantCount = Config.MaxPlantCount}), 'error')
    else
        table.insert(Config.FarmPlants, SeedData)
        TriggerEvent('rsg-farmer:server:savePlant', SeedData, plantId, citizenid)
        TriggerEvent('rsg-farmer:server:updatePlants')
    end
end)

-- check plant
RegisterServerEvent('rsg-farmer:server:plantHasBeenHarvested')
AddEventHandler('rsg-farmer:server:plantHasBeenHarvested', function(plantId)
    for k, v in pairs(Config.FarmPlants) do
        if v.id == plantId then
            v.beingHarvested = true
        end
    end
    TriggerEvent('rsg-farmer:server:updatePlants')
end)

-- distory plant (police)
RegisterServerEvent('rsg-farmer:server:destroyPlant')
AddEventHandler('rsg-farmer:server:destroyPlant', function(plantId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    for k, v in pairs(Config.FarmPlants) do
        if v.id == plantId then
            table.remove(Config.FarmPlants, k)
        end
    end
    TriggerClientEvent('rsg-farmer:client:removePlantObject', -1, plantId)
    TriggerEvent('rsg-farmer:server:PlantRemoved', plantId)
    TriggerEvent('rsg-farmer:server:updatePlants')
    TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.you_distroyed_the_plant'), 'success')
end)

-- harvest plant and give reward
RegisterServerEvent('rsg-farmer:server:harvestPlant')
AddEventHandler('rsg-farmer:server:harvestPlant', function(plantId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local poorAmount = 0
    local goodAmount = 0
    local exellentAmount = 0
    local poorQuality = false
    local goodQuality = false
    local exellentQuality = false
    local hasFound = false
    for k, v in pairs(Config.FarmPlants) do
        if v.id == plantId then
            for y = 1, #Config.FarmItems do
                if v.planttype == Config.FarmItems[y].planttype then
                    label = Config.FarmItems[y].label
                    item = Config.FarmItems[y].item
                    poorAmount = math.random(Config.FarmItems[y].poorRewardMin, Config.FarmItems[y].poorRewardMax)
                    goodAmount = math.random(Config.FarmItems[y].goodRewardMin, Config.FarmItems[y].goodRewardMax)
                    exellentAmount = math.random(Config.FarmItems[y].exellentRewardMin, Config.FarmItems[y].exellentRewardMax)
                    local quality = math.ceil(v.quality)
                    hasFound = true
                    table.remove(Config.FarmPlants, k)
                    if quality > 0 and quality <= 25 then -- poor
                        poorQuality = true
                    elseif quality >= 25 and quality <= 75 then -- good
                        goodQuality = true
                    elseif quality >= 75 then -- excellent
                        exellentQuality = true
                    end
                end
            end
        end
    end
    -- give rewards
    if hasFound then
        if poorQuality then
            Player.Functions.AddItem(item, poorAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.you_harvest_label',{amount = poorAmount, label = label}), 'success')
        elseif goodQuality then
            Player.Functions.AddItem(item, goodAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.you_harvest_label',{amount = goodAmount, label = label}), 'success')
        elseif exellentQuality then
            Player.Functions.AddItem(item, exellentAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.you_harvest_label',{amount = exellentAmount, label = label}), 'success')
        else
            print("something went wrong!")
        end
        TriggerClientEvent('rsg-farmer:client:removePlantObject', -1, plantId)
        TriggerEvent('rsg-farmer:server:PlantRemoved', plantId)
        TriggerEvent('rsg-farmer:server:updatePlants')
    end
end)

RegisterServerEvent('rsg-farmer:server:updatePlants')
AddEventHandler('rsg-farmer:server:updatePlants', function()
    local src = source
    TriggerClientEvent('rsg-farmer:client:updatePlantData', src, Config.FarmPlants)
end)

-- water plant
RegisterServerEvent('rsg-farmer:server:waterPlant')
AddEventHandler('rsg-farmer:server:waterPlant', function(plantId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    for k, v in pairs(Config.FarmPlants) do
        if v.id == plantId then
            Config.FarmPlants[k].thirst = Config.FarmPlants[k].thirst + Config.ThirstIncrease
            if Config.FarmPlants[k].thirst > 100.0 then
                Config.FarmPlants[k].thirst = 100.0
            end
        end
    end
    Player.Functions.RemoveItem('water', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['water'], "remove")
    TriggerEvent('rsg-farmer:server:updatePlants')
end)

-- feed plant
RegisterServerEvent('rsg-farmer:server:feedPlant')
AddEventHandler('rsg-farmer:server:feedPlant', function(plantId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    for k, v in pairs(Config.FarmPlants) do
        if v.id == plantId then
            Config.FarmPlants[k].hunger = Config.FarmPlants[k].hunger + Config.HungerIncrease
            if Config.FarmPlants[k].hunger > 100.0 then
                Config.FarmPlants[k].hunger = 100.0
            end
        end
    end
    Player.Functions.RemoveItem('fertilizer', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['fertilizer'], "remove")
    TriggerEvent('rsg-farmer:server:updatePlants')
end)

-- update plant
RegisterServerEvent('rsg-farmer:server:updateFarmPlants')
AddEventHandler('rsg-farmer:server:updateFarmPlants', function(id, data)
    local result = MySQL.query.await('SELECT * FROM player_plants WHERE plantid = @plantid', {
        ['@plantid'] = id
    })
    if result[1] then
        local newData = json.encode(data)
        MySQL.Async.execute('UPDATE player_plants SET properties = @properties WHERE plantid = @id', {
            ['@properties'] = newData,
            ['@id'] = id
        })
    end
end)

-- remove plant
RegisterServerEvent('rsg-farmer:server:PlantRemoved')
AddEventHandler('rsg-farmer:server:PlantRemoved', function(plantId)
    local result = MySQL.query.await('SELECT * FROM player_plants')
    if result then
        for i = 1, #result do
            local plantData = json.decode(result[i].properties)
            if plantData.id == plantId then
                MySQL.Async.execute('DELETE FROM player_plants WHERE id = @id', {
                    ['@id'] = result[i].id
                })
                for k, v in pairs(Config.FarmPlants) do
                    if v.id == plantId then
                        table.remove(Config.FarmPlants, k)
                    end
                end
            end
        end
    end
end)

-- get plant
RegisterServerEvent('rsg-farmer:server:getPlants')
AddEventHandler('rsg-farmer:server:getPlants', function()
    local data = {}
    local result = MySQL.query.await('SELECT * FROM player_plants')
    if result[1] then
        for i = 1, #result do
            local plantData = json.decode(result[i].properties)
            print('loading '..plantData.planttype..' plant with ID: '..plantData.id)
            table.insert(Config.FarmPlants, plantData)
        end
    end
end)

-- plant timer
Citizen.CreateThread(function()
    while true do
        Wait(Config.GrowthTimer)
        for i = 1, #Config.FarmPlants do
            if Config.FarmPlants[i].growth < 100 then
                if Config.FarmPlants[i].grace then
                    Config.FarmPlants[i].grace = false
                else
                    Config.FarmPlants[i].thirst = Config.FarmPlants[i].thirst - 1
                    Config.FarmPlants[i].hunger = Config.FarmPlants[i].hunger - 1
                    Config.FarmPlants[i].growth = Config.FarmPlants[i].growth + 1

                    if Config.FarmPlants[i].growth > 100 then
                        Config.FarmPlants[i].growth = 100
                    end

                    if Config.FarmPlants[i].hunger < 0 then
                        Config.FarmPlants[i].hunger = 0
                    end

                    if Config.FarmPlants[i].thirst < 0 then
                        Config.FarmPlants[i].thirst = 0
                    end

                    if Config.FarmPlants[i].quality < 25 then
                        Config.FarmPlants[i].quality = 25
                    end

                    if Config.FarmPlants[i].thirst < 75 or Config.FarmPlants[i].hunger < 75 then
                        Config.FarmPlants[i].quality = Config.FarmPlants[i].quality - 1
                    end
                end
            else
                local untildead = Config.FarmPlants[i].planttime + Config.DeadPlantTime
                local currenttime = os.time()
                if currenttime > untildead then
                    deadid = Config.FarmPlants[i].id
                    print('Removing Dead Plant with ID '..deadid)
                    TriggerEvent('rsg-farmer:server:PlantRemoved', deadid)
                end
            end
            TriggerEvent('rsg-farmer:server:updateFarmPlants', Config.FarmPlants[i].id, Config.FarmPlants[i])
        end
        TriggerEvent('rsg-farmer:server:updatePlants')
    end
end)

-- give farmer collected water
RegisterServerEvent('rsg-farmer:server:giveitem')
AddEventHandler('rsg-farmer:server:giveitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")
end)

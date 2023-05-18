local rhodesentities = {}
local bwentities = {}
local sdentities = {}
local annesburgentities = {}
local tbentities = {}
local sbentities = {}
local npcs = {}
local rhnpcs = {}
local annpcs = {}
local bwnpcs = {}
local twnpcs = {}
local sdnpcs = {}
local sbnpcs = {}
local timeout = false
local timeoutTimer = 30
local wagonPed = 0
local wagonSpawned = false
local WagonCalled = false
local QRCore = exports['rsg-core']:GetCoreObject()
local newnames = ''
local wagonDBID
local hasSpawned = false 
local coords

local inRhodes = false
local inBlackwater = false 
local inSD = false 
local inAnnesburg = false
local inTumble = false
local inSB = false

RegisterCommand('setwagonname',function(input)
    local input = exports['qr-input']:ShowInput({
    header = "Name your wagon",
    submitText = "Confirm",
    inputs = {
        {
            type = 'text',
            isRequired = true,
            name = 'realinput',
            text = 'text'
        }
    }
})
print(input)
for k,v in pairs(input) do
    print(k .. " : " .. v)
end
TriggerServerEvent('tcrp-wagons:renameWagon', input)
end)


Citizen.CreateThread(function() -- Handle Annesburg
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        local hcoords = Config.Annesburgcoords
        Wait(10000)
         if #(pcoords - hcoords) <= 300.7 then  
            Wait(100)
            if inAnnesburg == false then
                inAnnesburg = true
                for k,v in pairs(Config.BoxZones) do
                    if k == "Annesburg" then
                        for j, n in pairs(v) do
                            Wait(1)
                            local model = GetHashKey(n.model)
                            while (not HasModelLoaded(model)) do
                                RequestModel(model)
                                Wait(1)
                            end
                            local entity = CreateVehicle(model, n.coords.x, n.coords.y, n.coords.z-1, n.heading, false, true, 0, 0)
                            while not DoesEntityExist(entity) do
                                Wait(1)
                            end
                            local hasSpawned = true
                            table.insert(annesburgentities, entity)
                            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
                            FreezeEntityPosition(entity, true)
                            SetEntityCanBeDamaged(entity, false)
                            SetEntityInvincible(entity, true)
                            SetBlockingOfNonTemporaryEvents(npc, true)
                            exports['rsg-target']:AddTargetEntity(entity, {
                                options = {
                                    {
                                        icon = "fas fa-dharmachakra",
                                        label =  n.names.." || " .. n.price ..  "$",
                                        targeticon = "fas fa-eye",
                                        action = function(newnames)
                                                AddTextEntry('FMMC_MPM_NA', "Set wagon name")
                                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
                                                while (UpdateOnscreenKeyboard() == 0) do
                                                    DisableAllControlActions(0);
                                                    Wait(0);
                                                end
                                                if (GetOnscreenKeyboardResult()) then
                                                    newnames = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('tcrp-wagons:server:BuyWagon', n.price, n.model, newnames)
                                                else
                                            end
                                            
                                        end
                                    }
                                },
                                distance = 2.5,
                            })
                            Citizen.InvokeNative(0x9587913B9E772D29, entity, 0)
                            SetModelAsNoLongerNeeded(model)
                        end
                    else 
                    end
                end
            
                for key,value in pairs(Config.ModelSpawns) do
                    while not HasModelLoaded(value.model) do
                        RequestModel(value.model)
                        Wait(1)
                    end
                    local ped = CreatePed(value.model, value.coords.x, value.coords.y, value.coords.z - 1.0, value.heading, false, false, 0, 0)
                    while not DoesEntityExist(ped) do
                        Wait(1)
                    end
            
                    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
                    SetEntityCanBeDamaged(ped, false)
                    SetEntityInvincible(ped, true)
                    FreezeEntityPosition(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    Wait(1)
                    TriggerEvent('tcrp-wagons:DoShit',function(cb)
                    end)
                    exports['rsg-target']:AddTargetEntity(ped, {
                        options = {
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Get your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:menu")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Store Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:storewagon")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Sell your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:MenuDel")
                                end
                            },

                            {
                                icon = "fas fa-dharmachakra",
                                label =  "Trade Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                TriggerEvent('tcrp-wagons:client:tradewagon')
                                end
                            }
                        },
                        distance = 2.5,
                    })
                    SetModelAsNoLongerNeeded(value.model)
                    table.insert(annpcs, ped)
                end
            else
            end
        else 
            inAnnesburg = false
            Wait(1000)
            for k,v in pairs(annesburgentities) do
                DeleteVehicle(v)
                SetEntityAsNoLongerNeeded(v)
            end
            for k,v in pairs(annpcs) do
                DeleteEntity(v)
                SetEntityAsNoLongerNeeded(v)
            end
        end 
    end
end)

Citizen.CreateThread(function() -- Handle Strawberry
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        local hcoords = Config.Strawberrycoords
        Wait(10000)
         if #(pcoords - hcoords) <= 300.7 then  
            Wait(100)
            if inSB == false then
                inSB = true
                for k,v in pairs(Config.BoxZones) do
                    if k == "Strawberry" then
                        for j, n in pairs(v) do
                            Wait(1)
                            local model = GetHashKey(n.model)
                            while (not HasModelLoaded(model)) do
                                RequestModel(model)
                                Wait(1)
                            end
                            local entity = CreateVehicle(model, n.coords.x, n.coords.y, n.coords.z-1, n.heading, false, true, 0, 0)
                            while not DoesEntityExist(entity) do
                                Wait(1)
                            end
                            local hasSpawned = true
                            table.insert(sbentities, entity)
                            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
                            FreezeEntityPosition(entity, true)
                            SetEntityCanBeDamaged(entity, false)
                            SetEntityInvincible(entity, true)
                            SetBlockingOfNonTemporaryEvents(npc, true)
                            exports['rsg-target']:AddTargetEntity(entity, {
                                options = {
                                    {
                                        icon = "fas fa-dharmachakra",
                                        label =  n.names.." || " .. n.price ..  "$",
                                        targeticon = "fas fa-eye",
                                        action = function(newnames)
                                                AddTextEntry('FMMC_MPM_NA', "Set wagon name")
                                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
                                                while (UpdateOnscreenKeyboard() == 0) do
                                                    DisableAllControlActions(0);
                                                    Wait(0);
                                                end
                                                if (GetOnscreenKeyboardResult()) then
                                                    newnames = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('tcrp-wagons:server:BuyWagon', n.price, n.model, newnames)
                                                else
                                            end
                                            
                                        end
                                    }
                                },
                                distance = 2.5,
                            })
                            Citizen.InvokeNative(0x9587913B9E772D29, entity, 0)
                            SetModelAsNoLongerNeeded(model)
                        end
                    else 
                    end
                end
            
                for key,value in pairs(Config.ModelSpawns) do
                    while not HasModelLoaded(value.model) do
                        RequestModel(value.model)
                        Wait(1)
                    end
                    local ped = CreatePed(value.model, value.coords.x, value.coords.y, value.coords.z - 1.0, value.heading, false, false, 0, 0)
                    while not DoesEntityExist(ped) do
                        Wait(1)
                    end
            
                    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
                    SetEntityCanBeDamaged(ped, false)
                    SetEntityInvincible(ped, true)
                    FreezeEntityPosition(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    Wait(1)
                    TriggerEvent('tcrp-wagons:DoShit',function(cb)
                    end)
                    exports['rsg-target']:AddTargetEntity(ped, {
                        options = {
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Get your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:menu")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Store Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:storewagon")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Sell your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:MenuDel")
                                end
                            },

                            {
                                icon = "fas fa-dharmachakra",
                                label =  "Trade Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                TriggerEvent('tcrp-wagons:client:tradewagon')
                                end
                            }
                        },
                        distance = 2.5,
                    })
                    SetModelAsNoLongerNeeded(value.model)
                    table.insert(sbnpcs, ped)
                end
            else
            end
        else 
            inSB = false
            Wait(1000)
            for k,v in pairs(sbentities) do
                DeleteVehicle(v)
                SetEntityAsNoLongerNeeded(v)
            end
            for k,v in pairs(sbnpcs) do
                DeleteEntity(v)
                SetEntityAsNoLongerNeeded(v)
            end
        end 
    end
end)

Citizen.CreateThread(function() -- Handle Rhodes
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        local hcoords = Config.Rhodescoords
        Wait(10000)
         if #(pcoords - hcoords) <= 300.7 then  
            Wait(100)
            if inRhodes == false then
                inRhodes = true
                for k,v in pairs(Config.BoxZones) do
                    if k == "Rhodes" then
                        for j, n in pairs(v) do
                            Wait(1)
                            local model = GetHashKey(n.model)
                            while (not HasModelLoaded(model)) do
                                RequestModel(model)
                                Wait(1)
                            end
                            local entity = CreateVehicle(model, n.coords.x, n.coords.y, n.coords.z-1, n.heading, false, true, 0, 0)
                            while not DoesEntityExist(entity) do
                                Wait(1)
                            end
                            local hasSpawned = true
                            table.insert(rhodesentities, entity)
                            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
                            FreezeEntityPosition(entity, true)
                            SetEntityCanBeDamaged(entity, false)
                            SetEntityInvincible(entity, true)
                            SetBlockingOfNonTemporaryEvents(npc, true)
                            exports['rsg-target']:AddTargetEntity(entity, {
                                options = {
                                    {
                                        icon = "fas fa-dharmachakra",
                                        label =  n.names.." || " .. n.price ..  "$",
                                        targeticon = "fas fa-eye",
                                        action = function(newnames)
                                                AddTextEntry('FMMC_MPM_NA', "Set wagon name")
                                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
                                                while (UpdateOnscreenKeyboard() == 0) do
                                                    DisableAllControlActions(0);
                                                    Wait(0);
                                                end
                                                if (GetOnscreenKeyboardResult()) then
                                                    newnames = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('tcrp-wagons:server:BuyWagon', n.price, n.model, newnames)
                                                else
                                            end
                                            
                                        end
                                    }
                                },
                                distance = 2.5,
                            })
                            Citizen.InvokeNative(0x9587913B9E772D29, entity, 0)
                            SetModelAsNoLongerNeeded(model)
                        end
                    else 
                    end
                end
            
                for key,value in pairs(Config.ModelSpawns) do
                    while not HasModelLoaded(value.model) do
                        RequestModel(value.model)
                        Wait(1)
                    end
                    local ped = CreatePed(value.model, value.coords.x, value.coords.y, value.coords.z - 1.0, value.heading, false, false, 0, 0)
                    while not DoesEntityExist(ped) do
                        Wait(1)
                    end
            
                    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
                    SetEntityCanBeDamaged(ped, false)
                    SetEntityInvincible(ped, true)
                    FreezeEntityPosition(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    Wait(1)
                    TriggerEvent('tcrp-wagons:DoShit',function(cb)
                    end)
                    exports['rsg-target']:AddTargetEntity(ped, {
                        options = {
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Get your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:menu")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Store Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:storewagon")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Sell your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:MenuDel")
                                end
                            },

                            {
                                icon = "fas fa-dharmachakra",
                                label =  "Trade Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                TriggerEvent('tcrp-wagons:client:tradewagon')
                                end
                            }
                        },
                        distance = 2.5,
                    })
                    SetModelAsNoLongerNeeded(value.model)
                    table.insert(rhnpcs, ped)
                end
            else
            end
        else 
            inRhodes = false
            Wait(1000)
            for k,v in pairs(rhodesentities) do
                DeleteVehicle(v)
                SetEntityAsNoLongerNeeded(v)
            end
            for k,v in pairs(rhnpcs) do
                DeleteEntity(v)
                SetEntityAsNoLongerNeeded(v)
            end
        end 
    end
end)

Citizen.CreateThread(function() -- Handle Blackwater
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        local hcoords = Config.Blackwatercoords
        Wait(10000)
         if #(pcoords - hcoords) <= 300.7 then  
            Wait(100)
            if inBlackwater == false then
                inBlackwater = true
                for k,v in pairs(Config.BoxZones) do
                    if k == "Blackwater" then
                        for j, n in pairs(v) do
                            Wait(1)
                            local model = GetHashKey(n.model)
                            while (not HasModelLoaded(model)) do
                                RequestModel(model)
                                Wait(1)
                            end
                            local entity = CreateVehicle(model, n.coords.x, n.coords.y, n.coords.z-1, n.heading, false, true, 0, 0)
                            while not DoesEntityExist(entity) do
                                Wait(1)
                            end
                            local hasSpawned = true
                            table.insert(bwentities, entity)
                            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
                            FreezeEntityPosition(entity, true)
                            SetEntityCanBeDamaged(entity, false)
                            SetEntityInvincible(entity, true)
                            SetBlockingOfNonTemporaryEvents(npc, true)
                            exports['rsg-target']:AddTargetEntity(entity, {
                                options = {
                                    {
                                        icon = "fas fa-dharmachakra",
                                        label =  n.names.." || " .. n.price ..  "$",
                                        targeticon = "fas fa-eye",
                                        action = function(newnames)
                                                AddTextEntry('FMMC_MPM_NA', "Set wagon name")
                                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
                                                while (UpdateOnscreenKeyboard() == 0) do
                                                    DisableAllControlActions(0);
                                                    Wait(0);
                                                end
                                                if (GetOnscreenKeyboardResult()) then
                                                    newnames = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('tcrp-wagons:server:BuyWagon', n.price, n.model, newnames)
                                                else
                                            end
                                            
                                        end
                                    }
                                },
                                distance = 2.5,
                            })
                            Citizen.InvokeNative(0x9587913B9E772D29, entity, 0)
                            SetModelAsNoLongerNeeded(model)
                        end
                    else 
                    end
                end
            
                for key,value in pairs(Config.ModelSpawns) do
                    while not HasModelLoaded(value.model) do
                        RequestModel(value.model)
                        Wait(1)
                    end
                    local ped = CreatePed(value.model, value.coords.x, value.coords.y, value.coords.z - 1.0, value.heading, false, false, 0, 0)
                    while not DoesEntityExist(ped) do
                        Wait(1)
                    end
            
                    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
                    SetEntityCanBeDamaged(ped, false)
                    SetEntityInvincible(ped, true)
                    FreezeEntityPosition(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    Wait(1)
                    TriggerEvent('tcrp-wagons:DoShit',function(cb)
                    end)
                    exports['rsg-target']:AddTargetEntity(ped, {
                        options = {
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Get your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:menu")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Store Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:storewagon")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Sell your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:MenuDel")
                                end
                            },

                            {
                                icon = "fas fa-dharmachakra",
                                label =  "Trade Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                TriggerEvent('tcrp-wagons:client:tradewagon')
                                end
                            }
                        },
                        distance = 2.5,
                    })
                    SetModelAsNoLongerNeeded(value.model)
                    table.insert(bwnpcs, ped)
                end
            else
            end
        else 
            inBlackwater = false
            Wait(1000)
            for k,v in pairs(bwentities) do
                DeleteVehicle(v)
                SetEntityAsNoLongerNeeded(v)
            end
            for k,v in pairs(bwnpcs) do
                DeleteEntity(v)
                SetEntityAsNoLongerNeeded(v)
            end
        end 
    end
end)

Citizen.CreateThread(function() -- Handle Saint Denis
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        local hcoords = Config.SDcoords 
        Wait(10000)
         if #(pcoords - hcoords) <= 300.7 then  
            Wait(100)
            if inSD == false then
                inSD = true
                for k,v in pairs(Config.BoxZones) do
                    if k == "Saint Denis" then
                        for j, n in pairs(v) do
                            Wait(1)
                            local model = GetHashKey(n.model)
                            while (not HasModelLoaded(model)) do
                                RequestModel(model)
                                Wait(1)
                            end
                            local entity = CreateVehicle(model, n.coords.x, n.coords.y, n.coords.z-1, n.heading, false, true, 0, 0)
                            while not DoesEntityExist(entity) do
                                Wait(1)
                            end
                            local hasSpawned = true
                            table.insert(sdentities, entity)
                            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
                            FreezeEntityPosition(entity, true)
                            SetEntityCanBeDamaged(entity, false)
                            SetEntityInvincible(entity, true)
                            SetBlockingOfNonTemporaryEvents(npc, true)
                            exports['rsg-target']:AddTargetEntity(entity, {
                                options = {
                                    {
                                        icon = "fas fa-dharmachakra",
                                        label =  n.names.." || " .. n.price ..  "$",
                                        targeticon = "fas fa-eye",
                                        action = function(newnames)
                                                AddTextEntry('FMMC_MPM_NA', "Set wagon name")
                                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
                                                while (UpdateOnscreenKeyboard() == 0) do
                                                    DisableAllControlActions(0);
                                                    Wait(0);
                                                end
                                                if (GetOnscreenKeyboardResult()) then
                                                    newnames = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('tcrp-wagons:server:BuyWagon', n.price, n.model, newnames)
                                                else
                                            end
                                            
                                        end
                                    }
                                },
                                distance = 2.5,
                            })
                            Citizen.InvokeNative(0x9587913B9E772D29, entity, 0)
                            SetModelAsNoLongerNeeded(model)
                        end
                    else 
                    end
                end
            
                for key,value in pairs(Config.ModelSpawns) do
                    while not HasModelLoaded(value.model) do
                        RequestModel(value.model)
                        Wait(1)
                    end
                    local ped = CreatePed(value.model, value.coords.x, value.coords.y, value.coords.z - 1.0, value.heading, false, false, 0, 0)
                    while not DoesEntityExist(ped) do
                        Wait(1)
                    end
            
                    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
                    SetEntityCanBeDamaged(ped, false)
                    SetEntityInvincible(ped, true)
                    FreezeEntityPosition(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    Wait(1)
                    TriggerEvent('tcrp-wagons:DoShit',function(cb)
                    end)
                    exports['rsg-target']:AddTargetEntity(ped, {
                        options = {
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Get your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:menu")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Store Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:storewagon")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Sell your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:MenuDel")
                                end
                            },

                            {
                                icon = "fas fa-dharmachakra",
                                label =  "Trade Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                TriggerEvent('tcrp-wagons:client:tradewagon')
                                end
                            }
                        },
                        distance = 2.5,
                    })
                    SetModelAsNoLongerNeeded(value.model)
                    table.insert(sdnpcs, ped)
                end
            else
            end
        else 
            inSD = false
            Wait(1000)
            for k,v in pairs(sdentities) do
                DeleteVehicle(v)
                SetEntityAsNoLongerNeeded(v)
            end
            for k,v in pairs(sdnpcs) do
                DeleteEntity(v)
                SetEntityAsNoLongerNeeded(v)
            end
        end 
    end
end)
Citizen.CreateThread(function() -- Handle Tumbleweed
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        local hcoords = Config.Tumbleweedcoords 
        Wait(10000)
         if #(pcoords - hcoords) <= 300.7 then  
            Wait(100)
            if inTumble == false then
                inTumble = true
                for k,v in pairs(Config.BoxZones) do
                    if k == "Tumbleweed" then
                        for j, n in pairs(v) do
                            Wait(1)
                            local model = GetHashKey(n.model)
                            while (not HasModelLoaded(model)) do
                                RequestModel(model)
                                Wait(1)
                            end
                            local entity = CreateVehicle(model, n.coords.x, n.coords.y, n.coords.z-1, n.heading, false, true, 0, 0)
                            while not DoesEntityExist(entity) do
                                Wait(1)
                            end
                            local hasSpawned = true
                            table.insert(tbentities, entity)
                            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
                            FreezeEntityPosition(entity, true)
                            SetEntityCanBeDamaged(entity, false)
                            SetEntityInvincible(entity, true)
                            SetBlockingOfNonTemporaryEvents(npc, true)
                            exports['rsg-target']:AddTargetEntity(entity, {
                                options = {
                                    {
                                        icon = "fas fa-dharmachakra",
                                        label =  n.names.." || " .. n.price ..  "$",
                                        targeticon = "fas fa-eye",
                                        action = function(newnames)
                                                AddTextEntry('FMMC_MPM_NA', "Set wagon name")
                                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
                                                while (UpdateOnscreenKeyboard() == 0) do
                                                    DisableAllControlActions(0);
                                                    Wait(0);
                                                end
                                                if (GetOnscreenKeyboardResult()) then
                                                    newnames = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('tcrp-wagons:server:BuyWagon', n.price, n.model, newnames)
                                                else
                                            end
                                            
                                        end
                                    }
                                },
                                distance = 2.5,
                            })
                            Citizen.InvokeNative(0x9587913B9E772D29, entity, 0)
                            SetModelAsNoLongerNeeded(model)
                        end
                    else 
                    end
                end
            
                for key,value in pairs(Config.ModelSpawns) do
                    while not HasModelLoaded(value.model) do
                        RequestModel(value.model)
                        Wait(1)
                    end
                    local ped = CreatePed(value.model, value.coords.x, value.coords.y, value.coords.z - 1.0, value.heading, false, false, 0, 0)
                    while not DoesEntityExist(ped) do
                        Wait(1)
                    end
            
                    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
                    SetEntityCanBeDamaged(ped, false)
                    SetEntityInvincible(ped, true)
                    FreezeEntityPosition(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    Wait(1)
                    TriggerEvent('tcrp-wagons:DoShit',function(cb)
                    end)
                    exports['rsg-target']:AddTargetEntity(ped, {
                        options = {
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Get your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:menu")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Store Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:storewagon")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label = "Sell your wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                    TriggerEvent("tcrp-wagons:client:MenuDel")
                                end
                            },
                            {
                                icon = "fas fa-dharmachakra",
                                label =  "Trade Wagon",
                                targeticon = "fas fa-eye",
                                action = function()
                                TriggerEvent('tcrp-wagons:client:tradewagon')
                                end
                            }
                        },
                        distance = 2.5,
                    })
                    SetModelAsNoLongerNeeded(value.model)
                    table.insert(twnpcs, ped)
                end
            else
            end
        else 
            inTumble = false
            Wait(1000)
            for k,v in pairs(tbentities) do
                DeleteVehicle(v)
                SetEntityAsNoLongerNeeded(v)
            end
            for k,v in pairs(twnpcs) do
                DeleteEntity(v)
                SetEntityAsNoLongerNeeded(v)
            end
        end 
    end
end)

RegisterCommand('winv',function(data)
    InvWagon()
end)

CreateThread(function()
    while true do
        Wait(1)
        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, QRCore.Shared.Keybinds['B']) then -- openinventory
            InvWagon()
			Wait(10000) -- Spam protect
        end
    end
end)

function InvWagon()
    QRCore.Functions.TriggerCallback('tcrp-wagons:server:GetActiveWagon', function(data,newnames)
        if wagonPed ~= 0 then
            local pcoords = GetEntityCoords(PlayerPedId())
            local hcoords = GetEntityCoords(wagonPed)
            if #(pcoords - hcoords) <= 1.7 then
                local wagonstash = data.name..data.citizenid
                print(wagonstash)
                TriggerServerEvent("inventory:server:OpenInventory", "stash", wagonstash, { maxweight = 500000, slots = 40, })
                TriggerEvent("inventory:client:SetCurrentStash", wagonstash)
            else
                print("you are NOT in distance to open inventory")
            end 
        else
            print("you do not have a wagon active")
        end
    end)       
end     

local function TradeWagon()
    QRCore.Functions.TriggerCallback('tcrp-wagons:server:GetActiveWagon', function(data,newnames)
        if wagonPed ~= 0 then
            local player, distance = QRCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 1.5 then
                local playerId = GetPlayerServerId(player)
                local wagonId = data.citizenid
                TriggerServerEvent('tcrp-wagons:server:TradeWagon', playerId, wagonId)
                QRCore.Functions.Notify('Wagon has been traded with nearest person', 'success', 7500)
            else
                QRCore.Functions.Notify('No nearby person!', 'success', 7500)
            end
        end
    end)
end

local function SpawnWagon()
    QRCore.Functions.TriggerCallback('tcrp-wagons:server:GetActiveWagon', function(data,newnames)
        if (data) then
            local ped = PlayerPedId()
            local model = GetHashKey(data.wagon)
            local location = GetEntityCoords(ped)
            local howfar = math.random(50,100)
            local hname = data.name

            if (location) then
                while not HasModelLoaded(model) do
                    RequestModel(model)
                    Wait(10)
                end

                local spawnPosition

                if atCoords == nil then
                    local x, y, z = table.unpack(location)
                    local bool, nodePosition = GetClosestVehicleNode(x, y, z, 0, 3.0, 0.0)
            
                    local index = 0
                    while index <= 25 do
                        local _bool, _nodePosition = GetNthClosestVehicleNode(x, y, z, index, 1, 3.0, 2.5)
                        if _bool == true or _bool == 1 then
                            bool = _bool
                            nodePosition = _nodePosition
                            index = index + 3
                        else
                            break
                        end
                    end
            
                    spawnPosition = nodePosition
                else
                    spawnPosition = atCoords
                end
            
                if spawnPosition == nil then
                    initializing = false
                    return
                end
                local heading = GetEntityHeading(ped)-180
                if (wagonPed == 0) then
                    wagonPed = CreateVehicle(model, spawnPosition, heading, true, true, 0, 0)
                    local coords = GetEntityCoords(PlayerPedId())
                    local wagonCoords = GetEntityCoords(wagonPed)
                    local distance = GetDistanceBetweenCoords(wagonCoords, coords)
                    if distance > 150 then
                        QRCore.Functions.Notify('You need to be near a road!', 'error', 7500)
                        Wait(100)
                        DeleteVehicle(wagonPed)
                        Wait(100)
                        wagonPed = 0
                        WagonCalled = false
                    else 
                    SetModelAsNoLongerNeeded(model)
                    Citizen.InvokeNative(0x58A850EAEE20FAA3, wagonPed, true)
                    while not DoesEntityExist(wagonPed) do
                        Wait(10)
                    end
                    Wait(100)
                    getControlOfEntity(wagonPed)
                    Citizen.InvokeNative(0x283978A15512B2FE, wagonPed, true)
                    Citizen.InvokeNative(0x23F74C2FDA6E7C61, 631964804, wagonPed)
                    local hasp = GetHashKey("PLAYER")
                    Citizen.InvokeNative(0xADB3F206518799E8, wagonPed, hasp)
                    Citizen.InvokeNative(0xCC97B29285B1DC3B, wagonPed, 1)
                    Citizen.InvokeNative(0x931B241409216C1F , PlayerPedId(), wagonPed , 0)
                    SetModelAsNoLongerNeeded(model)
                    SetPedNameDebug(wagonPed, hname)
                    SetPedPromptName(wagonPed, hname)
                    wagonSpawned = true                    
                    moveWagonToPlayer()
                    Wait(5000)
                end
                end
            end
        end
    end)
end
exports('spawnWagon', handleSpawnWagon)


function moveWagonToPlayer()
    Citizen.CreateThread(function()
        Citizen.InvokeNative(0x6A071245EB0D1882, wagonPed, PlayerPedId(), -1, 5.0, 15.0, 0, 0)
        while wagonSpawned == true do
            local coords = GetEntityCoords(PlayerPedId())
            local wagonCoords = GetEntityCoords(wagonPed)
            local distance = #(coords - wagonCoords)
            if (distance < 7.0) then
                ClearPedTasks(wagonPed, true, true)
                wagonSpawned = false
            end
            Wait(1000)
        end
    end)
end

function setPedDefaultOutfit(model)
    return Citizen.InvokeNative(0x283978A15512B2FE, model, true)
end

function getControlOfEntity(entity)
    NetworkRequestControlOfEntity(entity)
    SetEntityAsMissionEntity(entity, true, true)
    local timeout = 2000

    while timeout > 0 and NetworkHasControlOfEntity(entity) == nil do
        Wait(100)
        timeout = timeout - 100
    end
    return NetworkHasControlOfEntity(entity)
end


Citizen.CreateThread(function()
    while true do
        if (timeout) then
            if (timeoutTimer == 0) then
                timeout = false
            end
            timeoutTimer = timeoutTimer - 1
            Wait(1000)
        end
        Wait(0)
    end
end)


local function Flee()
    Wait(1000)
    DeleteEntity(wagonPed)
    Wait(1000)
    wagonPed = 0
    WagonCalled = false
end

CreateThread(function()
    while true do
        Wait(1)
        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, QRCore.Shared.Keybinds['J']) then -- call wagon
            if not WagonCalled then
			SpawnWagon()
            WagonCalled = true
			Wait(10000) -- Spam protect
     else
        moveWagonToPlayer()
         end
    elseif Citizen.InvokeNative(0x91AEF906BCA88877, 0, QRCore.Shared.Keybinds['HorseCommandFlee']) then -- flee wagon
		    if wagonSpawned ~= 0 then
			    Flee()
		    end
		end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if (resource == GetCurrentResourceName()) then
        for k,v in pairs(bwentities) do
            DeleteVehicle(v)
            SetVehicleAsNoLongerNeeded(v)
        end
        for k,v in pairs(tbentities) do
            DeleteVehicle(v)
            SetVehicleAsNoLongerNeeded(v)
        end
        for k,v in pairs(sdentities) do
            DeleteVehicle(v)
            SetVehicleAsNoLongerNeeded(v)
        end
        for k,v in pairs(annesburgentities) do
            DeleteVehicle(v)
            SetVehicleAsNoLongerNeeded(v)
        end
        for k,v in pairs(rhodesentities) do
            DeleteVehicle(v)
            SetVehicleAsNoLongerNeeded(v)
        end
        for k,v in pairs(sbentities) do
            DeleteVehicle(v)
            SetVehicleAsNoLongerNeeded(v)
        end

        for k,v in pairs(rhnpcs) do
            DeleteEntity(v)
            SetEntityAsNoLongerNeeded(v)
        end
        for k,v in pairs(annpcs) do
            DeleteEntity(v)
            SetEntityAsNoLongerNeeded(v)
        end
        for k,v in pairs(bwnpcs) do
            DeleteEntity(v)
            SetEntityAsNoLongerNeeded(v)
        end
        for k,v in pairs(sdnpcs) do
            DeleteEntity(v)
            SetEntityAsNoLongerNeeded(v)
        end
        for k,v in pairs(twnpcs) do
            DeleteEntity(v)
            SetEntityAsNoLongerNeeded(v)
        end
        for k,v in pairs(sbnpcs) do
            DeleteEntity(v)
            SetEntityAsNoLongerNeeded(v)
        end

        if (wagonPed ~= 0) then
            DeleteVehicle(wagonPed)
            SetEntityAsNoLongerNeeded(wagonPed)
        end
    end
end)


CreateThread(function()
    for key,value in pairs(Config.ModelSpawns) do
        local CartwrightBlip = N_0x554d9d53f696d002(1664425300, value.coords)
        SetBlipSprite(CartwrightBlip, -1747775003, 52)
        SetBlipScale(CartwrightBlip, 0.1)
        Citizen.InvokeNative(0x9CB1A1623062F402, tonumber(CartwrightBlip), "Cartwright")
    end
end)

RegisterNetEvent("tcrp-wagons:client:tradewagon", function(data)
    QRCore.Functions.TriggerCallback('tcrp-wagons:server:GetActiveWagon', function(data,newnames)
        if (wagonPed ~= 0) then
            TradeWagon()
            Flee()
            Wait(10000)
            DeleteEntity(wagonPed)
            SetEntityAsNoLongerNeeded(wagonPed)
            WagonCalled = false
        else
            QRCore.Functions.Notify('You dont have a wagon out', 'success', 7500)
        end
    end)
end)

local WagonId = nil

RegisterNetEvent('tcrp-wagons:client:SpawnWagon', function(data)
    WagonId = data.player.id
    TriggerServerEvent("tcrp-wagons:server:SetWagosActive", data.player.id)
    QRCore.Functions.Notify('Wagon has been set active call from back by whistling', 'success', 7500)
end)

RegisterNetEvent("tcrp-wagons:client:storewagon", function(data)
 if (wagonPed ~= 0) then
    TriggerServerEvent("tcrp-wagons:server:SetWagosUnActive", WagonId)
    QRCore.Functions.Notify('Taking your wagon to the back', 'success', 7500)
    Flee()
    Wait(10000)
    DeletePed(wagonPed)
    SetEntityAsNoLongerNeeded(wagonPed)
    WagonCalled = false
    end
end)

RegisterNetEvent('tcrp-wagons:client:menu', function()
    local GetWagon = {
        {
            header = "| My Wagons |",
            isMenuHeader = true,
            icon = "fa-solid fa-circle-user",
        },
    }
    QRCore.Functions.TriggerCallback('tcrp-wagons:server:GetWagon', function(cb)
        for _, v in pairs(cb) do
            GetWagon[#GetWagon + 1] = {
                header = v.name,
                txt = "select you wagon",
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "tcrp-wagons:client:SpawnWagon",
                    args = {
                        player = v,
                        active = 1
                    }
                }
            }
        end
        exports['qr-menu']:openMenu(GetWagon)
    end)
end)

RegisterNetEvent('tcrp-wagons:client:MenuDel', function()
    local GetWagon = {
        {
            header = "| Delete Wagons |",
            isMenuHeader = true,
            icon = "fa-solid fa-circle-user",
        },
    }
    QRCore.Functions.TriggerCallback('tcrp-wagons:server:GetWagon', function(cb)
        for _, v in pairs(cb) do
            GetWagon[#GetWagon + 1] = {
                header = v.name,
                txt = "Delete you wagon",
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "tcrp-wagons:client:MenuDelC",
                    args = {}
                }
            }
        end
        exports['qr-menu']:openMenu(GetWagon)
    end)
end)


RegisterNetEvent('tcrp-wagons:client:MenuDelC', function(data)
    local GetWagon = {
        {
            header = "| Confirm Delete Wagons |",
            isMenuHeader = true,
            icon = "fa-solid fa-circle-user",
        },
    }
    QRCore.Functions.TriggerCallback('tcrp-wagons:server:GetWagon', function(cb)
        for _, v in pairs(cb) do
            GetWagon[#GetWagon + 1] = {
                header = v.name,
                txt = "Doing this will make you lose your wagon forever!",
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "tcrp-wagons:client:DeleteWagon",
                    args = {
                        player = v,
                        active = 1
                    }
                }
            }
        end
        exports['qr-menu']:openMenu(GetWagon)
    end)
end)

RegisterNetEvent('tcrp-wagons:client:DeleteWagon', function(data)
    QRCore.Functions.Notify('Wagon has been successfully removed', 'success', 7500)
    TriggerServerEvent("tcrp-wagons:server:DelWagos", data.player.id)
end)

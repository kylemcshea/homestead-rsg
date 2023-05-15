local RSGCore = exports['rsg-core']:GetCoreObject()
local carthash = nil
local cargohash = nil
local lighthash = nil
local distance = nil
local wagonSpawned = false

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

-- prompts and blips
Citizen.CreateThread(function()
    for delivery, v in pairs(Config.DeliveryLocations) do
        exports['rsg-core']:createPrompt(v.deliveryid, v.startcoords, RSGCore.Shared.Keybinds['J'], v.name, {
            type = 'client',
            event = 'rsg-delivery:client:vehiclespawn',
            args = { v.deliveryid, v.cart, v.cartspawn, v.cargo, v.light, v.endcoords, v.showgps },
        })
        if v.showblip == true then
            local DeliveryBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.startcoords)
            SetBlipSprite(DeliveryBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(DeliveryBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, DeliveryBlip, Config.Blip.blipName)
        end
    end
end)

RegisterNetEvent('rsg-delivery:client:vehiclespawn')
AddEventHandler('rsg-delivery:client:vehiclespawn', function(deliveryid, cart, cartspawn, cargo, light, endcoords, showgps)
    if wagonSpawned == false then
        local playerPed = PlayerPedId()
        local carthash = GetHashKey(cart)
        local cargohash = GetHashKey(cargo)
        local lighthash = GetHashKey(light)
        local distance = GetDistanceBetweenCoords(cartspawn.x, cartspawn.y, cartspawn.z, endcoords.x, endcoords.y, endcoords.z) 
        local cashreward = (math.floor(distance) / 100)
        
        if Config.Debug == true then
            print('carthash '..carthash)
            print('cargohash '..cargohash)
            print('lighthash '..lighthash)
            print('distance '..distance)
            print('cashreward '..cashreward)
        end
        
        RequestModel(carthash, cargohash, lighthash)
        while not HasModelLoaded(carthash, cargohash, lighthash) do
            RequestModel(carthash, cargohash, lighthash)
            Citizen.Wait(0)
        end
        
        local coords = vector3(cartspawn.x, cartspawn.y, cartspawn.z)
        local heading = cartspawn.w
        local vehicle = CreateVehicle(carthash, coords, heading, true, false)
        SetVehicleOnGroundProperly(vehicle)
        Wait(200)
        SetModelAsNoLongerNeeded(carthash)
        Citizen.InvokeNative(0xD80FAF919A2E56EA, vehicle, cargohash)
        Citizen.InvokeNative(0xC0F0417A90402742, vehicle, lighthash)
        TaskEnterVehicle(playerPed, vehicle, 10000, -1, 1.0, 1, 0)
        if showgps == true then
            StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
            AddPointToGpsMultiRoute(endcoords)
            SetGpsMultiRouteRender(true)
        end
        wagonSpawned = true
        while true do
            local sleep = 1000
            if wagonSpawned == true then
                local vehpos = GetEntityCoords(vehicle, true)
                if #(vehpos - endcoords) < 250.0 then
                    sleep = 0
                    DrawText3D(endcoords.x, endcoords.y, endcoords.z + 0.98, "DELIVERY POINT")
                    if #(vehpos - endcoords) < 3.0 then
                        if showgps == true then
                            ClearGpsMultiRoute(endcoords)
                        end
                        endcoords = nil
                        DeleteVehicle(vehicle)
                        TriggerServerEvent('rsg-delivery:server:givereward', cashreward)
                        wagonSpawned = false
                    end
                end
            end
            Wait(sleep)
        end
    end
end)

local RSGCore = exports['rsg-core']:GetCoreObject()
local boatout = false

RegisterNetEvent('rsg-canoe:client:lauchcanoe')
AddEventHandler('rsg-canoe:client:lauchcanoe', function()
    local hasItem = RSGCore.Functions.HasItem('canoe', 1)
    if hasItem then
        if boatout == false then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x+3, coords.y+3, coords.z)
            local canLauch = false
            for k,v in pairs(Config.WaterTypes) do 
                if water == Config.WaterTypes[k]["waterhash"]  then
                    canLauch = true           
                    break            
                end
            end
            if canLauch then
                local ped = PlayerPedId()
                local canoe = `CANOE`
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 4.0, 0.5 ))
                local heading = GetEntityHeading(ped)
                RequestModel(canoe)
                while not HasModelLoaded(canoe) do
                    Citizen.Wait(500)
                end
                activeboat = CreateVehicle(canoe, x, y, z, heading, 1, 1)
                SetVehicleOnGroundProperly(activeboat)
                SetPedIntoVehicle(ped, activeboat, -1)
                SetModelAsNoLongerNeeded(canoe)
                boatout = true
            else
                RSGCore.Functions.Notify(Lang:t('error.cant_take_out_boat'), 'error')
            end
        else
            RSGCore.Functions.Notify(Lang:t('error.boat_already_out'), 'error')
        end
    else
        RSGCore.Functions.Notify(Lang:t('error.no_item'), 'error')
    end
end)

-- delete canoe
RegisterCommand('delcanoe', function()
    SetEntityAsMissionEntity(activeboat, true, true)
    DeleteVehicle(activeboat)
    boatout = false
end)

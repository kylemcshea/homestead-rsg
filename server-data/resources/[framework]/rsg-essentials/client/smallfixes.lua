local RSGCore = exports['rsg-core']:GetCoreObject()
local PauseOpen = false

-- ped drown / boat sink fix
Citizen.CreateThread(function()
    while true do
        Wait(0)
        Citizen.InvokeNative(0xC1E8A365BF3B29F2, PlayerPedId(), 364)   -- PRF_IgnoreDrownAndKillVolumes
    end
end)

-- change voice proximity
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, RSGCore.Shared.Keybinds['RIGHTBRACKET']) then
            ExecuteCommand('cycleproximity')
        end
    end
end)

-- wagon stuck fix thanks to : https://github.com/BryceCanyonCounty/bcc-vehiclefixes/blob/main/client/wagons.lua
Citizen.CreateThread(function()
    local vehiclePool = {}
    local wagon = 0
    local driver = 0
    local horse = 0
    while true do
        vehiclePool = GetGamePool('CVehicle') -- Get the list of vehicles (entities) from the pool
        for i = 1, #vehiclePool do -- loop through each vehicle (entity)
            wagon = vehiclePool[i]
            -- Is wagon stopped
            if IsEntityAVehicle(wagon) and IsVehicleStopped(wagon) then
                -- Get the horse
                horse = Citizen.InvokeNative(0xA8BA0BAE0173457B,wagon,0)
                -- If vehicle stopped but the horse walks = buggy wagon
                if IsPedWalking(horse) then
                    -- Delete driver & wagon
                    driver = Citizen.InvokeNative(0x2963B5C1637E8A27,wagon)
                    if driver ~= PlayerPedId() then -- Ensure the driver is not a player
                        if driver then
                            DeleteEntity(driver) -- Delete driver from wagon if there is one
                        end
                        DeleteEntity(wagon) -- Delete buggy wagon
                    end
                end
            end
        end
        Wait(1000)
    end
end)

-- pause menu animation thanks to ManLikeTJB#4518
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if IsPauseMenuActive() and not PauseOpen then
            SetCurrentPedWeapon(ped, 0xA2719263, true) -- set unarmed
            SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"))
            if not IsPedOnMount(ped) then
                TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_READING_BOOK"), -1, true, "StartScenario", 0, false)
            end
            PauseOpen = true
        end

        if not IsPauseMenuActive() and PauseOpen then
            ClearPedTasks(ped)
            Wait(4000)
            SetCurrentPedWeapon(ped, 0xA2719263, true) -- set unarmed
            SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"))
            PauseOpen = false
        end
    end
end)

local RSGCore = exports['rsg-core']:GetCoreObject()
local contrabandselling = false
local hasTarget = false
local startLocation = nil
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableContraband = {}
local currentOfferContraband = nil
local CurrentLawmen = 0

RegisterCommand('sellcontraband', function(source)
    TriggerEvent('rsg-contraband:client:contrabandselling')
end)

RegisterNetEvent('rsg-contraband:client:contrabandselling', function()
    RSGCore.Functions.TriggerCallback('police:GetCops', function(lawmen)
        CurrentLawmen = lawmen
        if CurrentLawmen >= Config.MinimumLawmen then
            RSGCore.Functions.TriggerCallback('rsg-contraband:server:contrabandselling:getAvailableContraband', function(result)
                if result ~= nil then
                    availableContraband = result
                    if not contrabandselling then
                        contrabandselling = true
                        LocalPlayer.state:set("inv_busy", true, true)
                        RSGCore.Functions.Notify('started selling contraband', 'primary')
                        startLocation = GetEntityCoords(PlayerPedId())
                    else
                        contrabandselling = false
                        LocalPlayer.state:set("inv_busy", false, true)
                        RSGCore.Functions.Notify('stopped selling contraband', 'primary')
                    end
                else
                    RSGCore.Functions.Notify('no contraband to sell!', 'error')
                    LocalPlayer.state:set("inv_busy", false, true)
                end
            end)
        else
            RSGCore.Functions.Notify('not enough lawmen on duty!', 'error')
        end
    end)
end)

RegisterNetEvent('rsg-contraband:client:refreshAvailableContraband', function(items)
    availableContraband = items
    if #availableContraband <= 0 then
        RSGCore.Functions.Notify('no contraband left to sell!', 'error')
        contrabandselling = false
        LocalPlayer.state:set("inv_busy", false, true)
    end
end)

local function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

local function loadAnimDict(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function toFarAway()
    RSGCore.Functions.Notify('you moved too far away!', 'error')
    LocalPlayer.state:set("inv_busy", false, true)
    contrabandselling = false
    hasTarget = false
    startLocation = nil
    availableContraband = {}
    Wait(5000)
end

local function SellToPed(ped)
    hasTarget = true
    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            hasTarget = false
            return
        end
    end

    local succesChance = math.random(1, 20)

    local scamChance = math.random(1, 5)

    local getRobbed = math.random(1, 20)

    if succesChance <= 7 then
        hasTarget = false
        return
    elseif succesChance >= 19 then
        local sellcoords = GetEntityCoords(PlayerPedId())
        hasTarget = false
        return
    end

    local contrabandType = math.random(1, #availableContraband)
    local contrabandAmount = math.random(1, availableContraband[contrabandType].amount)

    if contrabandAmount > 3 then
        contrabandAmount = math.random(1, 3)
    end
    
    currentOfferContraband = availableContraband[contrabandType]

    local ddata = Config.ContrabandPrice[currentOfferContraband.item]
    local randomPrice = math.random(ddata.min, ddata.max) * contrabandAmount
    if scamChance == 5 then
       randomPrice = math.random(ddata.scammin, ddata.scammax) * contrabandAmount
    end

    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)

    local coords = GetEntityCoords(PlayerPedId(), true)
    local pedCoords = GetEntityCoords(ped)
    local pedDist = #(coords - pedCoords)

    if getRobbed == 18 or getRobbed == 9 then
        TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
    else
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
    end

    while pedDist > 1.5 do
        coords = GetEntityCoords(PlayerPedId(), true)
        pedCoords = GetEntityCoords(ped)
        if getRobbed == 18 or getRobbed == 9 then
            TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
        else
            TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        end
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        pedDist = #(coords - pedCoords)

        Wait(100)
    end

    TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WAITING_IMPATIENT", 0, false)

    if hasTarget then
        while pedDist < 1.5 and not IsPedDeadOrDying(ped) do
            coords = GetEntityCoords(PlayerPedId(), true)
            pedCoords = GetEntityCoords(ped)
            pedDist = #(coords - pedCoords)
            if getRobbed == 18 or getRobbed == 9 then
                TriggerServerEvent('rsg-contraband:server:robContraband', availableContraband[contrabandType].item, contrabandAmount)
                RSGCore.Functions.Notify('you have been robbed!', 'primary')
                stealingPed = ped
                stealData = {
                    item = availableContraband[contrabandType].item,
                    amount = contrabandAmount,
                }
                hasTarget = false
                local moveto = GetEntityCoords(PlayerPedId())
                local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
                ClearPedTasksImmediately(ped)
                TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
                startLocation = GetEntityCoords(PlayerPedId())
                lastPed[#lastPed+1] = ped
                break
            else
                if pedDist < 1.5 and contrabandselling then
                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 0.3, "Sell "..contrabandAmount.." for $" .. randomPrice)
                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 0.15, "[G] Confirm")
                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, "[B] Decline")
                    if IsControlJustPressed(0, 0x5415BE48) then
                        local randomNumber = math.random(1,100)
                        if randomNumber > 80 then -- 20% chance of calling the law
                            TriggerServerEvent('police:server:policeAlert', 'contraband being sold')
                        end
                        TriggerServerEvent('rsg-contraband:server:sellContraband', availableContraband[contrabandType].item, contrabandAmount, randomPrice)
                        hasTarget = false
                        -- animation here
                        SetPedKeepTask(ped, false)
                        SetEntityAsNoLongerNeeded(ped)
                        ClearPedTasksImmediately(ped)
                        startLocation = GetEntityCoords(PlayerPedId())
                        lastPed[#lastPed+1] = ped
                        break
                    end

                    if IsControlJustPressed(0, 0x4CC0E2FE) then
                        RSGCore.Functions.Notify('offer declined', 'primary')
                        hasTarget = false
                        SetPedKeepTask(ped, false)
                        SetEntityAsNoLongerNeeded(ped)
                        ClearPedTasksImmediately(ped)
                        startLocation = GetEntityCoords(PlayerPedId())
                        lastPed[#lastPed+1] = ped
                        break
                    end
                else
                    hasTarget = false
                    pedDist = 5
                    SetPedKeepTask(ped, false)
                    SetEntityAsNoLongerNeeded(ped)
                    ClearPedTasksImmediately(ped)
                    startLocation = GetEntityCoords(PlayerPedId())
                    lastPed[#lastPed+1] = ped
                    contrabandselling = false
                end
            end
            Wait(3)
        end
        Wait(math.random(4000, 7000))
    end
end

CreateThread(function()
    while true do
        local sleep = 1000
        if stealingPed ~= nil and stealData ~= nil then
            sleep = 0
            if IsEntityDead(stealingPed) then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local pedpos = GetEntityCoords(stealingPed)
                if #(pos - pedpos) < 1.5 then
                    DrawText3D(pedpos.x, pedpos.y, pedpos.z, Lang:t("info.pick_up_button"))
                    if IsControlJustPressed(0, 0x018C47CF) then
                        RequestAnimDict("pickup_object")
                        while not HasAnimDictLoaded("pickup_object") do
                            Wait(0)
                        end
                        TaskPlayAnim(ped, "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        Wait(2000)
                        ClearPedTasks(ped)
                        TriggerServerEvent("RSGCore:Server:AddItem", stealData.item, stealData.amount)
                        TriggerEvent('inventory:client:ItemBox', RSGCore.Shared.Items[stealData.item], "add")
                        stealingPed = nil
                        stealData = {}
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if contrabandselling then
            sleep = 0
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if not hasTarget then
                local PlayerPeds = {}
                if next(PlayerPeds) == nil then
                    for _, activePlayer in ipairs(GetActivePlayers()) do
                        local ped = GetPlayerPed(activePlayer)
                        PlayerPeds[#PlayerPeds+1] = ped
                    end
                end
                local closestPed, closestDistance = RSGCore.Functions.GetClosestPed(coords, PlayerPeds)
                if closestDistance < 15.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) and GetPedType(closestPed) ~= 28 then
                    SellToPed(closestPed)
                end
            end
            local startDist = #(startLocation - coords)
            if startDist > 10 then
                toFarAway()
            end
        end
        Wait(sleep)
    end
end)

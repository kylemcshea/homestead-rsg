local Action = {
    name = "",
    duration = 0,
    label = "",
    useWhileDead = false,
    canCancel = true,
	disarm = true,
    controlDisables = {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },
    animation = {
        animDict = nil,
        anim = nil,
        flags = 0,
        task = nil,
    },
    prop = {
        model = nil,
        bone = nil,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    },
    propTwo = {
        model = nil,
        bone = nil,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    },
}

local isDoingAction = false
local disableMouse = false
local wasCancelled = false
local isAnim = false
local isProp = false
local isPropTwo = false
local prop_net = nil
local propTwo_net = nil
local runProgThread = false
local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('progressbar:client:ToggleBusyness')
AddEventHandler('progressbar:client:ToggleBusyness', function(bool)
    isDoingAction = bool
end)

function Progress(action, finish)
	Process(action, nil, nil, finish)
end

function ProgressWithStartEvent(action, start, finish)
	Process(action, start, nil, finish)
end

function ProgressWithTickEvent(action, tick, finish)
	Process(action, nil, tick, finish)
end

function ProgressWithStartAndTick(action, start, tick, finish)
	Process(action, start, tick, finish)
end

function Process(action, start, tick, finish)
	ActionStart()
    Action = action
    local ped = PlayerPedId()
    if not IsEntityDead(ped) or Action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "progress",
                duration = Action.duration,
                label = Action.label
            })

            Citizen.CreateThread(function ()
                if start ~= nil then
                    start()
                end
                while isDoingAction do
                    Citizen.Wait(1)
                    if tick ~= nil then
                        tick()
                    end
                    if IsControlJustPressed(0, RSGCore.Shared.Keybinds['ESC']) and Action.canCancel then
                        TriggerEvent("progressbar:client:cancel")
                    end

                    if IsEntityDead(ped) and not Action.useWhileDead then
                        TriggerEvent("progressbar:client:cancel")
                    end
                end
                if finish ~= nil then
                    finish(wasCancelled)
                end
            end)
        else
            TriggerEvent("RSGCore:Notify", "You are already doing something!", "error")
        end
    else
        TriggerEvent("RSGCore:Notify", "Cant do that action!", "error")
    end
end

function ActionStart()
    runProgThread = true
    LocalPlayer.state:set("inv_busy", true, true) -- Busy
    Citizen.CreateThread(function()
        while runProgThread do
            if isDoingAction then
                if not isAnim then
                    if Action.animation ~= nil then
                        if Action.animation.task ~= nil then
                            TaskStartScenarioInPlace(PlayerPedId(), Action.animation.task, 0, true)
                        elseif Action.animation.animDict ~= nil and Action.animation.anim ~= nil then
                            if Action.animation.flags == nil then
                                Action.animation.flags = 1
                            end

                            local player = PlayerPedId()
                            if (DoesEntityExist(player) and not IsEntityDead(player)) then
                                loadAnimDict( Action.animation.animDict)
                                TaskPlayAnim(player, Action.animation.animDict, Action.animation.anim, 3.0, 3.0, -1, Action.animation.flags, 0, 0, 0, 0 )     
                            end
                        else
                            --TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                        end
                    end

                    isAnim = true
                end
                if not isProp and Action.prop ~= nil and Action.prop.model ~= nil then
                    local ped = PlayerPedId()
                    RequestModel(Action.prop.model)

                    while not HasModelLoaded(GetHashKey(Action.prop.model)) do
                        Citizen.Wait(0)
                    end

                    local pCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 0.0)
                    local modelSpawn = CreateObject(GetHashKey(Action.prop.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)

                    local netid = ObjToNet(modelSpawn)
                    SetNetworkIdExistsOnAllMachines(netid, true)
                    NetworkSetNetworkIdDynamic(netid, true)
                    SetNetworkIdCanMigrate(netid, false)
                    if Action.prop.bone == nil then
                        Action.prop.bone = 60309
                    end

                    if Action.prop.coords == nil then
                        Action.prop.coords = { x = 0.0, y = 0.0, z = 0.0 }
                    end

                    if Action.prop.rotation == nil then
                        Action.prop.rotation = { x = 0.0, y = 0.0, z = 0.0 }
                    end

                    AttachEntityToEntity(modelSpawn, ped, GetPedBoneIndex(ped, Action.prop.bone), Action.prop.coords.x, Action.prop.coords.y, Action.prop.coords.z, Action.prop.rotation.x, Action.prop.rotation.y, Action.prop.rotation.z, 1, 1, 0, 1, 0, 1)
                    prop_net = netid

                    isProp = true
                    
                    if not isPropTwo and Action.propTwo ~= nil and Action.propTwo.model ~= nil then
                        RequestModel(Action.propTwo.model)

                        while not HasModelLoaded(GetHashKey(Action.propTwo.model)) do
                            Citizen.Wait(0)
                        end

                        local pCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 0.0)
                        local modelSpawn = CreateObject(GetHashKey(Action.propTwo.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)

                        local netid = ObjToNet(modelSpawn)
                        SetNetworkIdExistsOnAllMachines(netid, true)
                        NetworkSetNetworkIdDynamic(netid, true)
                        SetNetworkIdCanMigrate(netid, false)
                        if Action.propTwo.bone == nil then
                            Action.propTwo.bone = 60309
                        end

                        if Action.propTwo.coords == nil then
                            Action.propTwo.coords = { x = 0.0, y = 0.0, z = 0.0 }
                        end

                        if Action.propTwo.rotation == nil then
                            Action.propTwo.rotation = { x = 0.0, y = 0.0, z = 0.0 }
                        end

                        AttachEntityToEntity(modelSpawn, ped, GetPedBoneIndex(ped, Action.propTwo.bone), Action.propTwo.coords.x, Action.propTwo.coords.y, Action.propTwo.coords.z, Action.propTwo.rotation.x, Action.propTwo.rotation.y, Action.propTwo.rotation.z, 1, 1, 0, 1, 0, 1)
                        propTwo_net = netid

                        isPropTwo = true
                    end
                end

                DisableActions(ped)
            end
            Citizen.Wait(0)
        end
    end)
end

function Cancel()
    isDoingAction = false
    wasCancelled = true
    LocalPlayer.state:set("inv_busy", false, true) -- Not Busy
    ActionCleanup()

    SendNUIMessage({
        action = "cancel"
    })
end

function Finish()
    isDoingAction = false
    ActionCleanup()
    LocalPlayer.state:set("inv_busy", false, true) -- Not Busy
end

function ActionCleanup()
    local ped = PlayerPedId()

    if Action.animation ~= nil then
        if Action.animation.task ~= nil or (Action.animation.animDict ~= nil and Action.animation.anim ~= nil) then
            ClearPedSecondaryTask(ped)
            StopAnimTask(ped, Action.animDict, Action.anim, 1.0)
        else
            ClearPedTasks(ped)
        end
    end

    runProgThread = false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DisableActions(ped)
    if Action.controlDisables.disableMouse then
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xA987235F, true) -- LookLeftRight
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xD2047988, true) -- LookUpDown
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x39CCABD5, true) -- VehicleMouseControlOverride
    end

    if Action.controlDisables.disableMovement then
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x4D8FB4C1, true) -- disable left/right
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xFDA83190, true) -- disable forward/back
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xDB096B85, true) -- INPUT_DUCK
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x8FFC75D6, true) -- disable sprint
    end

    if Action.controlDisables.disableCarMovement then
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x9DF54706, true) -- veh turn left
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x97A8FD98, true) -- veh turn right
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x5B9FD4E2, true) -- veh forward
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x6E1F639B, true) -- veh backwards
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xFEFAB9B4, true) -- disable exit vehicle
    end

    if Action.controlDisables.disableCombat then
        Citizen.InvokeNative(0x2970929FD5F9FC89, PlayerId(), true) -- Disable weapon firing
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x07CE1E61, true) -- disable attack
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xF84FA74F, true) -- disable aim
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xAC4BD4F1, true) -- disable weapon select
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x73846677, true) -- disable weapon
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x0AF99998, true) -- disable weapon
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xB2F377E8, true) -- disable melee
        Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xADEAF48C, true) -- disable melee
    end
end

RegisterNetEvent("progressbar:client:progress")
AddEventHandler("progressbar:client:progress", function(action, finish)
	Process(action, nil, nil, finish)
end)

RegisterNetEvent("progressbar:client:ProgressWithStartEvent")
AddEventHandler("progressbar:client:ProgressWithStartEvent", function(action, start, finish)
	Process(action, start, nil, finish)
end)

RegisterNetEvent("progressbar:client:ProgressWithTickEvent")
AddEventHandler("progressbar:client:ProgressWithTickEvent", function(action, tick, finish)
	Process(action, nil, tick, finish)
end)

RegisterNetEvent("progressbar:client:ProgressWithStartAndTick")
AddEventHandler("progressbar:client:ProgressWithStartAndTick", function(action, start, tick, finish)
	Process(action, start, tick, finish)
end)

RegisterNetEvent("progressbar:client:cancel")
AddEventHandler("progressbar:client:cancel", function()
	Cancel()
end)

RegisterNUICallback('FinishAction', function(data, cb)
	Finish()
end)

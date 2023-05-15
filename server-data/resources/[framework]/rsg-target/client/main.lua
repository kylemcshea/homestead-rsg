local RSGCore = exports['rsg-core']:GetCoreObject()
local Config, Players, Types, Entities, Models, Zones, Bones, PlayerData = load(LoadResourceFile(GetCurrentResourceName(), 'config.lua'))()
local playerPed, isLoggedIn, targetActive, hasFocus, success, curFlag, sendData = PlayerPedId(), false, false, false, false, 30

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded')
AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    PlayerData = RSGCore.Functions.GetPlayerData()
    isLoggedIn = true
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload')
AddEventHandler('RSGCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    PlayerData = {}
end)

RegisterNetEvent('RSGCore:Client:OnJobUpdate')
AddEventHandler('RSGCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('RSGCore:Client:SetPlayerData')
AddEventHandler('RSGCore:Client:SetPlayerData', function(val)
    PlayerData = val
end)

--Functions

local Functions = {
    AddCircleZone = function(self, name, center, radius, options, targetoptions)
        Zones[name] = CircleZone:Create(center, radius, options)
        Zones[name].targetoptions = targetoptions
    end,

    AddBoxZone = function(self, name, center, length, width, options, targetoptions)
        Zones[name] = BoxZone:Create(center, length, width, options)
        Zones[name].targetoptions = targetoptions
    end,

    AddPolyzone = function(self, name, points, options, targetoptions)
        Zones[name] = PolyZone:Create(points, options)
        Zones[name].targetoptions = targetoptions
    end,

    AddTargetBone = function(self, bones, parameters)
        if type(bones) == 'table' then
            for _, bone in pairs(bones) do
                Bones[bone] = parameters
            end
        elseif type(bones) == 'string' then
            Bones[bones] = parameters
        end
    end,

    AddTargetEntity = function(self, entity, parameters)
        if NetworkGetEntityIsNetworked(entity) then entity = NetworkGetNetworkIdFromEntity(entity) end -- Allow non-networked entities to be targeted
        --print(entity)
        if entity then
            local distance, options = parameters.distance or Config.MaxDistance, parameters.options
            --print(distance)
            if not Entities[entity] then Entities[entity] = {} end
            for k, v in pairs(options) do
                if not v.distance or v.distance > distance then v.distance = distance end
                Entities[entity][v.label] = v
            end
        end
    end,

    AddEntityZone = function(self, name, entity, options, targetoptions)
        Zones[name] = EntityZone:Create(entity, options)
        Zones[name].targetoptions = targetoptions
    end,

    AddTargetModel = function(self, models, parameters)
        local distance, options = parameters.distance or Config.MaxDistance, parameters.options
        local model
        if type(models) == 'table' then
            for _, model in pairs(models) do
                if type(model) == 'string' then model = GetHashKey(model) end
                if not Models[model] then Models[model] = {} end
                for k, v in pairs(options) do
                    if not v.distance or v.distance > distance then v.distance = distance end
                    Models[model][v.label] = v
                end
            end
        else
            if type(models) == 'string' then model = GetHashKey(models) else model = models end
            if not Models[model] then Models[model] = {} end
            for k, v in pairs(options) do
                if not v.distance or v.distance > distance then v.distance = distance end
                Models[model][v.label] = v
            end
        end
    end,

    RemoveZone = function(self, name)
        if not Zones[name] then return end
        if Zones[name].destroy then
            Zones[name]:destroy()
        end
        Zones[name] = nil
    end,

    RemoveTargetModel = function(self, models, labels)
        local model
        if type(models) == 'table' then
            for _, model in pairs(models) do
                if type(model) == 'string' then model = GetHashKey(model) end
                if type(labels) == 'table' then
                    for k, v in pairs(labels) do
                        if Models[model] then
                            Models[model][v] = nil
                        end
                    end
                elseif type(labels) == 'string' then
                    if Models[model] then
                        Models[model][labels] = nil
                    end
                end
            end
        else
            if type(models) == 'string' then model = GetHashKey(model) else model = models end
            if type(labels) == 'table' then
                for k, v in pairs(labels) do
                    if Models[model] then
                        Models[model][v] = nil
                    end
                end
            elseif type(labels) == 'string' then
                if Models[model] then
                    Models[model][labels] = nil
                end
            end
        end
    end,

    RemoveTargetEntity = function(self, entity, labels)
        if NetworkGetEntityIsNetworked(entity) then entity = NetworkGetNetworkIdFromEntity(entity) end -- Allow non-networked entities to be targeted
        if entity then
            if type(labels) == 'table' then
                for k, v in pairs(labels) do
                    if Entities[entity] then
                        Entities[entity][v] = nil
                    end
                end
            elseif type(labels) == 'string' then
                if Entities[entity] then
                    Entities[entity][labels] = nil
                end
            end
        end
    end,

    AddType = function(self, type, parameters)
        local distance, options = parameters.distance or Config.MaxDistance, parameters.options
        for k, v in pairs(options) do
            if not v.distance or v.distance > distance then v.distance = distance end
            Types[type][v.label] = v
        end
    end,

    AddPed = function(self, parameters) self:AddType(1, parameters) end,

    AddVehicle = function(self, parameters) self:AddType(2, parameters) end,

    AddObject = function(self, parameters) self:AddType(3, parameters) end,

    AddPlayer = function(self, parameters)
        local distance, options = parameters.distance or Config.MaxDistance, parameters.options
        for k, v in pairs(options) do
            if not v.distance or v.distance > distance then v.distance = distance end
            Players[v.label] = v
        end
    end,

    RemoveType = function(self, type, labels)
        for k, v in pairs(labels) do
            Types[type][v] = nil
        end
    end,

    RemovePed = function(self, labels) self:RemoveType(1, labels) end,

    RemoveVehicle = function(self, labels) self:RemoveType(2, labels) end,

    RemoveObject = function(self, labels) self:RemoveType(3, labels) end,

    RemovePlayer = function(self, labels)
        if type(labels) == 'table' then
            for k, v in pairs(labels) do
                Players[v.label] = nil
            end
        elseif type(labels) == 'string' then
            Players[labels] = nil
        end
    end,

    RaycastCamera = function(self, flag)
        local cam = GetGameplayCamCoord()
        local direction = GetGameplayCamRot()
        direction = vec2(math.rad(direction.x), math.rad(direction.z))
        local num = math.abs(math.cos(direction.x))
        direction = vec3((-math.sin(direction.y) * num), (math.cos(direction.y) * num), math.sin(direction.x))
        local destination = vec3(cam.x + direction.x * 30, cam.y + direction.y * 30, cam.z + direction.z * 30)
        local rayHandle = StartShapeTestLosProbe(cam, destination, flag or -1, playerPed or PlayerPedId(), 0)
        while true do
            Wait(5)
            local result, _, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
            if Config.Debug then
                local entCoords = GetEntityCoords(playerPed or PlayerPedId())
                DrawLine(entCoords.x, entCoords.y, entCoords.z, destination.x, destination.y, destination.z, 255, 0, 255, 255)
                DrawLine(destination.x, destination.y, destination.z, endCoords.x, endCoords.y, endCoords.z, 255, 0, 255, 255)
            end
            if result ~= 1 then
                local entityType = 0
                if entityHit then entityType = GetEntityType(entityHit) end
                return flag, endCoords, entityHit, entityType
            end
        end
    end,
    IsTargetActive = function(self)
        return targetActive
    end,
    IsTargetSuccess = function(self)
        return success
    end,
    GetTargetTypeData = function(self, type, label)
        return Types[type][label]
    end,
    GetTargetZoneData = function(self, name)
        return Zones[name]
    end,
    GetTargetBoneData = function(self, bone)
        return Bones[bone]
    end,
    GetTargetEntityData = function(self, entity, label)
        return Entities[entity][label]
    end,
    GetTargetModelData = function(self, model, label)
        return Models[model][label]
    end,
    GetTargetPedData = function(self, label)
        return Types[1][label]
    end,
    GetTargetVehicleData = function(self, label)
        return Types[2][label]
    end,
    GetTargetObjectData = function(self, label)
        return Types[3][label]
    end,
    GetTargetPlayerData = function(self, label)
        return Players[label]
    end,
    CloneTable = function(self, table)
        local copy = {}
        if table ~= nil then
            for k,v in pairs(table) do
                if type(v) == 'table' then
                    copy[k] = self:CloneTable(v)
                else
                    if type(v) == 'function' then v = nil end
                    copy[k] = v
                end
            end
        end
        return copy
    end,
    CheckOptions = function(self, data, entity, distance)
        if (data.distance == nil or distance <= data.distance)
        and (data.job == nil or data.job == PlayerData.job.name or (data.job[PlayerData.job.name] and data.job[PlayerData.job.name] <= PlayerData.job.grade.level))
        and (data.item == nil or data.item and self:ItemCount(data.item) > 0)
        and (data.canInteract == nil or data.canInteract(entity)) then return true
        end
        return false
    end,
    switch = function(self)
        if curFlag == 30 then curFlag = -1 else curFlag = 30 end
        return curFlag
    end,
    EnableTarget = function(self)
        if success or not isLoggedIn then return end
        if not targetActive then
            targetActive = true
            SendNUIMessage({response = "openTarget"})

            CreateThread(function()
                repeat
                    if hasFocus then
                        DisableControlAction(0, 0xA987235F, true) --  MOUSE MOVE RIGHT
                        DisableControlAction(0, 0xD2047988, true) -- MOUSE MOVE DOWN
                    end
                    --Citizen.InvokeNative(0x2970929FD5F9FC89, PlayerId(), true) -- Disable weapon firing
                    --Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x07CE1E61, true) -- disable attack
                    --Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xF84FA74F, true) -- disable aim
                    --Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xAC4BD4F1, true) -- disable weapon select
                    --Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x73846677, true) -- disable weapon
                    --Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0x0AF99998, true) -- disable weapon
                    --Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xB2F377E8, true) -- disable melee
                    --Citizen.InvokeNative(0xFE99B66D079CF6BC, 0, 0xADEAF48C, true) -- disable melee
                    Wait(5)
                until not targetActive
            end)
            playerPed = PlayerPedId()
            PlayerData = RSGCore.Functions.GetPlayerData()

            while targetActive do
                local sleep = 10
                local plyCoords = GetEntityCoords(playerPed)
                local hit, coords, entity, entityType = self:RaycastCamera(self:switch())
                if entityType > 0 then

                    -- Local entity targets
                    if Entities[entity] then
                        self:CheckEntity(hit, Entities[entity], entity, #(plyCoords - coords))
                    end

                    -- Owned entity targets
                    if NetworkGetEntityIsNetworked(entity) then
                        local data = Entities[NetworkGetNetworkIdFromEntity(entity)]
                        if data ~= nil then
                            self:CheckEntity(hit, data, entity, #(plyCoords - coords))
                        end
                    end

                    -- Player and Ped targets
                    if entityType == 1 then
                        local data = Models[GetEntityModel(entity)]
                        if IsPedAPlayer(entity) then data = Players end
                        if data ~= nil then
                            self:CheckEntity(hit, data, entity, #(plyCoords - coords))
                        end

                    -- Vehicle bones
                    elseif entityType == 2 then
                        local min, max = GetModelDimensions(GetEntityModel(entity))
                        local closestBone, closestPos, closestBoneName = self:CheckBones(coords, entity, min, max, Config.VehicleBones)
                        local data = Bones[closestBoneName]
                        if closestBone and #(plyCoords - coords) <= data.distance then
                            local send_options, slot = {}, 0
                            for o, data in pairs(data.options) do
                                if self:CheckOptions(data, entity) then
                                    slot = #send_options + 1
                                    send_options[slot] = data
                                    send_options[slot].entity = entity
                                end
                            end
                            sendData = send_options
                            if next(send_options) then
                                success = true
                                SendNUIMessage({response = "foundTarget", data = sendData[slot].targeticon})
                                self:DrawOutlineEntity(entity, false)
                                while targetActive and success do
                                    local playerCoords = GetEntityCoords(playerPed)
                                    local _, coords, entity2 = self:RaycastCamera(hit)
                                    if hit and entity == entity2 then
                                        local closestBone2, closestPos2, closestBoneName2 = self:CheckBones(coords, entity, min, max, Config.VehicleBones)

                                        if closestBone ~= closestBone2 then
                                            if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                                self:DisableTarget(true)
                                            else
                                                self:LeftTarget()
                                            end
                                            self:DrawOutlineEntity(entity, false)
                                            break
                                        elseif not hasFocus and IsDisabledControlPressed(0, RSGCore.Shared.Keybinds['MOUSE1']) then
                                            self:EnableNUI(self:CloneTable(sendData))
                                            self:DrawOutlineEntity(entity, false)
                                        elseif #(playerCoords - coords) > data.distance then
                                            if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                                self:DisableTarget(true)
                                            else
                                                self:LeftTarget()
                                            end
                                            self:DrawOutlineEntity(entity, false)
                                        end
                                    else
                                        if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                            self:DisableTarget(true)
                                        else
                                            self:LeftTarget()
                                        end
                                        self:DrawOutlineEntity(entity, false)
                                        break
                                    end
                                    Wait(5)
                                end
                                if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                    self:DisableTarget(true)
                                else
                                    self:LeftTarget()
                                end
                                self:DrawOutlineEntity(entity, false)
                            end
                        end

                        -- Specific Vehicle targets
                        local data = Models[GetEntityModel(entity)]
                        if data ~= nil then
                            self:CheckEntity(hit, data, entity, #(plyCoords - coords))
                        end

                    -- Entity targets
                    elseif entityType > 2 then
                        local data = Models[GetEntityModel(entity)]
                        if data ~= nil then
                            self:CheckEntity(hit, data, entity, #(plyCoords - coords))

                            if Config.EnableObjectHighlight then
                                Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)
                            end
                        end
                    end

                    -- Generic targets
                    if not success then
                        local data = Types[entityType]
                        if data ~= nil then
                            self:CheckEntity(hit, data, entity, #(plyCoords - coords))
                        end
                    end
                end
                if not success then
                    -- Zone targets
                    for _,zone in pairs(Zones) do
                        local distance = #(plyCoords - zone.center)
                        if zone:isPointInside(coords) and distance <= zone.targetoptions.distance then
                            local send_options, slot = {}, 0
                            for o, data in pairs(zone.targetoptions.options) do
                                if self:CheckOptions(data, entity, distance) then
                                    slot = #send_options + 1
                                    send_options[slot] = data
                                    send_options[slot].entity = entity
                                end
                            end
                            sendData = send_options
                            if next(send_options) then
                                success = true
                                SendNUIMessage({response = "foundTarget", data = sendData[slot].targeticon})
                                self:DrawOutlineEntity(entity, true)
                                while targetActive and success do
                                    local playerCoords = GetEntityCoords(playerPed)
                                    local _, coords, entity2 = self:RaycastCamera(hit)
                                    if not zone:isPointInside(coords) then
                                        if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                            self:DisableTarget(true)
                                        else
                                            self:LeftTarget()
                                        end
                                        self:DrawOutlineEntity(entity, false)
                                    elseif not hasFocus and IsDisabledControlPressed(0, RSGCore.Shared.Keybinds['MOUSE1']) then
                                        self:EnableNUI(self:CloneTable(sendData))
                                        self:DrawOutlineEntity(entity, false)
                                    elseif #(playerCoords - zone.center) > zone.targetoptions.distance then
                                        if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                            self:DisableTarget(true)
                                        else
                                            self:LeftTarget()
                                        end
                                        self:DrawOutlineEntity(entity, false)
                                    end
                                    Wait(5)
                                end
                                if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                    self:DisableTarget(true)
                                else
                                    self:LeftTarget()
                                end
                                self:DrawOutlineEntity(entity, false)
                            end
                        end
                    end
                end
                Wait(sleep)
            end
            self:DisableTarget(false)
        end
    end,
    EnableNUI = function(self, options)

        if targetActive and not hasFocus then
            SetCursorLocation(0.5, 0.5)
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(false)
            hasFocus = true
            SendNUIMessage({response = "validTarget", data = options})
        end
    end,
    DisableNUI = function(self)
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        hasFocus = false
    end,
    LeftTarget = function(self)
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        success, hasFocus = false, false
        SendNUIMessage({response = "leftTarget"})
    end,
    DisableTarget = function(self, disablenui)
        if (targetActive and not hasFocus) or disablenui then
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
            targetActive, hasFocus, success = false, false, false
            SendNUIMessage({response = "closeTarget"})
        end
    end,
    ItemCount = function(self, item)
        for k, v in pairs(PlayerData.items) do
            if v.name == item then
                return v.amount
            end
        end
        return 0
    end,
    DrawOutlineEntity = function(self, entity, bool)
        if Config.EnableOutline then
            if not IsEntityAPed(entity) then
                SetEntityDrawOutline(entity, bool)
            end
        end
    end,
    CheckEntity = function(self, hit, data, entity, distance)
        local send_options, send_distance, slot = {}, {}, 0
        for o, data in pairs(data) do
            if self:CheckOptions(data, entity, distance) then
                slot = #send_options + 1
                send_options[slot] = data
                send_options[slot].entity = entity
                send_distance[data.distance] = true
            else send_distance[data.distance] = false end
        end
        sendData = send_options
        if next(send_options) then
            success = true
            SendNUIMessage({response = "foundTarget", data = sendData[slot].targeticon})
            self:DrawOutlineEntity(entity, true)
            while targetActive and success do
                local playerCoords = GetEntityCoords(playerPed)
                local _, coords, entity2 = self:RaycastCamera(hit)
                local distance = #(playerCoords - coords)
                if entity ~= entity2 then
                    if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                        self:DisableTarget(true)
                    else
                        self:LeftTarget()
                    end
                    self:DrawOutlineEntity(entity, false)
                    break
                elseif not hasFocus and IsDisabledControlPressed(0, RSGCore.Shared.Keybinds['MOUSE1']) then
                    self:EnableNUI(self:CloneTable(sendData))
                    self:DrawOutlineEntity(entity, false)
                else
                    for k, v in pairs(send_distance) do
                        if v and distance > k then
                            if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                                self:DisableTarget(true)
                            else
                                self:LeftTarget()
                            end
                            self:DrawOutlineEntity(entity, false)
                            break
                        end
                    end
                end
                Wait(5)
            end
            if IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                self:DisableTarget(true)
            else
                self:LeftTarget()
            end
            self:DrawOutlineEntity(entity, false)
        end
    end,
    CheckBones = function(self, coords, entity, min, max, bonelist)
        local closestBone, closestDistance, closestPos, closestBoneName = -1, 20
        for k, v in pairs(bonelist) do
            local coords = coords
            if Bones[v] then
                local boneId = GetEntityBoneIndexByName(entity, v)
                local bonePos = GetWorldPositionOfEntityBone(entity, boneId)
                local distance = #(coords - bonePos)
                if closestBone == -1 or distance < closestDistance then
                    closestBone, closestDistance, closestPos, closestBoneName = boneId, distance, bonePos, v
                end
            end
        end
        if closestBone ~= -1 then return closestBone, closestPos, closestBoneName
        else return false end
    end,
}

exports("AddCircleZone", function(name, center, radius, options, targetoptions)
    Functions:AddCircleZone(name, center, radius, options, targetoptions)
end)

exports("AddBoxZone", function(name, center, length, width, options, targetoptions)
    Functions:AddBoxZone(name, center, length, width, options, targetoptions)
end)

exports("AddPolyzone", function(name, points, options, targetoptions)
    Functions:AddPolyzone(name, points, options, targetoptions)
end)

exports("AddTargetBone", function(bones, parameters)
    Functions:AddTargetBone(bones, parameters)
end)

exports("AddTargetEntity", function(entity, parameters)
    Functions:AddTargetEntity(entity, parameters)
end)

exports("AddEntityZone", function(name, entity, options, targetoptions)
    Functions:AddEntityZone(name, entity, options, targetoptions)
end)

exports("AddTargetModel", function(models, parameters)
    Functions:AddTargetModel(models, parameters)
end)

exports("RemoveZone", function(name)
    Functions:RemoveZone(name)
end)

exports("RemoveTargetModel", function(models, labels)
    Functions:RemoveTargetModel(models, labels)
end)

exports("RemoveTargetEntity", function(entity, labels)
    Functions:RemoveTargetEntity(entity, labels)
end)

exports("AddType", function(type, parameters)
    Functions:AddType(type, parameters)
end)

exports("AddPed", function(parameters)
    Functions:AddPed(parameters)
end)

exports("AddVehicle", function(parameters)
    Functions:AddVehicle(parameters)
end)

exports("AddObject", function(parameters)
    Functions:AddObject(parameters)
end)

exports("AddPlayer", function(parameters)
    Functions:AddPlayer(parameters)
end)

exports("RemoveType", function(type, labels)
    Functions:RemoveType(type, labels)
end)

exports("RemovePed", function(labels)
    Functions:RemovePed(labels)
end)

exports("RemoveVehicle", function(labels)
    Functions:RemoveVehicle(labels)
end)

exports("RemoveObject", function(labels)
    Functions:RemoveObject(labels)
end)

exports("RemovePlayer", function(labels)
    Functions:RemovePlayer(labels)
end)

exports("IsTargetActive", function()
    return Functions:IsTargetActive()
end)

exports("IsTargetSuccess", function()
    return Functions:IsTargetSuccess()
end)

exports("GetTargetTypeData", function(type, label)
    return Functions:GetTargetTypeData(type, label)
end)

exports("GetTargetZoneData", function(name)
    return Functions:GetTargetZoneData(name)
end)

exports("GetTargetBoneData", function(bone)
    return Functions:GetTargetBoneData(bone)
end)

exports("GetTargetEntityData", function(entity, label)
    Functions:GetTargetEntityData(entity, label)
end)

exports("GetTargetModelData", function(model, label)
    return Functions:GetTargetModelData(model, label)
end)

exports("GetTargetPedData", function(label)
    return Functions:GetTargetPedData(label)
end)

exports("GetTargetVehicleData", function(label)
    return Functions:GetTargetVehicleData(label)
end)

exports("GetTargetObjectData", function(label)
    return Functions:GetTargetObjectData(label)
end)

exports("GetTargetPlayerData", function(label)
    return Functions:GetTargetPlayerData(label)
end)

exports("FetchFunctions", function()
    return Functions
end)

RegisterNUICallback('selectTarget', function(option, cb)
    targetActive, success, hasFocus = false, false, false
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    local data = sendData[option]
    CreateThread(function()
        Wait(50)
        if data.action ~= nil then
            data.action(data.entity)
        elseif data.event ~= nil then
            if data.type == "client" then
                TriggerEvent(data.event, data)
            elseif data.type == "server" then
                TriggerServerEvent(data.event, data)
            elseif data.type == "command" then
                ExecuteCommand(data.event)
            elseif data.type == "qrcommand" then
                TriggerServerEvent('RSGCore:CallCommand', data.event, data)
            else
                TriggerEvent(data.event, data)
            end
        else
            print("[rsg-target]: ERROR NO EVENT SETUP")
        end
    end)

    sendData = nil
end)

RegisterNUICallback('closeTarget', function(data, cb)
    Wait(100)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    targetActive, hasFocus, success = false, false, false
end)

local enabled = false

CreateThread(function()
    while true do
        Wait(0)
        if Config.Toggle then
            if IsControlJustPressed(0, RSGCore.Shared.Keybinds['LALT']) then
                playerPed = PlayerPedId()
                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                if (not enabled) then
                    ExecuteCommand('+playerTarget')
                    enabled = true
                else
                    ExecuteCommand('-playerTarget')
                    enabled = false
                end
            end
        else
            if IsControlPressed(0, RSGCore.Shared.Keybinds['LALT']) then
                playerPed = PlayerPedId()
                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                if (not enabled) then
                    ExecuteCommand('+playerTarget')
                    enabled = true
                end
            elseif IsControlReleased(0, RSGCore.Shared.Keybinds['LALT']) then
                if enabled then
                    ExecuteCommand('-playerTarget')
                    enabled = false
                end
            end
        end
    end
end)

CreateThread(function()
    RegisterCommand('+playerTarget', function()
        Functions:EnableTarget()
    end, false)
    RegisterCommand('-playerTarget', function()
        Functions:DisableTarget(false)
    end, false)

    if next(Config.CircleZones) then
        for k, v in pairs(Config.CircleZones) do
            Functions:AddCircleZone(v.name, v.coords, v.radius, {
                name = v.name,
                debugPoly = v.debugPoly,
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.BoxZones) then
        for k, v in pairs(Config.BoxZones) do
            Functions:AddBoxZone(v.name, v.coords, v.length, v.width, {
                name = v.name,
                heading = v.heading,
                debugPoly = v.debugPoly,
                minZ = v.minZ,
                maxZ = v.maxZ
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.PolyZones) then
        for k, v in pairs(Config.PolyZones) do
            Functions:AddPolyZone(v.name, v.points, {
                name = v.name,
                debugPoly = v.debugPoly,
                minZ = v.minZ,
                maxZ = v.maxZ
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetBones) then
        for k, v in pairs(Config.TargetBones) do
            Functions:AddTargetBone(v.bones, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetEntities) then
        for k, v in pairs(Config.TargetEntities) do
            Functions:AddTargetEntity(v.entity, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.EntityZones) then
        for k, v in pairs(Config.EntityZones) do
            Functions:AddEntityZone(v.name, v.entity, {
                name = v.name,
                heading = v.heading,
                debugPoly = v.debugPoly,
            }, {
                options = v.options,
                distance = v.distance,
            })
        end
    end

    if next(Config.TargetModels) then
        for k, v in pairs(Config.TargetModels) do
            Functions:AddTargetModel(v.models, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.PedOptions) then
        Functions:AddPed({options = Config.PedOptions.options, distance = Config.PedOptions.distance})
    end

    if next(Config.VehicleOptions) then
        Functions:AddVehicle({options = Config.VehicleOptions.options, distance = Config.VehicleOptions.distance})
    end

    if next(Config.ObjectOptions) then
        Functions:AddObject({options = Config.ObjectOptions.options, distance = Config.ObjectOptions.distance})
    end

    if next(Config.PlayerOptions) then
        Functions:AddPlayer({options = Config.PlayerOptions.options, distance = Config.PlayerOptions.distance})
    end
end)

-- This is to make sure you can restart the resource manually without having to log-out.
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerData = RSGCore.Functions.GetPlayerData()
        isLoggedIn = true
    end
end)

if Config.Debug then
    AddEventHandler('rsg-target:debug', function(data)
        print('Flag: '..curFlag, 'Entity: '..data.entity, 'Type: '..GetEntityType(data.entity))
        if data.remove then
            Functions:RemoveTargetEntity(data.entity, 'HelloWorld')
        else
            Functions:AddTargetEntity(data.entity, {
                options = {
                    {
                        type = "client",
                        event = "rsg-target:debug",
                        icon = "fas fa-box-circle-check",
                        style = "",
                        label = "HelloWorld",
                        remove = true
                    },
                },
                distance = 3.0
            })
        end
    end)

    Functions:AddPed({
        options = {
            {
                type = "client",
                event = "rsg-target:debug",
                icon = "fas fa-male",
                style = "",
                label = "(Debug) Ped",
            },
        },
        distance = Config.MaxDistance
    })

    Functions:AddVehicle({
        options = {
            {
                type = "client",
                event = "rsg-target:debug",
                icon = "fas fa-car",
                style = "",
                label = "(Debug) Vehicle",
            },
        },
        distance = Config.MaxDistance
    })

    Functions:AddObject({
        options = {
            {
                type = "client",
                event = "rsg-target:debug",
                icon = "fas fa-cube",
                style = "",
                label = "(Debug) Object",
            },
        },
        distance = Config.MaxDistance
    })

    Functions:AddPlayer({
        options = {
            {
                type = "client",
                event = "rsg-target:debug",
                icon = "fas fa-cube",
                style = "",
                label = "(Debug) Player",
            },
        },
        distance = Config.MaxDistance
    })
end

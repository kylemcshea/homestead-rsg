local RSGCore = exports['rsg-core']:GetCoreObject()

local CoolDown = 0
local doorLockPrompt = GetRandomIntInRange(0, 0xffffff)
local lockPrompt = nil
local doorStatus = ''
local createdEntries = {}

local DoorLockPrompt = function()
    local str = 'Use'
    local stra = CreateVarString(10, 'LITERAL_STRING', str)

    lockPrompt = PromptRegisterBegin()
    PromptSetControlAction(lockPrompt, RSGCore.Shared.Keybinds['ENTER'])
    PromptSetText(lockPrompt, stra)
    PromptSetEnabled(lockPrompt, 1)
    PromptSetVisible(lockPrompt, 1)
    PromptSetHoldMode(lockPrompt, true)
    PromptSetGroup(lockPrompt, doorLockPrompt)
    PromptRegisterEnd(lockPrompt)

    createdEntries[#createdEntries + 1] = {type = "PROMPT", handle = lockPrompt}
    createdEntries[#createdEntries + 1] = {type = "PROMPT", handle = doorLockPrompt}
end

CreateThread(function()
    while true do
        for _, doorID in pairs(Config.DoorList) do
            if doorID.doors then
                for _, v in pairs(doorID.doors) do
                    if not v.object or not DoesEntityExist(v.object) then
                        local shapeTest = StartShapeTestBox(v.objCoords, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, 16)
                        local _, _, _, _, entityHit = GetShapeTestResult(shapeTest)
                        v.object = entityHit
                    end
                end
            else
                if not doorID.object or not DoesEntityExist(doorID.object) then
                    local shapeTest = StartShapeTestBox(doorID.objCoords, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, 16)
                    local _, _, _, _, entityHit = GetShapeTestResult(shapeTest)
                    doorID.object = entityHit
                end
            end
        end

        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    DoorLockPrompt()

    while true do
        Wait(4)
        local ped = PlayerPedId()
        local isdead = IsEntityDead(ped)
        local cuffed = IsPedCuffed(ped)
        local hogtied = Citizen.InvokeNative(0x3AA24CCC0D451379, ped)
        local lassoed = Citizen.InvokeNative(0x9682F850056C9ADE, ped)
        local playerCoords, letSleep = GetEntityCoords(ped), true
        local breakdown = isdead or cuffed or hogtied or lassoed

        if breakdown then goto continue end

        for k,doorID in ipairs(Config.DoorList) do
            local distance = #(playerCoords - doorID.textCoords)
            local maxDistance = 1.25

            if doorID.distance then
                maxDistance = doorID.distance
            end

            if distance < 5 then
                letSleep = false

                if doorID.doors then
                    if doorID.locked then
                        for i = 1, #doorID.doors do
                            local doors = doorID.doors[i]

                            if Citizen.InvokeNative(0x160AA1B32F6139B8, doors.doorid) ~= 3 then
                                Citizen.InvokeNative(0xD99229FE93B46286, doors.doorid,1,1,0,0,0,0)
                                Citizen.InvokeNative(0x6BAB9442830C7F53, doors.doorid, 3)
                            end
                            Citizen.InvokeNative(0xB6E6FBA95C7324AC, doors.doorid, 0.0, true)
                            doorStatus = '~e~Locked~q~'
                        end
                    else
                        for i = 1, #doorID.doors do
                            local doors = doorID.doors[i]

                            if Citizen.InvokeNative(0x160AA1B32F6139B8, doors.doorid) ~= false then
                                Citizen.InvokeNative(0xD99229FE93B46286, doors.doorid,1,1,0,0,0,0)
                                Citizen.InvokeNative(0x6BAB9442830C7F53, doors.doorid, 0)
                            end
                        end
                        FreezeEntityPosition(doorID.object, false)
                        doorStatus = '~t6~Unlocked~q~'
                    end

                else
                    if doorID.locked then
                        if Citizen.InvokeNative(0x160AA1B32F6139B8, doorID.doorid) ~= 3 then
                            Citizen.InvokeNative(0xD99229FE93B46286, doorID.doorid,1,1,0,0,0,0)
                            Citizen.InvokeNative(0x6BAB9442830C7F53, doorID.doorid, 3)
                        end
                        Citizen.InvokeNative(0xB6E6FBA95C7324AC, doorID.doorid, 0.0, true)
                        doorStatus = '~e~Locked~q~'
                    else
                        if Citizen.InvokeNative(0x160AA1B32F6139B8, doorID.doorid) ~= false then
                            Citizen.InvokeNative(0xD99229FE93B46286, doorID.doorid,1,1,0,0,0,0)
                            Citizen.InvokeNative(0x6BAB9442830C7F53, doorID.doorid, 0)
                        end
                        FreezeEntityPosition(doorID.object,false)
                        doorStatus = '~t6~Unlocked~q~'
                    end
                end
            end

            if distance < maxDistance then
                if distance < 1.5 then
                    local label = CreateVarString(10, 'LITERAL_STRING', 'Door Status: '..doorStatus)

                    PromptSetActiveGroupThisFrame(doorLockPrompt, label)

                    if PromptHasHoldModeCompleted(lockPrompt) and CoolDown < 1 then
                        CoolDown = 1000
                        local state = not doorID.locked
                        TriggerServerEvent("rsg-doorlock:updatedoorsv", k, state)
                    end
                end
            end

            if CoolDown > 0 then
                CoolDown = CoolDown - 1
            end
        end

        ::continue::

        if letSleep then
            Wait(500)
        end
    end
end)

RegisterNetEvent('rsg-doorlock:changedoor')
AddEventHandler('rsg-doorlock:changedoor', function(doorID, state)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped, true)
    local prop_name = GetHashKey('P_KEY02X')
    local doorCoords = Config.DoorList[doorID].textCoords
    local dx = doorCoords.x - pedCoords.x
    local dy = doorCoords.y - pedCoords.y
    local heading = GetHeadingFromVector_2d(dx, dy)
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local prop = CreateObject(prop_name, x, y, z + 0.2, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")

    SetPedDesiredHeading(ped, heading)

    if not IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3) then
        if not HasAnimDictLoaded("script_common@jail_cell@unlock@key") then
            RequestAnimDict("script_common@jail_cell@unlock@key")

            while not HasAnimDictLoaded("script_common@jail_cell@unlock@key") do
                Wait(100)
                RequestAnimDict("script_common@jail_cell@unlock@key")
            end
        end

        Wait(100)
        TaskPlayAnim(ped, 'script_common@jail_cell@unlock@key', 'action', 8.0, -8.0, 2500, 31, 0, true, 0, false, 0, false)
        RemoveAnimDict("script_common@jail_cell@unlock@key")
        Wait(750)
        AttachEntityToEntity(prop, ped,boneIndex, 0.02, 0.0120, -0.00850, 0.024, -160.0, 200.0, true, true, false, true, 1, true)
        Wait(250)
        TriggerServerEvent('rsg-doorlock:updateState', doorID, state, function(cb) end)
        Wait(1500)
        ClearPedSecondaryTask(ped)
        DeleteObject(prop)
    end
end)

-- Set State for a Door
RegisterNetEvent('rsg-doorlock:setState')
AddEventHandler('rsg-doorlock:setState', function(doorID, state)
    Config.DoorList[doorID].locked = state
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    for i = 1, #createdEntries do
        if createdEntries[i].type == "PROMPT" then
            PromptDelete(createdEntries[i].handle)
        end
    end
end)

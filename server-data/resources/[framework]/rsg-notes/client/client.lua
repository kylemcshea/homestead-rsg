local RSGCore = exports['rsg-core']:GetCoreObject()

local Props = {}
local Targets = {}
local Notes = {}
local time = 1000

local loadModel = function(model)
    local loaded = HasModelLoaded(model)

    if loaded then return end

    if Config.Debug then
        print("^5Debug^7: ^2Loading Model^7: '^6"..model.."^7'")
    end

    while not loaded do
        if time > 0 then
            time = time - 1
            RequestModel(model)
        else
            time = 1000

            if Config.Debug then
                print("^5Debug^7: ^3LoadModel^7: ^2Timed out loading model ^7'^6"..model.."^7'")
            end

            break
        end

        Wait(10)
    end
end

local destroyProp = function(entity)
    if Config.Debug then
        print("^5Debug^7: ^2Destroying Prop^7: '^6"..entity.."^7'")
    end

    SetEntityAsMissionEntity(entity)
    Wait(5)
    DetachEntity(entity, true, true)
    Wait(5)
    DeleteObject(entity)
end

local makeProp = function(data, freeze, synced)
    loadModel(data.prop)

    local prop = CreateObject(data.prop, data.coords.x, data.coords.y, data.coords.z-1.03, synced or 0, synced or 0, 0)

    SetEntityHeading(prop, data.coords.w)
    FreezeEntityPosition(prop, freeze or 0)

    if Config.Debug then
        print("^5Debug^7: ^6Prop ^2Created ^7: '^6"..prop.."^7'")
    end

    return prop
end

RegisterNetEvent('RSGCore:client:OnPlayerLoaded', function()
    TriggerEvent("rsg-notes:client:SyncNotes")
end)

AddEventHandler('onResourceStart', function(r)
    if GetCurrentResourceName() ~= r then return end
    TriggerEvent("rsg-notes:client:SyncNotes")
end)

RegisterNetEvent("rsg-notes:client:SyncNotes", function(newNotes)
    if not newNotes then
        local p = promise.new()

        RSGCore.Functions.TriggerCallback('rsg-notes:server:SyncNotes', function(cb)
            p:resolve(cb)
        end)

        Notes = Citizen.Await(p)
    else
        Notes = newNotes
    end

    for k, v in pairs(Notes) do
        if not Props[k] and Notes[k] then
            Props[k] = makeProp(
            {
                prop            = Config.Prop,
                coords          = vector4(v.coords.x, v.coords.y, v.coords.z + 0.07, v.coords.w)
            }, 1, 0)

            Targets[k] = exports['rsg-target']:AddCircleZone(k, vector3(v.coords.x, v.coords.y, v.coords.z-1.1), 0.5,
            {
                name            = k,
                debugPoly       = Config.Debug,
                useZ = true
            },
            {
                options =
                {
                    {
                        type    = "server",
                        event   = "rsg-notes:server:ReadNote",
                        icon    = "fas fa-receipt",
                        label   = Lang:t('targetinfo.read_note'),
                        noteid  = k
                    }
                },
                distance        = 2.5
            })
        end
    end

    for k in pairs(Props) do
        if not Notes[k] then
            exports["rsg-target"]:RemoveZone(k)

            destroyProp(Props[k])
        end
    end
end)

RegisterNetEvent("rsg-notes:client:CreateNote", function()
    local dialog = exports['rsg-input']:ShowInput(
    {
        header                  = Lang:t('menu.make_a_note'),
        submitText              = "Drop",
        inputs =
        {
            {
                text            = Lang:t('text.enter_message'),
                name            = "note",
                type            = "text",
                isRequired      = true
            }
        }
    })

    if dialog.note then
        local ped = PlayerPedId()
        local c = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.6, 0.0)
        local heading = GetEntityHeading(ped)

        TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, -1, true, "StartScenario", 0, false)
        Wait(5000)
        SetEntityHeading(object, heading)
        FreezeEntityPosition(object, true)
        Wait(500)
        ClearPedTasks(ped)

        TriggerServerEvent("rsg-notes:server:CreateNote",
        {
            coords              = vector4(c.x, c.y, c.z, heading),
            creator             = "Jimmy",
            message             = dialog.note,
            time                = "timetest"
        })
    end
end)

RegisterNetEvent("rsg-notes:client:ReadNote", function(data)
    local notepad = {}

    notepad[#notepad + 1] =
    {
        icon                    = "fas fa-receipt",
        isMenuHeader            = true,
        header                  = Lang:t('menu.message'),
        text                    = data.message
    }
    notepad[#notepad + 1] =
    {
        icon                    = "fas fa-person",
        isMenuHeader            = true,
        header                  = "",
        text                    = Lang:t('menu.written_by')..data.creator
    }
    notepad[#notepad + 1] =
    {
        icon                    = "fas fa-hand-scissors",
        header                  = "",
        text                    = Lang:t('menu.tear_up_note'),
        params                  =
        {
            event               = "rsg-notes:client:DestroyNote",
            args                = data
        }
    }

    exports["rsg-menu"]:openMenu(notepad)
end)

RegisterNetEvent("rsg-notes:client:DestroyNote", function(data)
    local ped = PlayerPedId()

    TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, -1, true, "StartScenario", 0, false)
    Wait(5000)
    SetEntityHeading(object, heading)
    FreezeEntityPosition(object, true)
    Wait(1500)
    ClearPedTasks(ped)

    TriggerServerEvent("rsg-notes:server:DestroyNote", data.id)
end)

AddEventHandler('onResourceStop', function(r)
    if r ~= GetCurrentResourceName() then return end

    for k in pairs(Targets) do
        exports["rsg-target"]:RemoveZone(k)
    end

    for k in pairs(Props) do
        DeleteEntity(Props[k])
    end
end)
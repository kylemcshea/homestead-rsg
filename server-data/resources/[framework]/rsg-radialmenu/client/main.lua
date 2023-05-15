local RSGCore = exports['rsg-core']:GetCoreObject()
local inRadialMenu = false
local jobIndex = nil
local vehicleIndex = nil
local DynamicMenuItems = {}
local FinalMenuItems = {}
-- Functions

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if not orig.canOpen or orig.canOpen() then
            local toRemove = {}
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                if type(orig_value) == 'table' then
                    if not orig_value.canOpen or orig_value.canOpen() then
                        copy[deepcopy(orig_key)] = deepcopy(orig_value)
                    else
                        toRemove[orig_key] = true
                    end
                else
                    copy[deepcopy(orig_key)] = deepcopy(orig_value)
                end
            end
            for i=1, #toRemove do table.remove(copy, i) end
            if copy and next(copy) then setmetatable(copy, deepcopy(getmetatable(orig))) end
        end
    elseif orig_type ~= 'function' then
        copy = orig
    end
    return copy
end

local function AddOption(data, id)
    local menuID = id ~= nil and id or (#DynamicMenuItems + 1)
    DynamicMenuItems[menuID] = deepcopy(data)
    return menuID
end

local function RemoveOption(id)
    DynamicMenuItems[id] = nil
end

local function SetupJobMenu()
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local JobMenu = {
        id = 'jobinteractions',
        title = 'Work',
        icon = 'briefcase',
        items = {}
    }
    if Config.JobInteractions[PlayerData.job.name] and next(Config.JobInteractions[PlayerData.job.name]) then
        JobMenu.items = Config.JobInteractions[PlayerData.job.name]
    end

    if #JobMenu.items == 0 then
        if jobIndex then
            RemoveOption(jobIndex)
            jobIndex = nil
        end
    else
        jobIndex = AddOption(JobMenu, jobIndex)
    end
end

local function SetupSubItems()
    SetupJobMenu()
end

local function selectOption(t, t2)
    for _, v in pairs(t) do
        if v.items then
            local found, hasAction, val = selectOption(v.items, t2)
            if found then return true, hasAction, val end
        else
            if v.id == t2.id and ((v.event and v.event == t2.event) or v.action) and (not v.canOpen or v.canOpen()) then
                return true, v.action, v
            end
        end
    end
    return false
end

local function SetupRadialMenu()
    FinalMenuItems = {}
    SetupSubItems()
    FinalMenuItems = deepcopy(Config.MenuItems)
    for _, v in pairs(DynamicMenuItems) do
        FinalMenuItems[#FinalMenuItems+1] = v
    end
end

local function setRadialState(bool, sendMessage, delay)

    if bool then
        TriggerEvent('rsg-radialmenu:client:onRadialmenuOpen')
        SetupRadialMenu()
    else
        TriggerEvent('rsg-radialmenu:client:onRadialmenuClose')
    end
    SetNuiFocus(bool, bool)
    if sendMessage then
        SendNUIMessage({
            action = "ui",
            radial = bool,
            items = FinalMenuItems
        })
    end
    if delay then Wait(500) end
    inRadialMenu = bool
end

-- Main Open Event
CreateThread(function()
    while true do
        Citizen.Wait(7)
if IsControlJustPressed(0, RSGCore.Shared.Keybinds['F6']) then
        setRadialState(true, true)
        SetCursorLocation(0.5, 0.5)
        end
    end
end)

-- Sets the metadata when the player spawns
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = RSGCore.Functions.GetPlayerData().job
end)

-- Sets the playerdata to an empty table when the player has quit or did /logout
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- This will update all the PlayerData that doesn't get updated with a specific event other than this like the metadata
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('rsg-radialmenu:client:noPlayers', function()
    RSGCore.Functions.Notify('No One Nearby', 'error')
end)

-- NUI Callbacks

RegisterNUICallback('closeRadial', function(data, cb)
    setRadialState(false, false, data.delay)
    cb('ok')
end)

RegisterNUICallback('selectItem', function(inData, cb)
    local itemData = inData.itemData
    local found, action, data = selectOption(FinalMenuItems, itemData)
    if data and found then
        if action then
            action(data)
        elseif data.type == 'client' then
            TriggerEvent(data.event, data)
        elseif data.type == 'server' then
            TriggerServerEvent(data.event, data)
        elseif data.type == 'command' then
            ExecuteCommand(data.event)
        elseif data.type == 'qbcommand' then
            TriggerServerEvent('QBCore:CallCommand', data.event, data)
        end
    end
    cb('ok')
end)

-- police emergency button pressed
RegisterNetEvent('rsg-radialmenu:client:SendPoliceEmergencyAlert', function()
    local Player = RSGCore.Functions.GetPlayerData()
    local firstname = Player.charinfo.firstname
    local lastname = Player.charinfo.lastname
    -- notify police
    TriggerServerEvent('police:server:policeAlert', 'Officer '..firstname..' '..lastname..' emergency button pressed!')
    -- notify medics
    TriggerServerEvent('rsg-medic:server:medicAlert', 'Medic '..firstname..' '..lastname..' emergency button pressed!')
end)

-- medic emergency button pressed
RegisterNetEvent('rsg-radialmenu:client:SendMedicEmergencyAlert', function()
    local Player = RSGCore.Functions.GetPlayerData()
    local firstname = Player.charinfo.firstname
    local lastname = Player.charinfo.lastname
    -- notify medics
    TriggerServerEvent('rsg-medic:server:medicAlert', 'Medic '..firstname..' '..lastname..' emergency button pressed!')
    -- notify police
    TriggerServerEvent('police:server:policeAlert', 'Officer '..firstname..' '..lastname..' emergency button pressed!')
end)

exports('AddOption', AddOption)
exports('RemoveOption', RemoveOption)

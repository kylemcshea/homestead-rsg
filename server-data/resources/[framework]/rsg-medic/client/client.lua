local RSGCore = exports['rsg-core']:GetCoreObject()
local deathSecondsRemaining = 0
local deathTimerStarted = false
local deathactive = false
local mediclocation
local medicsonduty = 0
local healthset = false
local closestRespawn = nil
local medicCalled = false
local Dead = false
local deadcam = nil
local angleY = 0.0
local angleZ = 0.0
local blipEntries = {}
-----------------------------------------------------------------------------------

local StartDeathCam = function()
    ClearFocus()

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local fov = GetGameplayCamFov()

    deadcam = Citizen.InvokeNative(0x40C23491CE83708E, "DEFAULT_SCRIPTED_CAMERA", coords, 0, 0, 0, fov)

    SetCamActive(deadcam, true)
    RenderScriptCams(true, true, 1000, true, false)
end

local EndDeathCam = function()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(deadcam, false)

    deadcam = nil
end

local ProcessNewPosition = function()
    local mouseX = 0.0
    local mouseY = 0.0
    local ped = PlayerPedId()

    if IsInputDisabled(0) then
        mouseX = GetDisabledControlNormal(1, 0x6BC904FC) * 8.0
        mouseY = GetDisabledControlNormal(1, 0x84574AE8) * 8.0
    else
        mouseX = GetDisabledControlNormal(1, 0x6BC904FC) * 0.5
        mouseY = GetDisabledControlNormal(1, 0x84574AE8) * 0.5
    end

    angleZ = angleZ - mouseX
    angleY = angleY + mouseY

    if angleY > 89.0 then
        angleY = 89.0
    elseif angleY < -89.0 then
        angleY = -89.0
    end

    local pCoords = GetEntityCoords(ped)

    local behindCam =
    {
        x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (0.5 + 0.5),
        y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (0.5 + 0.5),
        z = pCoords.z + ((Sin(angleY))) * (0.5 + 0.5)
    }

    local rayHandle = StartShapeTestRay(pCoords.x, pCoords.y, pCoords.z + 0.5, behindCam.x, behindCam.y, behindCam.z, -1, ped, 0)

    local _, hitBool, hitCoords, _, _ = GetShapeTestResult(rayHandle)

    local maxRadius = 3.5

    if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.0, hitCoords) < 0.5 + 0.5) then
        maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.0, hitCoords)
    end

    local offset =
    {
        x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
        y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
        z = ((Sin(angleY))) * maxRadius
    }

    local pos =
    {
        x = pCoords.x + offset.x,
        y = pCoords.y + offset.y,
        z = pCoords.z + offset.z
    }

    return pos
end

-- process camera controls
local ProcessCamControls = function()
    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)

    -- disable 1st person as the 1st person camera can cause some glitches
    Citizen.InvokeNative(0x05AB44D906738426)

    -- calculate new position
    local newPos = ProcessNewPosition()

    -- set coords of cam
    Citizen.InvokeNative(0xF9EE7D419EE49DE6, deadcam, newPos.x, newPos.y, newPos.z)

    -- set rotation
    Citizen.InvokeNative(0x948B39341C3A40C2, deadcam, playerCoords.x, playerCoords.y, playerCoords.z)
end

-- prompts and blips
CreateThread(function()
    for medic, v in pairs(Config.MedicJobLocations) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-medic:client:mainmenu',
            args = { v.prompt },
        })
        if v.showblip == true then
            local MedicBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(MedicBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(MedicBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, MedicBlip, Config.Blip.blipName)

            blipEntries[#blipEntries + 1] = { type = "BLIP", handle = MedicBlip }
        end
    end
end)

-- medic menu
RegisterNetEvent('rsg-medic:client:mainmenu', function(location)
    local job = RSGCore.Functions.GetPlayerData().job.name
    if job == Config.JobRequired then
        mediclocation = location
        exports['rsg-menu']:openMenu({
            {
                header = 'Medic Menu',
                isMenuHeader = true,
            },
            {
                header = "Toggle Duty",
                txt = "",
                icon = "fas fa-user-circle",
                params = {
                    event = 'rsg-medic:client:ToggleDuty',
                    isServer = false,
                }
            },
            {
                header = "Medical Supplies",
                txt = "",
                icon = "fas fa-heartbeat",
                params = {
                    event = 'rsg-medic:clent:OpenMedicSupplies',
                    isServer = false,
                }
            },
            {
                header = "Medic Storage",
                txt = "",
                icon = "fas fa-box",
                params = {
                    event = 'rsg-medic:clent:storage',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = "Job Management",
                txt = "",
                icon = "fas fa-user-circle",
                params = {
                    event = 'rsg-bossmenu:client:OpenMenu',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = ">> Close Menu <<",
                txt = '',
                params = {
                    event = 'rsg-menu:closeMenu',
                }
            },
        })
    else
        RSGCore.Functions.Notify('you are not a Medic!', 'error')
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- register death
CreateThread(function()
    while true do
        Wait(1000)
        local player = PlayerId()
        if NetworkIsPlayerActive(player) then
            local playerPed = PlayerPedId()
            if IsEntityDead(playerPed) and not deathactive then
                exports.spawnmanager:setAutoSpawn(false)
                deathTimerStarted = true
                deathTimer()
                deathactive = true
                TriggerServerEvent("RSGCore:Server:SetMetaData", "isdead", true)
            end
        end
    end
end)

-- Camera
CreateThread(function()
    while true do
        Wait(4)

        if deadcam and Dead then
            ProcessCamControls()
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000)

        if not Dead and deathactive then
            Dead = true

            StartDeathCam()
        elseif Dead and not deathactive then
            Dead = false

            EndDeathCam()
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- get medics on-duty
AddEventHandler('rsg-medic:client:GetMedicsOnDuty', function()
    RSGCore.Functions.TriggerCallback('rsg-medic:server:getmedics', function(mediccount)
        medicsonduty = mediccount
    end)
end)

-- Medic Call delay
local MedicCalled = function()
    Citizen.CreateThread(function()
        while true do
            Wait(30000)
            medicCalled = false
            return
        end
    end)
end

-- display respawn message and countdown
CreateThread(function()
    while true do
        Wait(0)
        if deathactive == true then
            if deathTimerStarted == true and deathSecondsRemaining > 0 then
                DrawTxt('RESPAWN IN '..deathSecondsRemaining..' SECONDS..', 0.50, 0.80, 0.5, 0.5, true, 104, 244, 120, 200, true)
            end
            if deathTimerStarted == true and deathSecondsRemaining == 0 and medicsonduty == 0 then
                DrawTxt('PRESS [E] TO RESPAWN', 0.50, 0.80, 0.5, 0.5, true, 104, 244, 120, 200, true)
            end
            if deathTimerStarted == true and deathSecondsRemaining == 0 and medicsonduty > 0 and not medicCalled then
                DrawTxt('PRESS [E] TO RESPAWN - PRESS [J] TO CALL FOR ASSISTANCE', 0.50, 0.80, 0.5, 0.5, true, 104, 244, 120, 200, true)
            end
            if deathTimerStarted == true and deathSecondsRemaining == 0 and IsControlPressed(0, RSGCore.Shared.Keybinds['E']) then
                deathTimerStarted = false
                TriggerEvent('rsg-medic:clent:revive')
                TriggerServerEvent('rsg-medic:server:deathactions')
            end
            if deathactive and deathTimerStarted and deathSecondsRemaining < Config.DeathTimer and IsControlPressed(0, RSGCore.Shared.Keybinds['J']) and not medicCalled then
                
                medicCalled = true

                if medicsonduty == 0 then
                    MedicCalled()
                    goto continue
                end

                local text = 'A person needs medical help!'

                TriggerServerEvent('rsg-medic:server:medicAlert', text)
                RSGCore.Functions.Notify('Medic has been called!', 'success', 5000)

                MedicCalled()

                ::continue::
            end
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- set closest respawn
local function SetClosestRespawn()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k, v in pairs(Config.RespawnLocations) do
        local dist2 = #(pos - vector3(Config.RespawnLocations[k].coords.x, Config.RespawnLocations[k].coords.y, Config.RespawnLocations[k].coords.z))
        if current then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    if current ~= closestRespawn then
        closestRespawn = current
    end
end

------------------------------------------------------------------------------------------------------------------------

-- player revive after pressing [E]
RegisterNetEvent('rsg-medic:clent:revive', function()
    SetClosestRespawn()
    local player = PlayerPedId()
    if deathactive == true then
        DoScreenFadeOut(500)
        Wait(1000)
        local respawnPos = Config.RespawnLocations[closestRespawn].coords
        NetworkResurrectLocalPlayer(respawnPos, true, false)
        SetEntityInvincible(player, false)
        ClearPedBloodDamage(player)
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100) -- SetAttributeCoreValue
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100) -- SetAttributeCoreValue
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", 100)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", 100)
        SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
        RemoveAllPedWeapons(player, true, true)
        -- reset death timer
        deathactive = false
        deathTimerStarted = false
        medicCalled = false
        deathSecondsRemaining = 0
        Wait(1500)
        DoScreenFadeIn(1800)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "isdead", false)
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- admin revive
RegisterNetEvent('rsg-medic:clent:adminRevive', function()
    local player = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1000)
    local pos = GetEntityCoords(player, true)
    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    SetEntityInvincible(player, false)
    ClearPedBloodDamage(player)
    Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100) -- SetAttributeCoreValue
    Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100) -- SetAttributeCoreValue
    TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] + 100)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + 100)
    SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
    RemoveAllPedWeapons(player, true, true)
    -- reset death timer
    deathactive = false
    deathTimerStarted = false
    medicCalled = false
    deathSecondsRemaining = 0
    Wait(1500)
    DoScreenFadeIn(1800)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "isdead", false)
end)

------------------------------------------------------------------------------------------------------------------------

-- player revive
RegisterNetEvent('rsg-medic:clent:playerRevive', function()
    local player = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1000)
    local pos = GetEntityCoords(player, true)
    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    SetEntityInvincible(player, false)
    ClearPedBloodDamage(player)
    Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100) -- SetAttributeCoreValue
    Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100) -- SetAttributeCoreValue
    TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] + 100)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + 100)
    SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
    RemoveAllPedWeapons(player, true, true)
    -- reset death timer
    deathactive = false
    deathTimerStarted = false
    medicCalled = false
    deathSecondsRemaining = 0
    Wait(1500)
    DoScreenFadeIn(1800)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "isdead", false)
end)

------------------------------------------------------------------------------------------------------------------------

-- death timer
function deathTimer()
    deathSecondsRemaining = Config.DeathTimer
    Citizen.CreateThread(function()
        while deathSecondsRemaining > 0 do
            Wait(1000)
            deathSecondsRemaining = deathSecondsRemaining - 1
            TriggerEvent("rsg-medic:client:GetMedicsOnDuty")
        end
    end)
end

-- drawtext for countdown
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

------------------------------------------------------------------------------------------------------------------------

-- setup stored health on restart
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    print('player health adjusted')

    local healthcore = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0)
    local savedhealth = RSGCore.Functions.GetPlayerData().metadata["health"]

    while not healthset do
        Wait(1000)

        if healthcore < 100 then
            Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100) -- SetAttributeCoreValue
            SetEntityHealth(PlayerPedId(), savedhealth, 0)
            healthset = true
        else
            Wait(1000)
            healthset = true
        end
    end

    if Config.DisableRegeneration then
        Citizen.InvokeNative(0x8899C244EBCF70DE, PlayerId(), 0.0)
    end
end)

-- health update loop
CreateThread(function()
    while true do
        if healthset == true then
            local health = GetEntityHealth(PlayerPedId())
            if lastHealth ~= health then
                TriggerServerEvent('rsg-medic:server:SetHealth', health)
            end
            lastHealth = health
            Wait(1000)
        else
            Wait(5000)
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- medic supplies
RegisterNetEvent('rsg-medic:clent:OpenMedicSupplies')
AddEventHandler('rsg-medic:clent:OpenMedicSupplies', function()
    local ShopItems = {}
    ShopItems.label = "Medic Supplies"
    ShopItems.items = Config.MedicSupplies
    ShopItems.slots = #Config.MedicSupplies
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "MedicSupplies_"..math.random(1, 99), ShopItems)
end)

-- medic storage
RegisterNetEvent('rsg-medic:clent:storage', function()
    local job = RSGCore.Functions.GetPlayerData().job.name
    local stashloc = mediclocation
    if job == Config.JobRequired then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashloc, {
            maxweight = Config.StorageMaxWeight,
            slots = Config.StorageMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", stashloc)
    end
end)

RegisterNetEvent('rsg-medic:client:KillPlayer', function()
    local ped = PlayerPedId()

    SetEntityHealth(ped, 0)
end)
------------------------------------------------------------------------------------------------------------------------

-- Cleanup
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    for i = 1, #Config.MedicJobLocations do
        local pos = Config.MedicJobLocations[i]

        exports['rsg-core']:deletePrompt(pos.prompt)
    end

    for i = 1, #blipEntries do
        if blipEntries[i].type == "BLIP" then
            RemoveBlip(blipEntries[i].handle)
        end
    end
end)
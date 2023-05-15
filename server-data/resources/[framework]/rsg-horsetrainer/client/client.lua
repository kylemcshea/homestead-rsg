local RSGCore = exports['rsg-core']:GetCoreObject()
local walking = false
local leading = false
local playerjob = nil
local cleancooldownSecondsRemaining = 0
local feedcooldownSecondsRemaining = 0
local horseEXP = 0
local maxedEXP = false
local horsePed = 0
local horseName = nil
local horseTraining = false
local htNotified = false
local isRadialPressed = false

-- Check horse EXP
local function CheckEXP()
    RSGCore.Functions.TriggerCallback('rsg-horses:server:GetActiveHorse', function(data)
        horseEXP = data.horsexp
    end)

    maxedEXP = false
end

-- Horse Training On/Off
RegisterNetEvent('rsg-horsetrainer:client:startTraining', function()
    if isRadialPressed then return end

    local ishorseTraining = not horseTraining

    if ishorseTraining then
        horseTraining = true
        htNotified = true

        RSGCore.Functions.Notify("Horse training started!", 'success', 3000)

        isRadialPressed = true
        Wait(8000)
        isRadialPressed = false
        return
    end

    horseTraining = false
    htNotified = false

    RSGCore.Functions.Notify("Horse training stopped!", 'error', 3000)

    isRadialPressed = true
    Wait(8000)
    isRadialPressed = false
end)

-------------------------------------------------------------------------------

-- cleaning cooldown timer
local function CleaningCooldown()
    cleancooldownSecondsRemaining = (Config.HorseCleanCooldown * 60)

    Citizen.CreateThread(function()
        while cleancooldownSecondsRemaining > 0 do
            Wait(1000)
            cleancooldownSecondsRemaining = cleancooldownSecondsRemaining - 1

            if Config.Debug then
                print(cleancooldownSecondsRemaining)
            end
        end
    end)
end

-- feeding cooldown timer
local function FeedingCooldown()
    feedcooldownSecondsRemaining = (Config.HorseFeedCooldown * 60)

    Citizen.CreateThread(function()
        while feedcooldownSecondsRemaining > 0 do
            Wait(1000)
            feedcooldownSecondsRemaining = feedcooldownSecondsRemaining - 1

            if Config.Debug then
                print(feedcooldownSecondsRemaining)
            end
        end
    end)
end

-------------------------------------------------------------------------------

-- leading horse for xp
CreateThread(function()
    while true do
        Wait(1000)

        if not LocalPlayer.state.isLoggedIn then goto continue end

        playerjob = RSGCore.Functions.GetPlayerData().job.name

        if playerjob ~= 'horsetrainer' then goto continue end

        walking = false
        leading = false

        if Citizen.InvokeNative(0xDE4C184B2B9B071A, PlayerPedId()) then -- walking
            walking = true
        end

        if Citizen.InvokeNative(0xEFC4303DDC6E60D3, PlayerPedId()) then -- leading
            leading = true
        end

        CheckEXP()

        if horseEXP >= 5000 then
            maxedEXP = true
        end

        if maxedEXP then goto continue end

        if not leading then
            if htNotified then
                htNotified = false
            end
        end

        if walking and leading then
            if not horseTraining then
                if not htNotified then
                    RSGCore.Functions.Notify('You\'re currently off duty, your horse won\'t get any EXP!', 'primary', 5000)
                    htNotified = true
                end

                goto continue
            end

            Wait(Config.LeadingXpTime)
            TriggerServerEvent('rsg-horsetrainer:server:updatexp', 'leading')
        end

        ::continue::
    end
end)

-------------------------------------------------------------------------------

-- brush horse for xp
RegisterNetEvent('rsg-horsetrainer:client:brushHorse', function(item)
    playerjob = RSGCore.Functions.GetPlayerData().job.name

    if playerjob ~= 'horsetrainer' then
        RSGCore.Functions.Notify(Lang:t('error.not_horse_trainer'), 'error')
        return
    end

    if item ~= 'horsetrainingbrush' then
        item = 'horsetrainingbrush'
    end

    horsePed = exports['rsg-horses']:CheckActiveHorse()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local cCoords = GetEntityCoords(horsePed)
    local distance = #(pCoords - cCoords)
    local hasItem = RSGCore.Functions.HasItem(item, 1)

    if distance > 1.7 then
        RSGCore.Functions.Notify(Lang:t('error.horse_too_far'), 'error')
        return
    end

    if cleancooldownSecondsRemaining ~= 0 then
        RSGCore.Functions.Notify(Lang:t('error.horse_too_clean'), 'error')
        return
    end

    if not hasItem then
        RSGCore.Functions.Notify(Lang:t('error.horse_brush_needed'), 'error')
        return
    end

    -- horsePed = Citizen.InvokeNative(0xE7E11B8DCBED1058, PlayerPedId())
    Citizen.InvokeNative(0xCD181A959CFDD7F4, PlayerPedId(), horsePed, `INTERACTION_BRUSH`, 0, 0)

    if not horseTraining then
        if not htNotified then
            RSGCore.Functions.Notify('You\'re currently off duty, your horse won\'t get any EXP!', 'primary', 5000)
            htNotified = true
        end

        return
    end

    Wait(8000)

    Citizen.InvokeNative(0xE3144B932DFDFF65, horsePed, 0.0, -1, 1, 1)
    ClearPedEnvDirt(horsePed)
    ClearPedDamageDecalByZone(horsePed, 10, "ALL")
    ClearPedBloodDamage(horsePed)

    CleaningCooldown()

    CheckEXP()

    if horseEXP >= 5000 then
        maxedEXP = true
    end

    if maxedEXP then return end

    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
    TriggerServerEvent('rsg-horsetrainer:server:updatexp', 'cleaning')
end)

-------------------------------------------------------------------------------

-- feed horse for xp
RegisterNetEvent('rsg-horsetrainer:client:feedHorse',function(item)
    playerjob = RSGCore.Functions.GetPlayerData().job.name

    if playerjob ~= 'horsetrainer' then
        RSGCore.Functions.Notify(Lang:t('error.not_horse_trainer'), 'error')
        return
    end

    if item ~= 'horsetrainingcarrot' then
        item = 'horsetrainingcarrot'
    end

    horsePed = exports['rsg-horses']:CheckActiveHorse()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local cCoords = GetEntityCoords(horsePed)
    local distance = #(pCoords - cCoords)
    local hasItem = RSGCore.Functions.HasItem(item, 1)

    if distance > 1.7 then
        RSGCore.Functions.Notify(Lang:t('error.horse_too_far'), 'error')
        return
    end

    if feedcooldownSecondsRemaining ~= 0 then
        RSGCore.Functions.Notify(Lang:t('error.horse_too_full'), 'error')
        return
    end

    if not hasItem then
        RSGCore.Functions.Notify(Lang:t('error.carrot_needed'), 'error')
        return
    end

    -- horsePed = Citizen.InvokeNative(0xE7E11B8DCBED1058, PlayerPedId())
    Citizen.InvokeNative(0xCD181A959CFDD7F4, PlayerPedId(), horsePed, -224471938, 0, 0)

    FeedingCooldown()

    CheckEXP()


    if horseEXP >= 5000 then
        maxedEXP = true
    end

    TriggerServerEvent('rsg-horsetrainer:server:deleteItem', item, 1)

    if maxedEXP then return end

    if not horseTraining then
        if not htNotified then
            RSGCore.Functions.Notify('You\'re currently off duty, your horse won\'t get any EXP!', 'primary', 5000)
            htNotified = true
        end

        return
    end

    Wait(5000)

    TriggerServerEvent('rsg-horsetrainer:server:updatexp', 'feeding')
end)

-------------------------------------------------------------------------------

RegisterNetEvent('rsg-horsetrainer:client:OpenTrainerShop')
AddEventHandler('rsg-horsetrainer:client:OpenTrainerShop', function()
    playerjob = RSGCore.Functions.GetPlayerData().job.name

    if playerjob ~= 'horsetrainer' then
        RSGCore.Functions.Notify(Lang:t('error.not_horse_trainer'), 'error')
        return
    end

    local ShopItems = {}

    ShopItems.label = "Horse Trainer Shop"
    ShopItems.items = Config.TrainerShop
    ShopItems.slots = #Config.TrainerShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "TrainerShop_"..math.random(1, 99), ShopItems)
end)

-------------------------------------------------------------------------------

-- Check horse EXP
RegisterNetEvent('rsg-horsetrainer:client:checkHorseEXP')
AddEventHandler('rsg-horsetrainer:client:checkHorseEXP', function()
    RSGCore.Functions.TriggerCallback('rsg-horses:server:GetActiveHorse', function(data)
        if (data) then
            horsePed = exports['rsg-horses']:CheckActiveHorse()
            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)
            local cCoords = GetEntityCoords(horsePed)
            local distance = #(pCoords - cCoords)

            horseName = data.name
            horseEXP = data.horsexp
            -- horsePed = Citizen.InvokeNative(0xE7E11B8DCBED1058, PlayerPedId())

            local level = exports['rsg-horses']:CheckHorseLevel()
            local bondingLevel = exports['rsg-horses']:CheckHorseBondingLevel()
            local msg = "Name: ~e~"..horseName.."~q~ | EXP: ~e~"..horseEXP.."~q~ | Level: ~e~"..level.."~q~ | Bonding Level: ~e~"..bondingLevel.."~q~"

            if distance > 1.7 then
                RSGCore.Functions.Notify(Lang:t('error.horse_too_far'), 'error')
                return
            end

            NotificationSound(msg)
        end
    end)
end)

function NotificationSound(msg)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end
local RSGCore = exports['rsg-core']:GetCoreObject()

local cuteBird = nil
local birdPrompt = nil
local letterPromptGroup = GetRandomIntInRange(0, 0xffffff)
local birdBlip = nil
local targetPed = nil
local targetCoords = nil
local playerCoords = nil
local notified = false
local destination = nil
local howFar = 0
local senderID = nil
local sID = nil
local tPName = nil
local isReceiving = false
local buildingNotified = false
local isBirdCanSpawn = false
local isBirdAlreadySpawned = false
local birdTime = Config.BirdTimeout
local blipEntries = {}

exports('IsBirdPostApproaching', function()
    return isReceiving
end)

-- Bird Prompt
local BirdPrompt = function()
    Citizen.CreateThread(function()
        birdPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(birdPrompt, RSGCore.Shared.Keybinds['ENTER'])
        local str = CreateVarString(10, 'LITERAL_STRING', Lang:t("desc.prompt_button"))
        PromptSetText(birdPrompt, str)
        PromptSetEnabled(birdPrompt, true)
        PromptSetVisible(birdPrompt, true)
        PromptSetHoldMode(birdPrompt, true)
        PromptSetGroup(birdPrompt, letterPromptGroup)
        PromptRegisterEnd(birdPrompt)
    end)
end

-- Prompts
Citizen.CreateThread(function()
    for i = 1, #Config.PostOfficeLocations do
        local pos = Config.PostOfficeLocations[i]

        exports['rsg-core']:createPrompt(pos.location, pos.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. pos.name, {
            type = 'client',
            event = 'rsg-telegram:client:TelegramMenu'
        })

        if pos.showblip == true then
            PostOfficeBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, pos.coords)
            SetBlipSprite(PostOfficeBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(PostOfficeBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, PostOfficeBlip, pos.name)

            blipEntries[#blipEntries + 1] = { type = "BLIP", handle = PostOfficeBlip }
        end
    end
end)

-- Telegram Menu
RegisterNetEvent('rsg-telegram:client:TelegramMenu', function(data)
    exports['rsg-menu']:openMenu({
        {
            header = "| Telegram Menu |",
            isMenuHeader = true,
            icon   = 'fa-solid fa-envelope-open-text',
        },
        {
            header = "📥 | Read Messages",
            txt = "read your telegram messages",
            params = {
                event = 'rsg-telegram:client:ReadMessages',
                isServer = false
            }
        },
        {
            header = "📤 | Send Telegram",
            txt = "send a telegram to another player",
            params = {
                event = 'rsg-telegram:client:WriteMessagePostOffice',
                isServer = false
            }
        },
        {
            header = "Close Menu",
            txt = '',
            icon   = 'fa-solid fa-circle-xmark',
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
end)

-- Write Message
RegisterNetEvent('rsg-telegram:client:WriteMessagePostOffice', function()
    RSGCore.Functions.TriggerCallback('rsg-telegram:server:GetPlayersPostOffice', function(players)
        local option = {}

        if players~=nil then
            for i = 1, #players do
                local citizenid = players[i].citizenid
                local fullname = players[i].name
                local content = {value = citizenid, text = fullname..' ('..citizenid..')'}
                
                option[#option + 1] = content
            end
    
            local sendButton = Lang:t("desc.send_button_free")
    
            if Config.ChargePlayer then
                sendButton = Lang:t("desc.send_button_paid", {lPrice = tonumber(Config.CostPerLetter)})
            end
    
            local input = exports['rsg-input']:ShowInput({
            header = Lang:t('desc.send_message_header'),
            submitText = sendButton,
                inputs = {
                    {
                        text = "Recipient",
                        name = "recipient",
                        type = "select",
                        options = option
                    },
                    {
                        type = 'text',
                        name = 'subject',
                        text = 'subject',
                        isRequired = true,
                    },
                    {
                        type = 'text',
                        name = 'message',
                        text = 'add your message here',
                        isRequired = true,
                    },
                }
            })
    
            if input ~= nil then
                local pID =  PlayerId()
                senderID = GetPlayerServerId(pID)
                local senderfirstname = RSGCore.Functions.GetPlayerData().charinfo.firstname
                local senderlastname = RSGCore.Functions.GetPlayerData().charinfo.lastname
                local sendertelegram = RSGCore.Functions.GetPlayerData().citizenid
                local senderfullname = senderfirstname..' '..senderlastname
                TriggerServerEvent('rsg-telegram:server:SendMessagePostOffice', sendertelegram, senderfullname, input.recipient, input.subject, input.message)
            end
        else
            RSGCore.Functions.Notify("You Need To Add People to Your Addressbook", 'error')

        end
    end)
end)

-- Prompt Handling
local function Prompts()
    if not PromptHasHoldModeCompleted(birdPrompt) then return end

    local ped = PlayerPedId()

    if destination < 3 and IsPedOnMount(ped) or IsPedOnVehicle(ped) then
        RSGCore.Functions.Notify(Lang:t("error.player_on_horse"), 'error')

        Wait(3000)
        return
    end

    TriggerEvent("rsg-telegram:client:ReadMessages")

    TriggerServerEvent('rsg-telegram:server:DeliverySuccess', sID, tPName)

    Wait(1000)

    TaskFlyToCoord(cuteBird, 0, playerCoords.x - 100, playerCoords.y - 100, playerCoords.z + 50, 1, 0)

    if birdBlip ~= nil then
        RemoveBlip(birdBlip)
    end

    isReceiving = false
    isBirdAlreadySpawned = false
    notified = false

    Wait(10000)

    SetEntityInvincible(cuteBird, false)
    SetEntityCanBeDamaged(cuteBird, true)
    SetEntityAsMissionEntity(cuteBird, false, false)
    SetEntityAsNoLongerNeeded(cuteBird)
    DeleteEntity(cuteBird)
end

-- Set Bird Attribute
local SetPetAttributes = function(entity)
    -- SET_ATTRIBUTE_POINTS
    Citizen.InvokeNative(0x09A59688C26D88DF, entity, 0, 1100)
    Citizen.InvokeNative(0x09A59688C26D88DF, entity, 1, 1100)
    Citizen.InvokeNative(0x09A59688C26D88DF, entity, 2, 1100)

    -- ADD_ATTRIBUTE_POINTS
    Citizen.InvokeNative(0x75415EE0CB583760, entity, 0, 1100)
    Citizen.InvokeNative(0x75415EE0CB583760, entity, 1, 1100)
    Citizen.InvokeNative(0x75415EE0CB583760, entity, 2, 1100)

    -- SET_ATTRIBUTE_BASE_RANK
    Citizen.InvokeNative(0x5DA12E025D47D4E5, entity, 0, 10)
    Citizen.InvokeNative(0x5DA12E025D47D4E5, entity, 1, 10)
    Citizen.InvokeNative(0x5DA12E025D47D4E5, entity, 2, 10)

    -- SET_ATTRIBUTE_BONUS_RANK
    Citizen.InvokeNative(0x920F9488BD115EFB, entity, 0, 10)
    Citizen.InvokeNative(0x920F9488BD115EFB, entity, 1, 10)
    Citizen.InvokeNative(0x920F9488BD115EFB, entity, 2, 10)

    -- SET_ATTRIBUTE_OVERPOWER_AMOUNT
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, entity, 0, 5000.0, false)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, entity, 1, 5000.0, false)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, entity, 2, 5000.0, false)
end

local function SetPetBehavior(entity)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 143493179)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -2040077242)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1222652248)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1077299173)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -887307738)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1998572072)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -661858713)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1232372459)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1836932466)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1878159675)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1078461828)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1535431934)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1862763509)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1663301869)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1448293989)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1201903818)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -886193798)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1996978098)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 555364152)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -2020052692)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 707888648)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 378397108)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -350651841)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1538724068)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1030835986)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1919885972)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1976316465)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 841021282)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 889541022)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1329647920)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -319516747)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -767591988)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -989642646)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), 1986610512)
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(entity), -1683752762)
end

-- Place Ped on Ground Properly
local PlacePedOnGroundProperly = function(hPed, howfar)
    local playerPed = PlayerPedId()
    howFar = howfar
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    local found, groundz, normal = GetGroundZAndNormalFor_3dCoord(x - howFar, y, z)

    if found then
        SetEntityCoordsNoOffset(hPed, x - howFar, y, groundz + normal.z + howFar, true)
    end
end

-- Spawn the Bird Post
local SpawnBirdPost = function(posX, posY, posZ, heading, rfar, x)
    cuteBird = CreatePed(Config.BirdModel, posX, posY, posZ, heading, 1, 1)

    SetPetAttributes(cuteBird)

    Citizen.InvokeNative(0x013A7BA5015C1372, cuteBird, true) -- SetPedIgnoreDeadBodies
    Citizen.InvokeNative(0xAEB97D84CDF3C00B, cuteBird, false) -- SetAnimalIsWild

    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(cuteBird), GetHashKey('PLAYER'))

    PlacePedOnGroundProperly(cuteBird, rfar)

    Wait(2000)

    Citizen.InvokeNative(0x283978A15512B2FE, cuteBird, true) -- SetRandomOutfitVariation
    ClearPedTasks(cuteBird)
    ClearPedSecondaryTask(cuteBird)
    ClearPedTasksImmediately(cuteBird)
    SetPedFleeAttributes(cuteBird, 0, 0)
    TaskWanderStandard(cuteBird, 0, 0)
    TaskSetBlockingOfNonTemporaryEvents(cuteBird, 1)
    SetEntityAsMissionEntity(cuteBird, true, true)
    Citizen.InvokeNative(0xA5C38736C426FCB8, cuteBird, true) -- SetEntityInvincible

    Wait(2000)

    if x == 0 then
        local blipname = Lang:t("desc.blip_name")
        local bliphash = -1749618580

        Debug("bliphash", bliphash)

        birdBlip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, bliphash, cuteBird) -- BlipAddForEntity
        Citizen.InvokeNative(0x9CB1A1623062F402, birdBlip, blipname) -- SetBlipName
        -- Citizen.InvokeNative(0x931B241409216C1F, targetPed, cuteBird, true) -- SetPedOwnsAnimal
        Citizen.InvokeNative(0x0DF2B55F717DDB10, birdBlip) -- SetBlipFlashes
        Citizen.InvokeNative(0x662D364ABF16DE2F, birdBlip, GetHashKey("BLIP_MODIFIER_DEBUG_BLUE")) -- BlipAddModifier
        SetBlipScale(birdBlip, 2.0)
    end
end

-- Prompt Thread
CreateThread(function()
    BirdPrompt()

    while true do
        Wait(1)

        if notified and destination < 3 then
            local Bird = CreateVarString(10, "LITERAL_STRING", "~pa~"..Lang:t("desc.prompt_desc").."~q~")
            PromptSetActiveGroupThisFrame(letterPromptGroup, Bird)

            if PromptHasHoldModeCompleted(birdPrompt) then
                Prompts()
            end
        end
    end
end)

-- Receive Message
RegisterNetEvent('rsg-telegram:client:ReceiveMessage')
AddEventHandler('rsg-telegram:client:ReceiveMessage', function(SsID, StPName)
    isReceiving = true
    sID = SsID
    tPName = StPName
    local ped = PlayerPedId()
    local rFar = math.random(50, 100)

    while isReceiving do
        Wait(1)

        playerCoords = GetEntityCoords(ped)
        local birdCoords = GetEntityCoords(cuteBird)
        local myCoords = vector3(playerCoords.x, playerCoords.y, playerCoords.z)
        destination = #(birdCoords - myCoords)

        local insideBuilding = GetInteriorFromEntity(ped)

        isBirdCanSpawn = true

        if insideBuilding ~= 0 then
            if not buildingNotified then
                RSGCore.Functions.Notify(Lang:t("info.inside_building"), 'error')
                buildingNotified = true
            end

            isBirdCanSpawn = false

            goto continue
        end

        if isBirdCanSpawn and not isBirdAlreadySpawned then
            SpawnBirdPost(playerCoords.x - 100, playerCoords.y - 100, playerCoords.z + 100, 92.0, rFar, 0)
            TaskFlyToCoord(cuteBird, 0, playerCoords.x - 1, playerCoords.y - 1, playerCoords.z, 1, 0)
            isBirdCanSpawn = false
            isBirdAlreadySpawned = true
        end

        if destination < 100 and not notified then
            notified = true
            RSGCore.Functions.Notify(Lang:t("info.bird_approaching"), 'primary', 3000)
            Wait(5000)
            RSGCore.Functions.Notify(Lang:t("info.wait_for_bird"), 'primary', 3000)
        end

        local IsPedAir = IsEntityInAir(cuteBird, 1)
        local isBirdDead = Citizen.InvokeNative(0x7D5B1F88E7504BBA, cuteBird) -- IsEntityDead

        BirdCoords = GetEntityCoords(cuteBird)

        Debug("cuteBird", cuteBird)
        Debug("IsPedAir", IsPedAir)
        Debug("notified", notified)
        Debug("destination", destination)

        if cuteBird ~= nil and not IsPedAir and notified and destination > 3 then
            if Config.AutoResurrect and isBirdDead then
                Debug("isBirdDead", isBirdDead)

                ClearPedTasksImmediately(cuteBird)

                SetEntityCoords(cuteBird, BirdCoords.x, BirdCoords.y, BirdCoords.z)
                Wait(1000)
                Citizen.InvokeNative(0x71BC8E838B9C6035, cuteBird) -- ResurrectPed
                Wait(1000)
            end

            TaskFlyToCoord(cuteBird, 0, myCoords.x - 1, myCoords.y - 1, myCoords.z, 1, 0)
        end

        if birdTime > 0 then
            birdTime = birdTime - 1
            Wait(1000)
        end

        if birdTime == 0 and cuteBird ~= nil and notified then
            RSGCore.Functions.Notify(Lang:t("error.delivery_fail1"), 'error', 5000)
            Wait(8000)
            RSGCore.Functions.Notify(Lang:t("error.delivery_fail2"), 'error', 5000)
            Wait(8000)
            RSGCore.Functions.Notify(Lang:t("error.delivery_fail3"), 'error', 5000)

            SetEntityInvincible(cuteBird, false)
            SetEntityAsMissionEntity(cuteBird, false, false)
            SetEntityAsNoLongerNeeded(cuteBird)
            DeleteEntity(cuteBird)
            RemoveBlip(birdBlip)

            notified = false
            isReceiving = false

            return
        end

        ::continue::
    end
end)

-- Write the Message
RegisterNetEvent('rsg-telegram:client:WriteMessage', function()
    RSGCore.Functions.TriggerCallback('rsg-telegram:server:GetPlayers', function(players)
        if players ~= nil then
            local citizenid = 0
            local name = 0
            local sourceplayer = 0
            local option = {}

            if isReceiving then
                RSGCore.Functions.Notify(Lang:t("error.send_receiving"), 'error', 8000)
                return
            end

            local ped = PlayerPedId()
            local pID =  PlayerId()
            senderID = GetPlayerServerId(pID)

            if IsPedOnMount(ped) or IsPedOnVehicle(ped) then
                RSGCore.Functions.Notify(Lang:t("error.player_on_horse"), 'error')
                return
            end

            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)

            playerCoords = GetEntityCoords(ped)
            targetCoords = GetEntityCoords(targetPed)
            local coordsOffset = math.random(200, 300)

            local heading = GetEntityHeading(ped)
            local rFar = 30

            TaskWhistleAnim(ped, GetHashKey('WHISTLEHORSELONG'))

            SpawnBirdPost(playerCoords.x, playerCoords.y - rFar, playerCoords.z, heading, rFar)

            if cuteBird == nil then
                RSGCore.Functions.Notify('The bird got away!', 'error')
                return
            end

            TaskFlyToCoord(cuteBird, 1, playerCoords.x, playerCoords.y, playerCoords.z, 1, 1)
            TaskStartScenarioInPlace(ped, GetHashKey('WORLD_HUMAN_WRITE_NOTEBOOK'), -1, true, false, false, false)

            while true do
                local birdPos = GetEntityCoords(cuteBird)
                local distance = #(birdPos - playerCoords)

                if distance > 1 then
                    Wait(1000)
                else
                    break
                end
            end

            local sendButton = Lang:t("desc.send_button_free")

            if Config.ChargePlayer then
                sendButton = Lang:t("desc.send_button_paid", {lPrice = tonumber(Config.CostPerLetter)})
            end

            for i = 1, #players do
                local targetPlayer = players[i]

                
                citizenid = targetPlayer.citizenid
                name = targetPlayer.name
                local content = {value = citizenid, text = '('..citizenid..') '..name}

                option[#option + 1] = content
            end
            local input = exports['rsg-input']:ShowInput
            ({
                header = Lang:t('desc.send_message_header'),
                submitText = sendButton,
                inputs =
                {
                    --[[
                    {
                        type = 'select',
                        name = 'recipient',
                        text = Lang:t('desc.recipient'),
                        isRequired = true
                    },
                    ]]--
                    {
                        text = Lang:t('desc.recipient'),
                        name = "recipient",
                        type = "select",
                        options = option
                    },
                    {
                        type = 'text',
                        name = 'subject',
                        text = Lang:t('desc.subject'),
                        isRequired = true
                    },
                    {
                        type = 'text',
                        name = 'message',
                        text = Lang:t('desc.message'),
                        isRequired = true
                    }
                }
            })

            if input == nil then
                FreezeEntityPosition(PlayerPedId(), false)
                SetEntityInvincible(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                ClearPedSecondaryTask(PlayerPedId())

                SetEntityInvincible(cuteBird, false)
                SetEntityCanBeDamaged(cuteBird, true)
                SetEntityAsMissionEntity(cuteBird, false, false)
                SetEntityAsNoLongerNeeded(cuteBird)
                DeleteEntity(cuteBird)

                if birdBlip ~= nil then
                    RemoveBlip(birdBlip)
                end

                RSGCore.Functions.Notify(Lang:t('error.cancel_send'), 'error')

                return
            end

            Debug("input.recipient", input.recipient)
            Debug("input.subject", input.subject)
            Debug("input.message", input.message)

            local senderfirstname = RSGCore.Functions.GetPlayerData().charinfo.firstname
            local senderlastname = RSGCore.Functions.GetPlayerData().charinfo.lastname
            local sendertelegram = RSGCore.Functions.GetPlayerData().citizenid
            local senderfullname = senderfirstname..' '..senderlastname

            Debug("sendertelegram:", sendertelegram)
            Debug("senderfullname:", senderfullname)
            Debug("input.recipient:", input.recipient)
            Debug("input.subject:", input.subject)
            Debug("input.message:", input.message)

            Debug("targetPed:", targetPed)

            FreezeEntityPosition(ped, false)
            SetEntityInvincible(ped, false)
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)

            Wait(3000)

            TaskFlyToCoord(cuteBird, 0, targetCoords.x - coordsOffset, targetCoords.y - coordsOffset, targetCoords.z + 75, 1, 0)

            Wait(Config.BirdArrivalDelay)

            SetEntityInvincible(cuteBird, false)
            SetEntityCanBeDamaged(cuteBird, true)
            SetEntityAsMissionEntity(cuteBird, false, false)
            SetEntityAsNoLongerNeeded(cuteBird)
            DeleteEntity(cuteBird)
            RemoveBlip(birdBlip)

            TriggerServerEvent('rsg-telegram:server:SendMessage', senderID, sendertelegram, senderfullname, input.recipient, Lang:t('desc.message_prefix')..': '..input.subject, input.message)
        else
            RSGCore.Functions.Notify("You Need To Add People to Your Addressbook", 'error')
        end
    end)
end)

-- Read the Message
RegisterNetEvent('rsg-telegram:client:ReadMessages')
AddEventHandler('rsg-telegram:client:ReadMessages', function()
    InMenu = true
    SetNuiFocus(true, true)

    SendNUIMessage
    ({
        type = 'openGeneral'
    })

    TriggerServerEvent('rsg-telegram:server:CheckInbox')
end)

-- Show Messages List
RegisterNetEvent('rsg-telegram:client:InboxList')
AddEventHandler('rsg-telegram:client:InboxList', function(data)
    SendNUIMessage
    ({
        type = 'inboxlist', response = data
    })
end)

-- Get the Message
RegisterNUICallback('getview', function(data)
    TriggerServerEvent('rsg-telegram:server:GetMessages', tonumber(data.id))
end)

-- Message Data
RegisterNetEvent('rsg-telegram:client:MessageData')
AddEventHandler('rsg-telegram:client:MessageData', function(tele)
    SendNUIMessage
    ({
        type = 'view',
        telegram = tele
    })
end)

-- Delete Message
RegisterNUICallback('delete', function(data)
    TriggerServerEvent('rsg-telegram:server:DeleteMessage', tonumber(data.id))
end)

-- Close Mailbox
RegisterNUICallback('NUIFocusOff', function()
    InMenu = false
    SetNuiFocus(false, false)

    SendNUIMessage
    ({
        type = 'closeAll'
    })
end)

-- Cleanup
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    if birdBlip ~= nil then
        RemoveBlip(birdBlip)
    end

    SetEntityAsMissionEntity(cuteBird, false)
    FreezeEntityPosition(cuteBird, false)
    DeleteEntity(cuteBird)
    PromptDelete(birdPrompt)

    for i = 1, #Config.PostOfficeLocations do
        local pos = Config.PostOfficeLocations[i]

        exports['rsg-core']:deletePrompt(pos.location)
    end

    for i = 1, #blipEntries do
        if blipEntries[i].type == "BLIP" then
            RemoveBlip(blipEntries[i].handle)
        end
    end
end)


-- AddressBook
RegisterNetEvent('rsg-telegram:client:OpenAddressbook', function()
    exports['rsg-menu']:openMenu({
        {
            header = "| Address Book |",
            isMenuHeader = true,
            icon   = 'fa-solid fa-envelope-open-text',
        },
        {
            header = "📝 | View Addressbook",
            txt = "See All of Person in my Addressbook",
            params = {
                event = 'rsg-telegram:client:ViewAddressBook',
                isServer = false
            }
        },
        {
            header = "➕ | Add New Person",
            txt = "Add new Person To Your Addressbook",
            params = {
                event = 'rsg-telegram:client:AddPersonMenu',
                isServer = false
            }
        },
        {
            header = "❌ | Remove Person",
            txt = "Remove Person From your Addressbook",
            params = {
                event = 'rsg-telegram:client:RemovePersonMenu',
                isServer = false
            }
        },
        {
            header = "Close Menu",
            txt = '',
            icon   = 'fa-solid fa-circle-xmark',
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
end)

RegisterNetEvent('rsg-telegram:client:AddPersonMenu', function()
    local input = exports['rsg-input']:ShowInput({
        header = "Add New Person",
        submitText = "Submit",
            inputs = {
                
                {
                    type = 'text',
                    name = 'name',
                    text = 'Name',
                    isRequired = true,
                },
                {
                    type = 'text',
                    name = 'cid',
                    text = 'CitizenId',
                    isRequired = true,
                },
            }
        })

        if input ~= nil then
            TriggerServerEvent('rsg-telegram:server:SavePerson', input.name, input.cid)
        end
end)
RegisterNetEvent('rsg-telegram:client:ViewAddressBook', function()
    RSGCore.Functions.TriggerCallback('rsg-telegram:server:GetPlayers', function(players)
        if players ~= nil then
            local options = {
                {
                    header = "| Address Book |",
                    isMenuHeader = true,
                    icon   = 'fa-solid fa-envelope-open-text',
                },
            }
            for i = 1, #players do
                local player = players[i]
                options[#options + 1] = {
                    header = player.name,
                    txt = "P.O : "..player.citizenid,
                    disabled = true
                }
            end
            options[#options+1] = 
            {
                header = "Close Menu",
                txt = '',
                icon   = 'fa-solid fa-circle-xmark',
                params = {
                    event = 'rsg-menu:closeMenu',
                }
            }
            exports['rsg-menu']:openMenu(options)
        else
            RSGCore.Functions.Notify("You Need To Add People to Your Addressbook", 'error')
        end
    end)
end)

RegisterNetEvent('rsg-telegram:client:RemovePersonMenu', function()
    RSGCore.Functions.TriggerCallback('rsg-telegram:server:GetPlayers', function(players)
        if players ~= nil then
            local option = {}
            for i = 1, #players do
                local citizenid = players[i].citizenid
                local fullname = players[i].name
                local content = {value = citizenid, text = fullname..' ('..citizenid..')'}
                option[#option + 1] = content
            end
            local input = exports['rsg-input']:ShowInput({
            header = "Remove Person",
            submitText = "Remove",
                inputs = {
                    {
                        text = "Recipient",
                        name = "citizenid",
                        type = "select",
                        options = option
                    },
                }
            })
            if input ~= nil then
                TriggerServerEvent('rsg-telegram:server:RemovePerson', input.citizenid)
            end
        else
            RSGCore.Functions.Notify("You Need To Add People to Your Addressbook", 'error')
        end
    end)
end)
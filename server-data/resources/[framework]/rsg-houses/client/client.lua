local RSGCore = exports['rsg-core']:GetCoreObject()

local doorLockPrompt = GetRandomIntInRange(0, 0xffffff)
local lockPrompt = nil
local DoorID = nil
local HouseID = nil
local myhouse = nil
local HouseBlip = nil
local blipchecked = false
local checked = false
local doorStatus = '~e~Locked~q~'
local createdEntries = {}
local doorLists = {}


--[[ Functions: Start ]]--

-- Door Lock / Unlock Animation
local UnlockAnimation = function()
    local ped = PlayerPedId()
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")
    local dict = "script_common@jail_cell@unlock@key"

    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(10)
        end
    end

    local prop = CreateObject("P_KEY02X", GetEntityCoords(ped) + vec3(0, 0, 0.2), true, true, true)

    TaskPlayAnim(ped, "script_common@jail_cell@unlock@key", "action", 8.0, -8.0, 2500, 31, 0, true, 0, false, 0, false)
    Wait(750)
    AttachEntityToEntity(prop, ped, boneIndex, 0.02, 0.0120, -0.00850, 0.024, -160.0, 200.0, true, true, false, true, 1, true)

    while IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3) do
        Wait(100)
    end

    DeleteObject(prop)
end

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

    createdEntries[#createdEntries + 1] = {type = "nPROMPT", handle = lockPrompt}
    createdEntries[#createdEntries + 1] = {type = "nPROMPT", handle = doorLockPrompt}
end

--[[ Functions: Start ]]--



--[[ Threads: Start ]]--

-- Real Estate Agent Prompts
CreateThread(function()
    for i = 1, #Config.EstateAgents do
        local agent = Config.EstateAgents[i]

        exports['rsg-core']:createPrompt(agent.prompt, agent.coords, RSGCore.Shared.Keybinds['J'], 'Talk to ' .. agent.name,
        {
            type = 'client',
            event = 'rsg-houses:client:agentmenu',
            args = {agent.location},
        })

        createdEntries[#createdEntries + 1] = {type = "PROMPT", handle = agent.prompt}

        if agent.showblip then
            local AgentBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, agent.coords)
            local blipSprite = GetHashKey(Config.Blip.blipSprite)

            SetBlipSprite(AgentBlip, blipSprite, true)
            SetBlipScale(AgentBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, AgentBlip, Config.Blip.blipName)

            createdEntries[#createdEntries + 1] = {type = "BLIP", handle = AgentBlip}
        end
    end
end)

-- House Blips
AddEventHandler('rsg-houses:client:CheckBlip', function()
    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetOwnedHouseInfo', function(result)
        local houseid = result[1].houseid

        myhouse = houseid
    end)

    while not myhouse do
        Wait(1)
    end

    for i = 1, #Config.Houses do
        local house = Config.Houses[i]

        if Config.OwnedHouseBlips and house.houseid == myhouse then
            HouseBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, house.blipcoords)

            SetBlipSprite(HouseBlip, `blip_proc_home`, true)
            SetBlipScale(HouseBlip, 0.1)
            Citizen.InvokeNative(0x9CB1A1623062F402, HouseBlip, 'Home Sweet Home')

            createdEntries[#createdEntries + 1] = {type = "BLIP", handle = HouseBlip}

            break
        end

        if not Config.OwnedHouseBlips and house.showblip then
            HouseBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, house.blipcoords)

            SetBlipSprite(HouseBlip, `blip_proc_home`, true)
            SetBlipScale(HouseBlip, 0.1)
            Citizen.InvokeNative(0x9CB1A1623062F402, HouseBlip, house.name)

            createdEntries[#createdEntries + 1] = {type = "BLIP", handle = HouseBlip}
        end
    end
end)

-- Check Owned House Blip on Spawn
RegisterNetEvent('rsg-houses:client:BlipsOnSpawn')
AddEventHandler('rsg-houses:client:BlipsOnSpawn', function(blip)
    if blip and blip > 0 then
        RemoveBlip(blip)
    end

    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetOwnedHouseInfo', function(result)
        local houseid = result[1].houseid

        myhouse = houseid
        blipchecked = false

        TriggerEvent('rsg-houses:client:BlipLoop')
    end)
end)

-- Get Owned House Blip
AddEventHandler('rsg-houses:client:BlipLoop', function()
    blipchecked = false

    CreateThread(function()
        while not blipchecked do
            TriggerEvent('rsg-houses:client:CheckBlip')

            blipchecked = true

            Wait(10000)
        end
    end)
end)

-- Get Door State from Database and Set
CreateThread(function()
    while true do
        checked = false

        RSGCore.Functions.TriggerCallback('rsg-houses:server:GetDoorState', function(results)
            for i = 1, #results do
                local door = results[i]

                Citizen.InvokeNative(0xD99229FE93B46286, tonumber(door.doorid), 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
                Citizen.InvokeNative(0x6BAB9442830C7F53, tonumber(door.doorid), door.doorstate) -- DoorSystemSetDoorState
            end
        end)

        Wait(10000)
    end
end)

-- Get Specific Door State from Database
CreateThread(function()
    local ped = PlayerPedId()

    DoorLockPrompt()

    while true do
        ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
        local t = 1000

        for i = 1, #Config.HouseDoors do
            local house = Config.HouseDoors[i]
            local distance = #(playerCoords - house.doorcoords)

            if distance < 2.0 then
                t = 4
                HouseID = house.houseid
                DoorID = house.doorid

                if Config.Debug then
                    print("")
                    print("House ID: "..HouseID)
                    print("Door ID: "..DoorID)
                    print("")
                end

                if not checked then
                    TriggerServerEvent('rsg-houses:server:GetSpecificDoorState', DoorID)
                    checked = true
                end

                local label = CreateVarString(10, 'LITERAL_STRING', house.name..': '..doorStatus)

                PromptSetActiveGroupThisFrame(doorLockPrompt, label)

                if PromptHasHoldModeCompleted(lockPrompt) then
                    TriggerEvent("rsg-houses:client:toggledoor", DoorID, HouseID)
                    t = 1000
                    checked = false
                end
            end
        end

        Wait(t)
    end
end)

-- House Menu Prompt
CreateThread(function()
    for i = 1, #Config.Houses do
        local house = Config.Houses[i]

        exports['rsg-core']:createPrompt(house.houseprompt, house.menucoords, RSGCore.Shared.Keybinds['J'], 'Open House Menu',
        {
            type = 'client',
            event = 'rsg-houses:client:housemenu',
            args = {house.houseid},
        })

        createdEntries[#createdEntries + 1] = {type = "PROMPT", handle = house.houseprompt}
    end
end)

--[[ Threads: End ]]--



--[[ Events: Start ]]--

-- Real Estate Agent Menu
RegisterNetEvent('rsg-houses:client:GetSpecificDoorState', function(id, state)
    DoorID = id
    local doorstate = state

    if doorstate == 1 then
        doorStatus = '~e~Locked~q~'
    else
        doorStatus = '~t6~Unlocked~q~'
    end
end)

RegisterNetEvent('rsg-houses:client:agentmenu', function(location)
    exports['rsg-menu']:openMenu(
    {
        {
            header = 'Estate Agent',
            isMenuHeader = true,
        },
        {
            header = 'Buy Property',
            txt = '',
            icon = "fas fa-home",
            params = {
                event = 'rsg-houses:client:buymenu',
                isServer = false,
                args = { agentlocation = location }
            }
        },
        {
            header = 'Sell Property',
            txt = '',
            icon = "fas fa-home",
            params = {
                event = 'rsg-houses:client:sellmenu',
                isServer = false,
                args = { agentlocation = location }
            }
        },
        {
            header = 'Close Menu',
            txt = '',
            params = {
                event = 'rsg-menu:closeMenu'
            }
        }
    })
end)

-- Buy House Menu
RegisterNetEvent('rsg-houses:client:buymenu', function(data)
    local GetHouseInfo =
    {
        {
            header = 'Buy House',
            isMenuHeader = true,
            icon = "fas fa-home"
        }
    }

    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetHouseInfo', function(cb)
        for i = 1, #cb do
            local house = cb[i]
            local agent = house.agent
            local houseid = house.houseid
            local owned = house.owned
            local price = house.price

            if agent == data.agentlocation and owned == 0 then
                GetHouseInfo[#GetHouseInfo + 1] =
                {
                    header = houseid,
                    txt = 'Price $'..house.price..' : Land Tax $'..Config.LandTaxPerCycle,
                    icon = "fas fa-home",
                    params =
                    {
                        event = 'rsg-houses:server:buyhouse',
                        args =
                        {
                            house = houseid,
                            price = price,
                            blip = HouseBlip
                        },
                        isServer = true
                    }
                }
            end
        end

        exports['rsg-menu']:openMenu(GetHouseInfo)
    end)
end)

-- Sell House Menu
RegisterNetEvent('rsg-houses:client:sellmenu', function(data)
    local GetOwnedHouseInfo =
    {
        {
            header = 'Sell House',
            isMenuHeader = true,
            icon = "fas fa-home"
        }
    }

    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetOwnedHouseInfo', function(cb)
        for i = 1, #cb do
            local house = cb[i]
            local agent = house.agent
            local houseid = house.houseid
            local owned = house.owned
            local sellprice = (house.price * Config.SellBack)

            if agent == data.agentlocation and owned == 1 then
                GetOwnedHouseInfo[#GetOwnedHouseInfo + 1] =
                {
                    header = houseid,
                    txt = 'Sell Price $'..sellprice,
                    icon = "fas fa-home",
                    params =
                    {
                        event = 'rsg-houses:server:sellhouse',
                        args =
                        {
                            house = houseid,
                            price = sellprice,
                            blip = HouseBlip
                        },
                        isServer = true
                    }
                }
            end
        end

        exports['rsg-menu']:openMenu(GetOwnedHouseInfo)
    end)
end)

-- Lock / Unlock Door
RegisterNetEvent('rsg-houses:client:toggledoor', function(door, house)
    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetHouseKeys', function(results)
        for i = 1, #results do
            local housekey = results[i]
            local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid
            local resultcitizenid = housekey.citizenid
            local resulthouseid = housekey.houseid

            if resultcitizenid == playercitizenid and resulthouseid == house then
                RSGCore.Functions.TriggerCallback('rsg-houses:server:GetCurrentDoorState', function(cb)
                    local doorstate = cb

                    if doorstate == 1 then
                        UnlockAnimation()

                        Citizen.InvokeNative(0xD99229FE93B46286, door, 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
                        Citizen.InvokeNative(0x6BAB9442830C7F53, door, 0) -- DoorSystemSetDoorState

                        TriggerServerEvent('rsg-houses:server:UpdateDoorState', door, 0)

                        RSGCore.Functions.Notify('Unlocked!', 'success')

                        doorStatus = '~t6~Unocked~q~'
                    end

                    if doorstate == 0 then
                        UnlockAnimation()

                        Citizen.InvokeNative(0xD99229FE93B46286, door, 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
                        Citizen.InvokeNative(0x6BAB9442830C7F53, door, 1) -- DoorSystemSetDoorState

                        TriggerServerEvent('rsg-houses:server:UpdateDoorState', door, 1)

                        RSGCore.Functions.Notify('Locked!', 'error')

                        doorStatus = '~e~Locked~q~'
                    end
                end, door)
            end

            createdEntries[#createdEntries + 1] = {type = "DOOR", handle = door}
        end
    end)
end)

-- House Menu
RegisterNetEvent('rsg-houses:client:housemenu', function(houseid)
    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetHouseKeys', function(results)
        for i = 1, #results do
            local housekey = results[i]
            local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid
            local citizenid = housekey.citizenid
            local houseids = housekey.houseid
            local guest = housekey.guest

            if citizenid == playercitizenid and houseids == houseid and guest == 0 then
                exports['rsg-menu']:openMenu(
                {
                    {
                        header = 'Owner House Menu',
                        isMenuHeader = true,
                        icon = "fas fa-home"
                    },
                    {
                        header = 'Open Storage',
                        txt = '',
                        icon = 'fas fa-box',
                        params = {
                            event = 'rsg-houses:client:storage',
                            isServer = false,
                            args = {house = houseid}
                        }
                    },
                    {
                        header = 'Outfits',
                        txt = '',
                        icon = 'fas fa-hat-cowboy-side',
                        params = {
                            event = 'rsg-clothes:OpenOutfits',
                            isServer = false,
                            args = {}
                        }
                    },
                    {
                        header = 'Land Tax',
                        txt = '',
                        icon = 'fas fa-dollar-sign',
                        params = {
                            event = 'rsg-houses:client:creditmenu',
                            isServer = false,
                            args = {house = houseid}
                        }
                    },
                    {
                        header = 'House Guests',
                        txt = '',
                        icon = 'fa-solid fa-circle-user',
                        params = {
                            event = 'rsg-houses:client:guestmenu',
                            isServer = false,
                            args = {house = houseid}
                        }
                    },
                    {
                        header = 'Close Menu',
                        txt = '',
                        icon = "fas fa-times",
                        params = {
                            event = 'rsg-menu:closeMenu'
                        }
                    }
                })
            elseif citizenid == playercitizenid and houseids == houseid and guest == 1 then
                exports['rsg-menu']:openMenu(
                {
                    {
                        header = 'Guest House Menu',
                        isMenuHeader = true,
                        icon = "fas fa-home"
                    },
                    {
                        header = 'Open Storage',
                        txt = '',
                        icon = 'fas fa-box',
                        params = {
                            event = 'rsg-houses:client:storage',
                            isServer = false,
                            args = {house = houseid}
                        }
                    },
                    {
                        header = 'Outfits',
                        txt = '',
                        icon = 'fas fa-hat-cowboy-side',
                        params = {
                            event = 'rsg-clothes:OpenOutfits',
                            isServer = false,
                            args = {}
                        }
                    },
                    {
                        header = 'Close Menu',
                        txt = '',
                        icon = "fas fa-times",
                        params = {
                            event = 'rsg-menu:closeMenu'
                        }
                    }
                })
            end
        end
    end)
end)

-- House Credit Menu
RegisterNetEvent('rsg-houses:client:creditmenu', function(data)
    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetOwnedHouseInfo', function(result)
        local housecitizenid = result[1].citizenid
        local houseid = result[1].houseid
        local credit = result[1].credit
        local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid

        if housecitizenid ~= playercitizenid then
            RSGCore.Functions.Notify('You didn\'t own this house!', 'error')
            return
        end

        if housecitizenid == playercitizenid then
            exports['rsg-menu']:openMenu(
            {
                {
                    header = 'Land Tax Credit',
                    isMenuHeader = true,
                    txt = 'current credit $'..credit,
                    icon = "fas fa-home"
                },
                {
                    header = 'Add Credit',
                    txt = '',
                    icon = 'fas fa-dollar-sign',
                    params =
                    {
                        event = 'rsg-houses:client:addcredit',
                        isServer = false,
                        args =
                        {
                            houseid = houseid,
                            credit = credit
                        }
                    }
                },
                {
                    header = 'Close Menu',
                    txt = '',
                    icon = "fas fa-times",
                    params = {
                        event = 'rsg-menu:closeMenu'
                    }
                }
            })
        end
    end)
end)

-- credit form
RegisterNetEvent('rsg-houses:client:addcredit', function(data)
    local dialog = exports['rsg-input']:ShowInput({
        header = 'Add Land Tax Credit',
        submitText = "Add Credit",
        inputs = {
            {
                text = 'Amount',
                name = "addcredit",
                type = "number",
                isRequired = true,
                default = 50,
            },
        }
    })
    if dialog ~= nil then
        for k,v in pairs(dialog) do
            if Config.Debug == true then
                print(dialog.addcredit)
                print(data.houseid)
            end
            local newcredit = (data.credit + dialog.addcredit)
            TriggerServerEvent('rsg-houses:server:addcredit', tonumber(newcredit), tonumber(dialog.addcredit), data.houseid)
        end
    end
end)

-- Guest Menu
RegisterNetEvent('rsg-houses:client:guestmenu', function(data)
    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetOwnedHouseInfo', function(result)
        local housecitizenid = result[1].citizenid
        local houseid = result[1].houseid
        local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid

        if housecitizenid ~= playercitizenid then
            RSGCore.Functions.Notify('You didn\'t own this house!', 'error')
            return
        end

        if housecitizenid == playercitizenid then
            exports['rsg-menu']:openMenu(
            {
                {
                    header = 'House Guests',
                    isMenuHeader = true,
                    txt = '',
                    icon = "fas fa-home"
                },
                {
                    header = 'Add Guest',
                    txt = '',
                    icon = 'fa-solid fa-circle-user',
                    params =
                    {
                        event = 'rsg-houses:client:addguest',
                        isServer = false,
                        args =
                        {
                            houseid = houseid
                        }
                    }
                },
                {
                    header = 'Remove Guest',
                    txt = '',
                    icon = 'fa-solid fa-circle-user',
                    params =
                    {
                        event = 'rsg-houses:client:removeguest',
                        isServer = false,
                        args =
                        {
                            houseid = houseid
                        }
                    }
                },
                {
                    header = 'Close Menu',
                    txt = '',
                    icon = "fas fa-times",
                    params = {
                        event = 'rsg-menu:closeMenu'
                    }
                }
            })
        end
    end)
end)

-- Add House Guest
RegisterNetEvent('rsg-houses:client:addguest', function(data)
    local upr = string.upper
    local dialog = exports['rsg-input']:ShowInput(
    {
        header = 'Add House Guest',
        submitText = "Add",
        inputs =
        {
            {
                text = 'Citizen ID',
                name = "addguest",
                type = "text",
                isRequired = true
            }
        }
    })

    if dialog == nil then return end

    local addguest = dialog.addguest
    local houseid = data.houseid

    if Config.Debug then
        print("")
        print("House ID: "..houseid)
        print("Add Guest: "..addguest)
        print("")
    end

    TriggerServerEvent('rsg-houses:server:addguest', upr(addguest), houseid)
end)

-- Remove House Guest
RegisterNetEvent('rsg-houses:client:removeguest', function(data)
    local GuestMenu =
    {
        {
            header = 'Remove Guest',
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info"
        }
    }

    RSGCore.Functions.TriggerCallback('rsg-houses:server:GetGuestHouseKeys', function(cb)
        for i = 1, #cb do
            local guest = cb[i]
            local houseid = guest.houseid
            local citizenid = guest.citizenid

            if houseid == data.houseid then
                GuestMenu[#GuestMenu + 1] =
                {
                    header = citizenid,
                    txt = '',
                    icon = "fa-solid fa-circle-user",
                    params =
                    {
                        event = "rsg-houses:server:removeguest",
                        isServer = true,
                        args =
                        {
                            guestcid = citizenid,
                            houseid = houseid
                        }
                    }
                }
            end
        end

        GuestMenu[#GuestMenu + 1] =
        {
            header = 'Close',
            icon = "fas fa-times",
            params =
            {
                event = "rsg-menu:closeMenu"
            }
        }

        exports['rsg-menu']:openMenu(GuestMenu)
    end)
end)

-- House Storage
RegisterNetEvent('rsg-houses:client:storage', function(data)
    local house = data.house

    TriggerServerEvent("inventory:server:OpenInventory", "stash", data.house,
    {
        maxweight = Config.StorageMaxWeight,
        slots = Config.StorageMaxSlots,
    })

    TriggerEvent("inventory:client:SetCurrentStash", house)
end)

--[[ Threads: End ]]--



--[[ Resource Cleanup ]]--
AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    for i = 1, #createdEntries do
        if createdEntries[i].type == "BLIP" then
            RemoveBlip(createdEntries[i].handle)
        end

        if createdEntries[i].type == "PROMPT" then
            exports['rsg-core']:deletePrompt(createdEntries[i].handle)
        end

        if createdEntries[i].type == "nPROMPT" then
            PromptDelete(createdEntries[i].handle)
            PromptDelete(createdEntries[i].handle)
        end

        if createdEntries[i].type == "DOOR" then
            Citizen.InvokeNative(0xD99229FE93B46286, createdEntries[i].handle, 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
            Citizen.InvokeNative(0x6BAB9442830C7F53, createdEntries[i].handle, 1) -- DoorSystemSetDoorState

            TriggerServerEvent('rsg-houses:server:UpdateDoorState', createdEntries[i].handle, 1)
        end
    end
end)
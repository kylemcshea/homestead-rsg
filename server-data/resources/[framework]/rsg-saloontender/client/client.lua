local RSGCore = exports['rsg-core']:GetCoreObject()
local PlayerData = RSGCore.Functions.GetPlayerData()
local currentname
local currentzone

-----------------------------------------------------------------------------------

-- job prompts and blips
Citizen.CreateThread(function()
    for saloontender, v in pairs(Config.SaloonTenderLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-saloontender:client:mainmenu',
            args = { v.location, v.coords },
        })
        if v.showblip == true then
            local SaloonTenderBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(SaloonTenderBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(SaloonTenderBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, SaloonTenderBlip, Config.Blip.blipName)
        end
    end
end)

-----------------------------------------------------------------------------------

-- saloontender menu
RegisterNetEvent('rsg-saloontender:client:mainmenu', function(name, zone)
    local job = RSGCore.Functions.GetPlayerData().job.name
    if job == name then
        currentname = name
        currentzone = zone
        exports['rsg-menu']:openMenu({
            {
                header = 'Saloon Tender',
                isMenuHeader = true,
            },
            {
                header = "Saloon Storage",
                txt = "",
                icon = "fas fa-box",
                params = {
                    event = 'rsg-saloontender:client:storage',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = "DukeBox",
                txt = "",
                icon = "fas fa-music",
                params = {
                    event = 'rsg-saloontender:client:musicmenu',
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
        RSGCore.Functions.Notify('you are not authorised!', 'error')
    end
end)

-----------------------------------------------------------------------------------

-- saloon general storage
RegisterNetEvent('rsg-saloontender:client:storage', function()
    local job = RSGCore.Functions.GetPlayerData().job.name
    local stashloc = currentname
    if job == currentname then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashloc, {
            maxweight = Config.StorageMaxWeight,
            slots = Config.StorageMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", stashloc)
    end
end)

-----------------------------------------------------------------------------------

RegisterNetEvent('rsg-saloontender:client:musicmenu', function()
    local name = currentname
    local zone = currentzone
    exports['rsg-menu']:openMenu({
        {
            header = "💿 | DukeBox Menu",
            isMenuHeader = true,
        },
        {
            header = "🎶 | Play Music",
            txt = "Enter a youtube URL",
            params = {
                event = "rsg-saloontender:client:playMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "⏸️ | Pause Music",
            txt = "Pause currently playing music",
            params = {
                event = "rsg-saloontender:client:pauseMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "▶️ | Resume Music",
            txt = "Resume playing paused music",
            params = {
                event = "rsg-saloontender:client:resumeMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "🔈 | Change Volume",
            txt = "Adjust the volume of the music",
            params = {
                event = "rsg-saloontender:client:changeVolume",
                isServer = false,
                args = {},
            }
        },
        {
            header = "❌ | Turn off music",
            txt = "Stop the music & choose a new song",
            params = {
                event = "rsg-saloontender:client:stopMusic",
                isServer = false,
                args = {},
            }
        },
        {
            header = "<< Back",
            txt = '',
            params = {
                event = 'rsg-saloontender:client:mainmenu',
            }
        },
    })
end)

RegisterNetEvent('rsg-saloontender:client:playMusic', function()
    local dialog = exports['rsg-input']:ShowInput({
        header = 'Song Selection',
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'song',
                text = 'YouTube URL'
            }
        }
    })
    if dialog then
        if not dialog.song then return end
        TriggerServerEvent('rsg-saloontender:server:playMusic', dialog.song, currentname, currentzone)
    end
end)

-- change volume
RegisterNetEvent('rsg-saloontender:client:changeVolume', function()
    local dialog = exports['rsg-input']:ShowInput({
        header = 'Music Volume',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('rsg-saloontender:server:changeVolume', dialog.volume, currentname, currentzone)
    end
end)

-- pause music
RegisterNetEvent('rsg-saloontender:client:pauseMusic', function()
    TriggerServerEvent('rsg-saloontender:server:pauseMusic', currentname, currentzone)
end)

-- resume music
RegisterNetEvent('rsg-saloontender:client:resumeMusic', function()
    TriggerServerEvent('rsg-saloontender:server:resumeMusic', currentname, currentzone)
end)

-- stop music
RegisterNetEvent('rsg-saloontender:client:stopMusic', function()
    TriggerServerEvent('rsg-saloontender:server:stopMusic', currentname, currentzone)
end)

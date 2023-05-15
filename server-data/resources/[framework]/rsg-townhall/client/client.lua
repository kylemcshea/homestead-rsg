local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------------------

-- prompts and blips
Citizen.CreateThread(function()
    for townhall, v in pairs(Config.TownHallLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-townhall:client:jobmenu',
            args = {},
        })
        if v.showblip == true then
            local TownhallBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(TownhallBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(TownhallBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, TownhallBlip, Config.Blip.blipName)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        local sleep = 0
        for townhall, v in pairs(Config.TownHallLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

-----------------------------------------------------------------------------------

-- job menu
RegisterNetEvent('rsg-townhall:client:jobmenu', function()
    jobMenu = {}
    jobMenu = {
        {
            header = "💼 | Job Menu",
            isMenuHeader = true,
        },
    }
    for k,v in pairs(Config.Jobs) do
        jobMenu[#jobMenu + 1] = {
            header = 'Job Offer: '..v.lable,
            txt = v.description,
            params = {
                isServer = true,
                event = 'rsg-cityhall:server:ApplyJob',
                args = { job = v.job, lable = v.lable }
            }
        }
    end
    jobMenu[#jobMenu + 1] = {
        header = "❌ | Close Menu",
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(jobMenu)
end)

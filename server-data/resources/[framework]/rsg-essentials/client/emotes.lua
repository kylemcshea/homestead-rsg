-- [[ Exports ]] --
local function doemote(emote)
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, emote, 1, 1, 0, 0)
end exports('doemote', doemote)

local function dodictemote(dict, anim, duration)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    Citizen.InvokeNative(0xEA47FE3719165B94, PlayerPedId(), dict, anim, 8.0, -8.0, duration, 1, 0, true, 0, false, 0, false)
end exports('dodictemote', dodictemote)

-- [[ Events ]] --
RegisterNetEvent("emotes:client:doemote")
AddEventHandler("emotes:client:doemote", function(data)
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, data, 1, 1, 0, 0)
end)

RegisterNetEvent("emotes:client:doemotemenu")
AddEventHandler("emotes:client:doemotemenu", function(data)
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, data.emote, 1, 1, 0, 0)
end)

RegisterNetEvent("emotes:client:dodictemote")
AddEventHandler("emotes:client:dodictemote", function(data)
    local ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    Citizen.InvokeNative(0xEA47FE3719165B94, ped, data.dict, data.anim, 8.0, -8.0, data.duration, 1, 0, true, 0, false, 0, false)
end)

-- [[ Emote Menu ]] --

RegisterNetEvent('emotes:client:EmoteMenu', function()
    exports['rsg-menu']:openMenu({{
        header = Lang:t('emotes.title'),
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = Lang:t('emotes.actions.mainMenu'),
        params = {
            event = 'emotes:client:actionemotes',
        }
    }, {
        header = Lang:t('emotes.greeting.mainMenu'),
        params = {
            event = 'emotes:client:greetemotes'
        }
    }, {
        header = Lang:t('emotes.reaction.mainMenu'),
        params = {
            event = 'emotes:client:reactionemotes'
        }
    },{
        header = Lang:t('emotes.taunting.mainMenu'),
        params = {
            event = 'emotes:client:tauntemotes'
        }
    },{
        header = Lang:t('emotes.close'),
        params = {
            event = 'emotes:client:danceemotes'
        }
    }})
end)

RegisterNetEvent('emotes:client:actionemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = Lang:t('emotes.actions.secondMenu'),
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = Lang:t('emotes.close'),
    }}
    for k, v in pairs(Config.Emotes.Actions) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemotemenu',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:greetemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = Lang:t('emotes.greeting.secondMenu'),
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = Lang:t('emotes.close'),
    }}
    for k, v in pairs(Config.Emotes.Greeting) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemotemenu',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:reactionemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = Lang:t('emotes.reaction.secondMenu'),
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = Lang:t('emotes.close'),
    }}
    for k, v in pairs(Config.Emotes.Reactions) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemotemenu',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:tauntemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = Lang:t('emotes.taunting.secondMenu'),
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = Lang:t('emotes.close'),
    }}
    for k, v in pairs(Config.Emotes.Taunting) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemotemenu',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:danceemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = Lang:t('emotes.dancing.secondMenu'),
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = Lang:t('emotes.close'),
    }}
    for k, v in pairs(Config.Emotes.Dancing) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:dodictemote',
                args = {
                    dict = v.dict,
                    anim = v.anim,
                    duration = v.duration,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)
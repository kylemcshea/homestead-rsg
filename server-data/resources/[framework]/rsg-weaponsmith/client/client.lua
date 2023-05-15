local RSGCore = exports['rsg-core']:GetCoreObject()
local isLoggedIn = false
local PlayerData = {}
local currentjob
local jobaccess

-----------------------------------------------------------------------------------

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = RSGCore.Functions.GetPlayerData()
    currentjob = PlayerData.job.name
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    PlayerData = {}
end)

RegisterNetEvent('RSGCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    currentjob = PlayerData.job.name
end)

-----------------------------------------------------------------------------------

-- prompts and blips
CreateThread(function()
    for weaponsmith, v in pairs(Config.WeaponCraftingPoint) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], Lang:t('menu.open') .. v.name, {
            type = 'client',
            event = 'rsg-weaponsmith:client:mainmenu',
            args = { v.job },
        })
        if v.showblip == true then
            local WeaponSmithBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(WeaponSmithBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(WeaponSmithBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, WeaponSmithBlip, Config.Blip.blipName)
        end

    end
end)

-----------------------------------------------------------------------------------

-- weaponsmith menu
RegisterNetEvent('rsg-weaponsmith:client:mainmenu', function(jobaccess)
    if currentjob == jobaccess then
        exports['rsg-menu']:openMenu({
            {
                header =  Lang:t('menu.weapon_crafting'),
                isMenuHeader = true,
            },
            {
                header = Lang:t('menu.weapon_parts_crafting'),
                txt = "",
                icon = "fas fa-tools",
                params = {
                    event = 'rsg-weaponsmith:client:partsmenu',
                    isServer = false,
                }
            },
            {
                header = Lang:t('menu.weapon_crafting'),
                txt = "",
                icon = "fas fa-tools",
                params = {
                    event = 'rsg-weaponsmith:client:weaponmenu',
                    isServer = false,
                }
            },
            {
                header = Lang:t('menu.weaponsmith_storage'),
                txt = "",
                icon = "fas fa-box",
                params = {
                    event = 'rsg-weaponsmith:client:storage',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = Lang:t('menu.job_management'),
                txt = "",
                icon = "fas fa-user-circle",
                params = {
                    event = 'rsg-bossmenu:client:OpenMenu',
                    isServer = false,
                    args = {},
                }
            },
            {
                header = Lang:t('menu.close_menu'),
                txt = '',
                params = {
                    event = 'rsg-menu:closeMenu',
                }
            },
        })
    else
        RSGCore.Functions.Notify(Lang:t('error.you_are_not_authorised'), 'error')
    end
end)

-- parts menu
RegisterNetEvent('rsg-weaponsmith:client:partsmenu', function()
    partsMenu = {}
    partsMenu = {
        {
            header = Lang:t('menu.weapon_parts_crafting'),
            isMenuHeader = true,
        },
    }
    local item = {}
    for k, v in pairs(Config.WeaponPartsCrafting) do
        partsMenu[#partsMenu + 1] = {
            header = v.lable,
            txt = text,
            icon = 'fas fa-cog',
            params = {
                event = 'rsg-weaponsmith:client:partscheckitems',
                args = {
                    name = v.name,
                    lable = v.lable,
                    item = k,
                    crafttime = v.crafttime,
                    receive = v.receive
                }
            }
        }
    end
    partsMenu[#partsMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(partsMenu)
end)

-- weaponsmith weapon menu
RegisterNetEvent('rsg-weaponsmith:client:weaponmenu', function()
    exports['rsg-menu']:openMenu({
        {
            header = Lang:t('menu.weapon_crafting'),
            isMenuHeader = true,
        },
        {
            header = Lang:t('menu.revolver_crafting'),
            txt = "",
            icon = "fas fa-tools",
            params = {
                event = 'rsg-weaponsmith:client:revlovermenu',
                isServer = false,
            }
        },
        {
            header = Lang:t('menu.pistol_crafting'),
            txt = "",
            icon = "fas fa-tools",
            params = {
                event = 'rsg-weaponsmith:client:pistolmenu',
                isServer = false,
            }
        },
        {
            header = Lang:t('menu.repeater_crafting'),
            txt = "",
            icon = "fas fa-tools",
            params = {
                event = 'rsg-weaponsmith:client:repeatermenu',
                isServer = false,
            }
        },
        {
            header = Lang:t('menu.rifle_crafting'),
            txt = "",
            icon = "fas fa-tools",
            params = {
                event = 'rsg-weaponsmith:client:riflemenu',
                isServer = false,
            }
        },
        {
            header = Lang:t('menu.shotgun_crafting'),
            txt = "",
            icon = "fas fa-tools",
            params = {
                event = 'rsg-weaponsmith:client:shotgunmenu',
                isServer = false,
            }
        },
        {
            header = Lang:t('menu.close_menu'),
            txt = '',
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
end)

-- revlover menu
RegisterNetEvent('rsg-weaponsmith:client:revlovermenu', function()
    revloverMenu = {}
    revloverMenu = {
        {
            header = Lang:t('menu.revolver_crafting'),
            isMenuHeader = true,
        },
    }
    local item = {}
    for k, v in pairs(Config.RevloverCrafting) do
        revloverMenu[#revloverMenu + 1] = {
            header = v.lable,
            txt = '',
            icon = 'fas fa-cog',
            params = {
                event = 'rsg-weaponsmith:client:checkrevloveritems',
                args = {                
                    name = v.name,
                    lable = v.lable,
                    item = k,
                    crafttime = v.crafttime,
                    receive = v.receive
                }
            }
        }
    end
    revloverMenu[#revloverMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(revloverMenu)
end)

-- pistol menu
RegisterNetEvent('rsg-weaponsmith:client:pistolmenu', function()
    pistolMenu = {}
    pistolMenu = {
        {
            header =Lang:t('menu.pistol_crafting'),
            isMenuHeader = true,
        },
    }
    local item = {}
    for k, v in pairs(Config.PistolCrafting) do
        pistolMenu[#pistolMenu + 1] = {
            header = v.lable,
            txt = '',
            icon = 'fas fa-cog',
            params = {
                event = 'rsg-weaponsmith:client:checkpistolitems',
                args = {                
                    name = v.name,
                    lable = v.lable,
                    item = k,
                    crafttime = v.crafttime,
                    receive = v.receive
                }
            }
        }
    end
    pistolMenu[#pistolMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(pistolMenu)
end)

-- repeater menu
RegisterNetEvent('rsg-weaponsmith:client:repeatermenu', function()
    repeaterMenu = {}
    repeaterMenu = {
        {
            header = Lang:t('menu.repeater_crafting'),
            isMenuHeader = true,
        },
    }
    local item = {}
    for k, v in pairs(Config.RepeaterCrafting) do
        repeaterMenu[#repeaterMenu + 1] = {
            header = v.lable,
            txt = '',
            icon = 'fas fa-cog',
            params = {
                event = 'rsg-weaponsmith:client:checkrepeateritems',
                args = {                
                    name = v.name,
                    lable = v.lable,
                    item = k,
                    crafttime = v.crafttime,
                    receive = v.receive
                }
            }
        }
    end
    repeaterMenu[#repeaterMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(repeaterMenu)
end)

-- rifle menu
RegisterNetEvent('rsg-weaponsmith:client:riflemenu', function()
    rifleMenu = {}
    rifleMenu = {
        {
            header = Lang:t('menu.rifle_crafting'),
            isMenuHeader = true,
        },
    }
    local item = {}
    for k, v in pairs(Config.RifleCrafting) do
        rifleMenu[#rifleMenu + 1] = {
            header = v.lable,
            txt = '',
            icon = 'fas fa-cog',
            params = {
                event = 'rsg-weaponsmith:client:checkrifleitems',
                args = {                
                    name = v.name,
                    lable = v.lable,
                    item = k,
                    crafttime = v.crafttime,
                    receive = v.receive
                }
            }
        }
    end
    rifleMenu[#rifleMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(rifleMenu)
end)

-- shotgun menu
RegisterNetEvent('rsg-weaponsmith:client:shotgunmenu', function()
    shotgunMenu = {}
    shotgunMenu = {
        {
            header = Lang:t('menu.shotgun_crafting'),
            isMenuHeader = true,
        },
    }
    local item = {}
    for k, v in pairs(Config.ShotgunCrafting) do
        shotgunMenu[#shotgunMenu + 1] = {
            header = v.lable,
            txt = '',
            icon = 'fas fa-cog',
            params = {
                event = 'rsg-weaponsmith:client:checkshotgunitems',
                args = {                
                    name = v.name,
                    lable = v.lable,
                    item = k,
                    crafttime = v.crafttime,
                    receive = v.receive
                }
            }
        }
    end
    shotgunMenu[#shotgunMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(shotgunMenu)
end)

------------------------------------------------------------------------------------------------------

-- parts crafting : check player has the items
RegisterNetEvent('rsg-weaponsmith:client:partscheckitems', function(data)
    RSGCore.Functions.TriggerCallback('rsg-weaponsmith:server:checkitems', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-weaponsmith:client:startpartscrafting', data.name, data.lable, data.item, tonumber(data.crafttime), data.receive)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, Config.WeaponPartsCrafting[data.item].craftitems)
end)

-- revovler crafting : check player has the items
RegisterNetEvent('rsg-weaponsmith:client:checkrevloveritems', function(data)
    RSGCore.Functions.TriggerCallback('rsg-weaponsmith:server:checkitems', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-weaponsmith:client:startrevlovercrafting', data.name, data.lable, data.item, tonumber(data.crafttime), data.receive)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, Config.RevloverCrafting[data.item].craftitems)
end)

-- pistol crafting : check player has the items
RegisterNetEvent('rsg-weaponsmith:client:checkpistolitems', function(data)
    RSGCore.Functions.TriggerCallback('rsg-weaponsmith:server:checkitems', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-weaponsmith:client:startpistolcrafting', data.name, data.lable, data.item, tonumber(data.crafttime), data.receive)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, Config.PistolCrafting[data.item].craftitems)
end)

-- repeater crafting : check player has the items
RegisterNetEvent('rsg-weaponsmith:client:checkrepeateritems', function(data)
    RSGCore.Functions.TriggerCallback('rsg-weaponsmith:server:checkitems', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-weaponsmith:client:startrepeatercrafting', data.name, data.lable, data.item, tonumber(data.crafttime), data.receive)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, Config.RepeaterCrafting[data.item].craftitems)
end)

-- rifle crafting : check player has the items
RegisterNetEvent('rsg-weaponsmith:client:checkrifleitems', function(data)
    RSGCore.Functions.TriggerCallback('rsg-weaponsmith:server:checkitems', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-weaponsmith:client:startriflecrafting', data.name, data.lable, data.item, tonumber(data.crafttime), data.receive)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, Config.RifleCrafting[data.item].craftitems)
end)

-- shotgun crafting : check player has the items
RegisterNetEvent('rsg-weaponsmith:client:checkshotgunitems', function(data)
    RSGCore.Functions.TriggerCallback('rsg-weaponsmith:server:checkitems', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-weaponsmith:client:startshotguncrafting', data.name, data.lable, data.item, tonumber(data.crafttime), data.receive)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, Config.ShotgunCrafting[data.item].craftitems)
end)

------------------------------------------------------------------------------------------------------

-- start parts crafting
RegisterNetEvent('rsg-weaponsmith:client:startpartscrafting', function(name, lable, item, crafttime, receive)
    local craftitems = Config.WeaponPartsCrafting[item].craftitems
    RSGCore.Functions.Progressbar('craft-parts', Lang:t('progressbar.crafting_a')..lable, crafttime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rsg-weaponsmith:server:finishcrafting', craftitems, receive)
    end)
end)

-- start revlover crafting
RegisterNetEvent('rsg-weaponsmith:client:startrevlovercrafting', function(name, lable, item, crafttime, receive)
    local craftitems = Config.RevloverCrafting[item].craftitems
    RSGCore.Functions.Progressbar('craft-revlover', Lang:t('progressbar.crafting_a')..lable, crafttime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rsg-weaponsmith:server:finishcrafting', craftitems, receive)
    end)
end)

-- start pistol crafting
RegisterNetEvent('rsg-weaponsmith:client:startpistolcrafting', function(name, lable, item, crafttime, receive)
    local craftitems = Config.PistolCrafting[item].craftitems
    RSGCore.Functions.Progressbar('craft-pistol', Lang:t('progressbar.crafting_a')..lable, crafttime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rsg-weaponsmith:server:finishcrafting', craftitems, receive)
    end)
end)

-- start repeater crafting
RegisterNetEvent('rsg-weaponsmith:client:startrepeatercrafting', function(name, lable, item, crafttime, receive)
    local craftitems = Config.RepeaterCrafting[item].craftitems
    RSGCore.Functions.Progressbar('craft-repeater', Lang:t('progressbar.crafting_a')..lable, crafttime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rsg-weaponsmith:server:finishcrafting', craftitems, receive)
    end)
end)

-- start rifle crafting
RegisterNetEvent('rsg-weaponsmith:client:startriflecrafting', function(name, lable, item, crafttime, receive)
    local craftitems = Config.RifleCrafting[item].craftitems
    RSGCore.Functions.Progressbar('craft-rifle', Lang:t('progressbar.crafting_a')..lable, crafttime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rsg-weaponsmith:server:finishcrafting', craftitems, receive)
    end)
end)

-- start shotgun crafting
RegisterNetEvent('rsg-weaponsmith:client:startshotguncrafting', function(name, lable, item, crafttime, receive)
    local craftitems = Config.ShotgunCrafting[item].craftitems
    RSGCore.Functions.Progressbar('craft-shotgun', Lang:t('progressbar.crafting_a')..lable, crafttime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rsg-weaponsmith:server:finishcrafting', craftitems, receive)
    end)
end)

-----------------------------------------------------------------------------------

RegisterNetEvent('rsg-weaponsmith:client:storage', function()
    local playerjob = PlayerData.job.name
    if playerjob == currentjob then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", currentjob, {
            maxweight = Config.StorageMaxWeight,
            slots = Config.StorageMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", currentjob)
    end
end)

-----------------------------------------------------------------------------------

-- clean/inspect weapon
RegisterNetEvent('rsg-weaponsmith:client:serviceweapon', function(item, amount)
    local playerjob = PlayerData.job.name
    if playerjob == currentjob then
        local ped = PlayerPedId()
        local cloth = CreateObject(`s_balledragcloth01x`, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
        local PropId = `CLOTH`
        local actshort = `SHORTARM_CLEAN_ENTER`
        local actlong = `LONGARM_CLEAN_ENTER`
        local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, weaponHash, false)
        local model = GetWeapontypeGroup(weaponHash)
        local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(), 0))
        if Config.Debug == true then
            print("Weapon Group --> "..model)
            print("Weapon Hash --> "..weaponHash)        
        end
        if weaponHash ~= `WEAPON_UNARMED` then
            if model == 416676503 or model == -1101297303 then
                Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), "", cloth, PropId, actshort, 1, 0, -1.0) -- TaskItemInteraction_2
                Wait(15000)
                Citizen.InvokeNative(0xA7A57E89E965D839, object, 0.0, false) -- SetWeaponDegradation
                Citizen.InvokeNative(0xE22060121602493B, object, 0.0, false) -- SetWeaponDamage
                Citizen.InvokeNative(0x812CE61DEBCAB948, object, 0.0, false) -- SetWeaponDirt
                Citizen.InvokeNative(0xA9EF4AD10BDDDB57, object, 0.0, false) -- SetWeaponSoot
                RSGCore.Functions.Notify( Lang:t('success.weapon_cleaned'), 'success')
            else
                Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), "", cloth, PropId, actlong, 1, 0, -1.0) -- TaskItemInteraction_2 
                Wait(15000)
                Citizen.InvokeNative(0xA7A57E89E965D839, object, 0.0, false) -- SetWeaponDegradation
                Citizen.InvokeNative(0xE22060121602493B, object, 0.0, false) -- SetWeaponDamage
                Citizen.InvokeNative(0x812CE61DEBCAB948, object, 0.0, false) -- SetWeaponDirt
                Citizen.InvokeNative(0xA9EF4AD10BDDDB57, object, 0.0, false) -- SetWeaponSoot
                RSGCore.Functions.Notify(Lang:t('success.weapon_cleaned'), 'success')
            end
        else
            RSGCore.Functions.Notify(Lang:t('error.you_must_be_holding_weapon'), 'error')
        end
    else
        RSGCore.Functions.Notify(Lang:t('error.you_are_not_authorised'), 'error')
    end
end)

-----------------------------------------------------------------------------------

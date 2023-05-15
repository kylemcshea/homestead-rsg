local RSGCore = exports['rsg-core']:GetCoreObject()
local PlayerJob = RSGCore.Functions.GetPlayerData().job
local shownBossMenu = false
local DynamicMenuItems = {}
local bossmenu

Citizen.CreateThread(function()
     for bossmenu, v in pairs(Config.BossLocations) do
         exports['rsg-core']:createPrompt(v.bossname, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
             type = 'client',
             event = 'rsg-bossmenu:client:OpenMenu',
             args = { },
         })
         if v.showblip == true then
             local BossBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
			 SetBlipSprite(BossBlip, GetHashKey("blip_honor_good"), true)
             SetBlipScale(BossBlip, 0.2)
			 Citizen.InvokeNative(0x9CB1A1623062F402, BossBlip, v.name)
         end
     end
end)

-- UTIL
local function CloseMenuFull()
    exports['rsg-menu']:closeMenu()
    exports['rsg-core']:HideText()
    shownBossMenu = false
end

local function comma_value(amount)
    local formatted = amount
    while true do
        local k
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

local function AddBossMenuItem(data, id)
    local menuID = id or (#DynamicMenuItems + 1)
    DynamicMenuItems[menuID] = deepcopy(data)
    return menuID
end

exports("AddBossMenuItem", AddBossMenuItem)

local function RemoveBossMenuItem(id)
    DynamicMenuItems[id] = nil
end

exports("RemoveBossMenuItem", RemoveBossMenuItem)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerJob = RSGCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    PlayerJob = RSGCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('RSGCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('rsg-bossmenu:client:OpenMenu', function()
    if not PlayerJob.name or not PlayerJob.isboss then return end

    local bossMenu = {
        {
            header = "Boss Menu - " .. string.upper(PlayerJob.label),
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        },
        {
            header = "Manage Employees",
            txt = "Check your Employees List",
            icon = "fa-solid fa-list",
            params = {
                event = "rsg-bossmenu:client:employeelist",
            }
        },
        {
            header = "Hire Employees",
            txt = "Hire Nearby Civilians",
            icon = "fa-solid fa-hand-holding",
            params = {
                event = "rsg-bossmenu:client:HireMenu",
            }
        },
        {
            header = "Storage Access",
            txt = "Open Storage",
            icon = "fa-solid fa-box-open",
            params = {
                event = "rsg-bossmenu:client:Stash",
            }
        },
        {
            header = "Outfits",
            txt = "See Saved Outfits",
            icon = "fa-solid fa-shirt",
            params = {
                event = "rsg-bossmenu:client:Wardrobe",
            }
        },
        {
            header = "Money Management",
            txt = "Check your Company Balance",
            icon = "fa-solid fa-sack-dollar",
            params = {
                event = "rsg-bossmenu:client:SocietyMenu",
            }
        },
    }

    for _, v in pairs(DynamicMenuItems) do
        bossMenu[#bossMenu + 1] = v
    end

    bossMenu[#bossMenu + 1] = {
        header = "Exit",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "rsg-menu:closeMenu",
        }
    }

    exports['rsg-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('rsg-bossmenu:client:employeelist', function()
    local EmployeesMenu = {
        {
            header = "Manage Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    RSGCore.Functions.TriggerCallback('rsg-bossmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            EmployeesMenu[#EmployeesMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                icon = "fa-solid fa-circle-user",
                params = {
                    event = "rsg-bossmenu:client:ManageEmployee",
                    args = {
                        player = v,
                        work = PlayerJob
                    }
                }
            }
        end
        EmployeesMenu[#EmployeesMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "rsg-bossmenu:client:OpenMenu",
            }
        }
        exports['rsg-menu']:openMenu(EmployeesMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('rsg-bossmenu:client:ManageEmployee', function(data)
    local EmployeeMenu = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info"
        },
    }
    for k, v in pairs(RSGCore.Shared.Jobs[data.work.name].grades) do
        EmployeeMenu[#EmployeeMenu + 1] = {
            header = v.name,
            txt = "Grade: " .. k,
            params = {
                isServer = true,
                event = "rsg-bossmenu:server:GradeUpdate",
                icon = "fa-solid fa-file-pen",
                args = {
                    cid = data.player.empSource,
                    grade = tonumber(k),
                    gradename = v.name
                }
            }
        }
    end
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Fire Employee",
        icon = "fa-solid fa-user-large-slash",
        params = {
            isServer = true,
            event = "rsg-bossmenu:server:FireEmployee",
            args = data.player.empSource
        }
    }
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Return",
        icon = "fa-solid fa-angle-left",
        params = {
            event = "rsg-bossmenu:client:OpenMenu",
        }
    }
    exports['rsg-menu']:openMenu(EmployeeMenu)
end)

RegisterNetEvent('rsg-bossmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerJob.name, {
        maxweight = 4000000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerJob.name)
end)

RegisterNetEvent('rsg-bossmenu:client:Wardrobe', function()
    TriggerEvent('rsg-clothes:OpenOutfits')
end)

RegisterNetEvent('rsg-bossmenu:client:HireMenu', function()
    local HireMenu = {
        {
            header = "Hire Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        },
    }
    RSGCore.Functions.TriggerCallback('rsg-bossmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMenu[#HireMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    icon = "fa-solid fa-user-check",
                    params = {
                        isServer = true,
                        event = "rsg-bossmenu:server:HireEmployee",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMenu[#HireMenu + 1] = {
            header = "Return",
            icon = "fa-solid fa-angle-left",
            params = {
                event = "rsg-bossmenu:client:OpenMenu",
            }
        }
        exports['rsg-menu']:openMenu(HireMenu)
    end)
end)

RegisterNetEvent('rsg-bossmenu:client:SocietyMenu', function()
    RSGCore.Functions.TriggerCallback('rsg-bossmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Balance: $" .. comma_value(cb) .. " - " .. string.upper(PlayerJob.label),
                isMenuHeader = true,
                icon = "fa-solid fa-circle-info",
            },
            {
                header = "Deposit",
                icon = "fa-solid fa-money-bill-transfer",
                txt = "Deposit Money into account",
                params = {
                    event = "rsg-bossmenu:client:SocetyDeposit",
                    args = comma_value(cb)
                }
            },
            {
                header = "Withdraw",
                icon = "fa-solid fa-money-bill-transfer",
                txt = "Withdraw Money from account",
                params = {
                    event = "rsg-bossmenu:client:SocetyWithDraw",
                    args = comma_value(cb)
                }
            },
            {
                header = "Return",
                icon = "fa-solid fa-angle-left",
                params = {
                    event = "rsg-bossmenu:client:OpenMenu",
                }
            },
        }
        exports['rsg-menu']:openMenu(SocietyMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('rsg-bossmenu:client:SocetyDeposit', function(money)
    local deposit = exports['rsg-input']:ShowInput({
        header = "Deposit Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        TriggerServerEvent("rsg-bossmenu:server:depositMoney", tonumber(deposit.amount))
    end
end)

RegisterNetEvent('rsg-bossmenu:client:SocetyWithDraw', function(money)
    local withdraw = exports['rsg-input']:ShowInput({
        header = "Withdraw Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("rsg-bossmenu:server:withdrawMoney", tonumber(withdraw.amount))
    end
end)
local RSGCore = exports['rsg-core']:GetCoreObject()
local campfire = false
local fire
local cookgrill

------------------------------------------------------------------------------------------------------

exports['rsg-target']:AddTargetModel(Config.CampfireProps, {
    options = {
        {
            type = "client",
            event = 'rsg-cooking:client:cookmenu',
            icon = "far fa-eye",
            label = Lang:t('label.open_cooking_menu'),
            distance = 3.0
        }
    }
})

------------------------------------------------------------------------------------------------------

-- setup campfire / use campfire to setup and put out
RegisterNetEvent('rsg-cooking:client:setupcampfire')
AddEventHandler('rsg-cooking:client:setupcampfire', function()
    local ped = PlayerPedId()
    if campfire == true then
        TaskStartScenarioInPlace(ped, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
        Wait(6000)
        ClearPedTasks(ped)
        SetEntityAsMissionEntity(fire)
        DeleteObject(fire)
        SetEntityAsMissionEntity(cookgrill)
        DeleteObject(cookgrill)
        RSGCore.Functions.Notify(Lang:t('primary.campfire_put_out'), 'primary')
        campfire = false
    elseif campfire == false then
        TaskStartScenarioInPlace(ped, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
        Wait(6000)
        ClearPedTasks(ped)
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, -1.55))
        local prop = CreateObject(GetHashKey("p_campfire05x"), x, y+1, z, true, false, true)
        local prop2 = CreateObject(GetHashKey("p_cookgrate01x"), x, y+1, z, true, false, true)
        SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
        SetEntityHeading(prop2, GetEntityHeading(PlayerPedId()))
        PlaceObjectOnGroundProperly(prop)
        PlaceObjectOnGroundProperly(prop2)
        fire = prop
        cookgrill = prop2
        RSGCore.Functions.Notify(Lang:t('primary.campfire_deployed'), 'primary')
        campfire = true
    end
end, false)

------------------------------------------------------------------------------------------------------

-- cook menu
RegisterNetEvent('rsg-cooking:client:cookmenu', function()
    cookMenu = {}
    cookMenu = {
        {
            header = Lang:t('menu.cooking_menu'),
            isMenuHeader = true,
        },
    }
    for k, v in pairs(Config.Recipes) do
        local item = {}
        local text = ""
        for k, v in pairs(v.ingredients) do
            text = text .. "- " .. RSGCore.Shared.Items[v.item].label .. ": " .. v.amount .. "x <br>"
        end
        cookMenu[#cookMenu + 1] = {
            header = k,
            txt = text,
            params = {
                event = 'rsg-cooking:client:checkingredients',
                args = {
                    name = v.name,
                    item = k,
                    cooktime = v.cooktime,
                    receive = v.receive,
                    giveamount = v.giveamount
                }
            }
        }
    end
    cookMenu[#cookMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(cookMenu)
end)

------------------------------------------------------------------------------------------------------

-- check player has the ingredients to cook item
RegisterNetEvent('rsg-cooking:client:checkingredients', function(data)
    RSGCore.Functions.TriggerCallback('rsg-cooking:server:checkingredients', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-cooking:cookmeal', data.name, data.item, tonumber(data.cooktime), data.receive, data.giveamount)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, Config.Recipes[data.item].ingredients)
end)

-- do cooking
RegisterNetEvent('rsg-cooking:cookmeal', function(name, item, cooktime, receive, giveamount)
    local ingredients = Config.Recipes[item].ingredients
    RSGCore.Functions.Progressbar('cook-meal', Lang:t('progressbar.cooking_a')..name, cooktime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rsg-cooking:server:finishcooking', ingredients, receive, giveamount)
    end)
end)

------------------------------------------------------------------------------------------------------

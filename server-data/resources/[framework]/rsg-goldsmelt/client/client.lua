local RSGCore = exports['rsg-core']:GetCoreObject()
local goldsmelt = false

------------------------------------------------------------------------------------------------------

-- setup gold smelt
RegisterNetEvent('rsg-goldsmelt:client:setupgoldsmelt')
AddEventHandler('rsg-goldsmelt:client:setupgoldsmelt', function()
	local ped = PlayerPedId()
    if goldsmelt == true then
		CrouchAnim()
		Wait(6000)
		ClearPedTasks(ped)
        SetEntityAsMissionEntity(smelt)
        DeleteObject(smelt)
		RSGCore.Functions.Notify('gold smelt put away', 'primary')
		goldsmelt = false
    elseif goldsmelt == false then
		CrouchAnim()
		Wait(6000)
		ClearPedTasks(ped)
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, -1.55))
		local prop = CreateObject(GetHashKey("p_goldsmeltburner01x"), x, y, z, true, false, true)
		SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
		PlaceObjectOnGroundProperly(prop)
		smelt = prop
		RSGCore.Functions.Notify(Lang:t('primary.gold_smelt_deployed'), 'primary')
		goldsmelt = true
	end
end, false)

-- trigger smelt menu
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		for _,v in pairs(Config.SmeltProps) do
			local smeltObject = GetClosestObjectOfType(pos, 5.0, GetHashKey(v), false, false, false)
			if smeltObject ~= 0 then
				local objectPos = GetEntityCoords(smeltObject)
				if #(pos - objectPos) < 3.0 then
					awayFromObject = false
					DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "Smelt Gold [J]")
					if IsControlJustReleased(0, RSGCore.Shared.Keybinds['J']) then
						TriggerEvent('rsg-goldsmelt:client:smeltmenu')
					end
				end
			end
		end
		if awayFromObject then
			Wait(1000)
		end
	end
end)

------------------------------------------------------------------------------------------------------

-- smelt menu
RegisterNetEvent('rsg-goldsmelt:client:smeltmenu', function()
    smeltMenu = {}
    smeltMenu = {
        {
            header = Lang:t('menu.smelting_menu'),
            isMenuHeader = true,
        },
    }
    for k, v in pairs(Config.SmeltOptions) do
        local item = {}
        local text = ""
        for k, v in pairs(v.smeltitems) do
            text = text .. "- " .. RSGCore.Shared.Items[v.item].label .. ": " .. v.amount .. "x <br>"
        end
        smeltMenu[#smeltMenu + 1] = {
            header = k,
            txt = text,
            params = {
                event = 'rsg-goldsmelt:client:checkinggolditems',
                args = {
					name = v.name,
                    item = k,
                    smelttime = v.smelttime,
					receive = v.receive
                }
            }
        }
    end
    smeltMenu[#smeltMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'rsg-menu:closeMenu',
        }
    }
    exports['rsg-menu']:openMenu(smeltMenu)
end)

------------------------------------------------------------------------------------------------------

-- check player has the items
RegisterNetEvent('rsg-goldsmelt:client:checkinggolditems', function(data)
	RSGCore.Functions.TriggerCallback('rsg-goldsmelt:server:checkinggolditems', function(hasRequired)
    if (hasRequired) then
		if Config.Debug == true then
			print("passed")
		end
		TriggerEvent('rsg-goldsmelt:client:dosmelt', data.name, data.item, tonumber(data.smelttime), data.receive)
	else
		if Config.Debug == true then
			print("failed")
		end
		return
	end
	end, Config.SmeltOptions[data.item].smeltitems)
end)

-- do smelting
RegisterNetEvent('rsg-goldsmelt:client:dosmelt', function(name, item, smelttime, receive)
	local smeltitems = Config.SmeltOptions[item].smeltitems
	RSGCore.Functions.Progressbar('smelt-gold', Lang:t('progressbar.smelting_a')..name, smelttime, false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		TriggerServerEvent('rsg-goldsmelt:server:finishsmelting', smeltitems, receive)
	end)
end)

------------------------------------------------------------------------------------------------------

-- ped crouch
function CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

------------------------------------------------------------------------------------------------------

-- text for trigger
function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

------------------------------------------------------------------------------------------------------


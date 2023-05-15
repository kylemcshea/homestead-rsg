local RSGCore = exports['rsg-core']:GetCoreObject()

-- use goldsmelt
RSGCore.Functions.CreateUseableItem("goldsmelt", function(source, item)
    local src = source
	TriggerClientEvent('rsg-goldsmelt:client:setupgoldsmelt', src, item.name)
end)

-- check player has items
RSGCore.Functions.CreateCallback('rsg-goldsmelt:server:checkinggolditems', function(source, cb, smeltitems)
    local src = source
    local hasItems = false
    local icheck = 0
    local Player = RSGCore.Functions.GetPlayer(src)
	for k, v in pairs(smeltitems) do
		if Player.Functions.GetItemByName(v.item) and Player.Functions.GetItemByName(v.item).amount >= v.amount then
			icheck = icheck + 1
			if icheck == #smeltitems then
				cb(true)
			end
		else
			TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_donthave_the_required_items'), 'error')
			cb(false)
			return
		end
	end
end)

-- finish smelting
RegisterServerEvent('rsg-goldsmelt:server:finishsmelting')
AddEventHandler('rsg-goldsmelt:server:finishsmelting', function(smeltitems, receive)
	local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
	-- remove smeltitems
	for k, v in pairs(smeltitems) do
		if Config.Debug == true then
			print(v.item)
			print(v.amount)
		end
		Player.Functions.RemoveItem(v.item, v.amount)
		TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[v.item], "remove")
	end
	-- add items
	Player.Functions.AddItem(receive, 1)
	TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[receive], "add")
	TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.smelting_finished'), 'success')
end)

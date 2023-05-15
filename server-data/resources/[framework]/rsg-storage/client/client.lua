local RSGCore = exports['rsg-core']:GetCoreObject()

-- valentine --
Citizen.CreateThread(function()
	exports['rsg-core']:createPrompt('valentine-storage-1', vector3(-179.3819, 648.2138, 113.58127), RSGCore.Shared.Keybinds['J'], 'Open Valentine Storage', {
		type = 'client',
		event = 'rsg-storage:client:valstorage',
		args = { false, true, false },
	})
	local StorageBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(-179.3819, 648.2138, 113.58127))
	SetBlipSprite(StorageBlip, Config.Blip.blipSprite, 1)
	SetBlipScale(StorageBlip, Config.Blip.blipScale)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, Config.Blip.blipName)
end)

RegisterNetEvent('rsg-storage:client:valstorage', function()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'valstore'..cid, {
        maxweight = Config.ValentineMaxWeight,
        slots = Config.ValentineMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'valstore'..cid)
	end)
end)

-- blackwater --
Citizen.CreateThread(function()
	exports['rsg-core']:createPrompt('blackwater-storage-1', vector3(-733.6947, -1253.501, 44.734077), RSGCore.Shared.Keybinds['J'], 'Open Blackwater Storage', {
		type = 'client',
		event = 'rsg-storage:client:blkstorage',
		args = { false, true, false },
	})
	local StorageBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(-734.923, -1254.389, 44.734107))
	SetBlipSprite(StorageBlip, Config.Blip.blipSprite, 1)
	SetBlipScale(StorageBlip, Config.Blip.blipScale)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, Config.Blip.blipName)
end)

RegisterNetEvent('rsg-storage:client:blkstorage', function()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'blkstore'..cid, {
        maxweight = Config.BlackwaterMaxWeight,
        slots = Config.BlackwaterMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'blkstore'..cid)
	end)
end)

-- stdenis --
Citizen.CreateThread(function()
	exports['rsg-core']:createPrompt('stdenis-storage-1', vector3(2669.6577, -1500.203, 45.968963), RSGCore.Shared.Keybinds['J'], 'Open StDenis Storage', {
		type = 'client',
		event = 'rsg-storage:client:denstorage',
		args = { false, true, false },
	})
	local StorageBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(2669.6577, -1500.203, 45.968963))
	SetBlipSprite(StorageBlip, Config.Blip.blipSprite, 1)
	SetBlipScale(StorageBlip, Config.Blip.blipScale)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, Config.Blip.blipName)
end)

RegisterNetEvent('rsg-storage:client:denstorage', function()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'denstore'..cid, {
        maxweight = Config.StdenisMaxWeight,
        slots = Config.StdenisMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'denstore'..cid)
	end)
end)

-- rhodes --
Citizen.CreateThread(function()
	exports['rsg-core']:createPrompt('rhodes-storage-1', vector3(1231.0391, -1277.829, 76.021591), RSGCore.Shared.Keybinds['J'], 'Open Rhodes Storage', {
		type = 'client',
		event = 'rsg-storage:client:rhostorage',
		args = { false, true, false },
	})
	local StorageBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(1231.0391, -1277.829, 76.021591))
	SetBlipSprite(StorageBlip, Config.Blip.blipSprite, 1)
	SetBlipScale(StorageBlip, Config.Blip.blipScale)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, Config.Blip.blipName)
end)

RegisterNetEvent('rsg-storage:client:rhostorage', function()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'rhostore'..cid, {
        maxweight = Config.RhodesMaxWeight,
        slots = Config.RhodesMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'rhostore'..cid)
	end)
end)

-- annesburg --
Citizen.CreateThread(function()
	exports['rsg-core']:createPrompt('annesburg-storage-1', vector3(2934.8232, 1306.6634, 44.47974), RSGCore.Shared.Keybinds['J'], 'Open Annesburg Storage', {
		type = 'client',
		event = 'rsg-storage:client:annstorage',
		args = { false, true, false },
	})
	local StorageBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(2934.8232, 1306.6634, 44.47974))
	SetBlipSprite(StorageBlip, Config.Blip.blipSprite, 1)
	SetBlipScale(StorageBlip, Config.Blip.blipScale)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, Config.Blip.blipName)
end)

RegisterNetEvent('rsg-storage:client:annstorage', function()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'annstore'..cid, {
        maxweight = Config.AnnesburgMaxWeight,
        slots = Config.AnnesburgMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'annstore'..cid)
	end)
end)

-- strawberry --
Citizen.CreateThread(function()
	exports['rsg-core']:createPrompt('strawberry-storage-1', vector3(-1752.021, -386.3956, 156.49397), RSGCore.Shared.Keybinds['J'], 'Open Strawberry Storage', {
		type = 'client',
		event = 'rsg-storage:client:strstorage',
		args = { false, true, false },
	})
	local StorageBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(-1752.021, -386.3956, 156.49397))
	SetBlipSprite(StorageBlip, Config.Blip.blipSprite, 1)
	SetBlipScale(StorageBlip, Config.Blip.blipScale)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, Config.Blip.blipName)
end)

RegisterNetEvent('rsg-storage:client:strstorage', function()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'strstore'..cid, {
        maxweight = Config.StrawberryMaxWeight,
        slots = Config.StrawberryMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'strstore'..cid)
	end)
end)

-- tumbleweed --
Citizen.CreateThread(function()
	exports['rsg-core']:createPrompt('tumbleweed-storage-1', vector3(-5494.741, -2959.111, -0.69497), RSGCore.Shared.Keybinds['J'], 'Open Tumbleweed Storage', {
		type = 'client',
		event = 'rsg-storage:client:tumstorage',
		args = { false, true, false },
	})
	local StorageBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(-5494.741, -2959.111, -0.69497))
	SetBlipSprite(StorageBlip, Config.Blip.blipSprite, 1)
	SetBlipScale(StorageBlip, Config.Blip.blipScale)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, Config.Blip.blipName)
end)

RegisterNetEvent('rsg-storage:client:tumstorage', function()
	RSGCore.Functions.GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'tumstore'..cid, {
        maxweight = Config.TumbleweedMaxWeight,
        slots = Config.TumbleweedMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'tumstore'..cid)
	end)
end)
local discordAppId  = Config.Discord["discord_id"]
local joinUrl       = Config.Discord["discord_joinurl"]
local website       = Config.Discord["discord_connecturl"]

local isRDR = not TerraingridActivate

local function getZoneName(coords, type)
	local zoneHash = Citizen.InvokeNative(0x43AD8FC02B429D33, coords.x, coords.y, coords.z, type)
	return zoneNames[zoneHash]
end

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local playerName = GetPlayerName(PlayerId())
		local playerCoords = GetEntityCoords(playerPed)
		local health = GetEntityHealth(playerPed)

		SetDiscordAppId(discordAppId)

		local location

		if isRDR then
			local town = getZoneName(playerCoords, 1)
			local district = getZoneName(playerCoords, 10)
			local state = getZoneName(playerCoords, 0)

			if town then
				location = town
			elseif district then
				location = district
			elseif state then
				location = state
			else
				location = "Unknown"
			end
		else
			local zone = GetLabelText(GetNameOfZone(playerCoords))

			local street, crossing = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
			local streetName = GetStreetNameFromHashKey(street)
			local crossingName = GetStreetNameFromHashKey(crossing)
			local road
			if crossingName ~= "" then
				road = streetName .. " & " .. crossingName
			else
				road = streetName
			end

			loation = road .. ", " .. zone
		end

		SetRichPresence(location)

		SetDiscordRichPresenceAsset(Config.Discord["discord_big_image"])
		SetDiscordRichPresenceAssetText(playerName)

		SetDiscordRichPresenceAssetSmall(Config.Discord["discord_small_image"])
		SetDiscordRichPresenceAssetSmallText("Health: " .. health)

		SetDiscordRichPresenceAction(0, "Discord", joinUrl)
		SetDiscordRichPresenceAction(1, "Website", website)

		Citizen.Wait(5000)
	end
end)
local RSGCore = exports['rsg-core']:GetCoreObject()

-- make bait useable
RSGCore.Functions.CreateUseableItem("p_baitbread01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_baitcorn01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_baitcheese01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_baitworm01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_baitcricket01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_crawdad01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_finishedragonfly01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_finisdfishlure01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_finishdcrawd01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_finishedragonflylegendary01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("p_finisdfishlurelegendary01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_finishdcrawdlegendary01x", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_lgoc_spinner_v4", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)

RSGCore.Functions.CreateUseableItem("p_lgoc_spinner_v6", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("rsg-fishing:client:usebait", source, item.name)
end)
-- end of make bait useable

-- remove bait when used on fishing rod
RegisterServerEvent('rsg-fishing:server:removeBaitItem')
AddEventHandler('rsg-fishing:server:removeBaitItem', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item], "remove")
end)

local fishEntity = {
    [`A_C_FISHBLUEGIL_01_MS`]        = "a_c_fishbluegil_01_ms",
    [`A_C_FISHBLUEGIL_01_SM`]        = "a_c_fishbluegil_01_sm",
    [`A_C_FISHBULLHEADCAT_01_MS`]    = "a_c_fishbullheadcat_01_ms",
    [`A_C_FISHBULLHEADCAT_01_SM`]    = "a_c_fishbullheadcat_01_sm",
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = "a_c_fishchainpickerel_01_ms",
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = "a_c_fishchainpickerel_01_sm",
    [`A_C_FISHCHANNELCATFISH_01_LG`] = "a_c_fishchannelcatfish_01_lg",
    [`A_C_FISHCHANNELCATFISH_01_XL`] = "a_c_fishchannelcatfish_01_xl",
    [`A_C_FISHLAKESTURGEON_01_LG`]   = "a_c_fishlakesturgeon_01_lg",
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = "a_c_fishlargemouthbass_01_lg",
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = "a_c_fishlargemouthbass_01_ms",
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = "a_c_fishlongnosegar_01_lg",
    [`A_C_FISHMUSKIE_01_LG`]         = "a_c_fishmuskie_01_lg",
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = "a_c_fishnorthernpike_01_lg",
    [`A_C_FISHPERCH_01_MS`]          = "a_c_fishperch_01_ms",
    [`A_C_FISHPERCH_01_SM`]          = "a_c_fishperch_01_sm",
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = "a_c_fishrainbowtrout_01_lg",
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = "a_c_fishrainbowtrout_01_ms",
    [`A_C_FISHREDFINPICKEREL_01_MS`] = "a_c_fishredfinpickerel_01_ms",
    [`A_C_FISHREDFINPICKEREL_01_SM`] = "a_c_fishredfinpickerel_01_sm",
    [`A_C_FISHROCKBASS_01_MS`]       = "a_c_fishrockbass_01_ms",
    [`A_C_FISHROCKBASS_01_SM`]       = "a_c_fishrockbass_01_sm",
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = "a_c_fishsalmonsockeye_01_lg",
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = "a_c_fishsalmonsockeye_01_ml",
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = "a_c_fishsalmonsockeye_01_ms",
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = "a_c_fishsmallmouthbass_01_lg",
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = "a_c_fishsmallmouthbass_01_ms",
}

local fishNames = {
    [`A_C_FISHBLUEGIL_01_MS`]        = Config.fishData.A_C_FISHBLUEGIL_01_MS[1],
    [`A_C_FISHBLUEGIL_01_SM`]        = Config.fishData.A_C_FISHBLUEGIL_01_SM[1],
    [`A_C_FISHBULLHEADCAT_01_MS`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_MS[1],
    [`A_C_FISHBULLHEADCAT_01_SM`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_SM[1],
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_MS[1],
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_SM[1],
    [`A_C_FISHCHANNELCATFISH_01_LG`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_LG[1],
    [`A_C_FISHCHANNELCATFISH_01_XL`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_XL[1],
    [`A_C_FISHLAKESTURGEON_01_LG`]   = Config.fishData.A_C_FISHLAKESTURGEON_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_MS[1],
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = Config.fishData.A_C_FISHLONGNOSEGAR_01_LG[1],
    [`A_C_FISHMUSKIE_01_LG`]         = Config.fishData.A_C_FISHMUSKIE_01_LG[1],
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = Config.fishData.A_C_FISHNORTHERNPIKE_01_LG[1],
    [`A_C_FISHPERCH_01_MS`]          = Config.fishData.A_C_FISHPERCH_01_MS[1],
    [`A_C_FISHPERCH_01_SM`]          = Config.fishData.A_C_FISHPERCH_01_SM[1],
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_LG[1],
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_MS`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_SM`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_SM[1],
    [`A_C_FISHROCKBASS_01_MS`]       = Config.fishData.A_C_FISHROCKBASS_01_MS[1],
    [`A_C_FISHROCKBASS_01_SM`]       = Config.fishData.A_C_FISHROCKBASS_01_SM[1],
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_LG[1],
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_ML[1],
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_MS[1],
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_LG[1],
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_MS[1],
}

-- add fish caught to inventory
RegisterServerEvent('rsg-fishing:FishToInventory')
AddEventHandler("rsg-fishing:FishToInventory", function(fishModel, weight)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local fish = fishEntity[fishModel]
    local fish_name = fishNames[fishModel]
    local fish_weight = string.format("%.2f%%", (weight * 54.25)):gsub("%%", "")
    Player.Functions.AddItem(fish, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[fish], "add")
    TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.you_got_fish_name',{fish_name = fish_name}), 'primary')
    TriggerEvent('rsg-log:server:CreateLog', 'fishing', 'Fish Caught', 'green', firstname..' '..lastname..' caught a '..fish_weight..'KG '..fish_name)
end)

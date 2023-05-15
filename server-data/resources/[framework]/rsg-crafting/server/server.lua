local RSGCore = exports['rsg-core']:GetCoreObject()

--------------------------------------------------------------------------

-- get crafting rep
RSGCore.Commands.Add('craftingrep',  Lang:t('commands.get_your_crafting_reputation'), {}, false, function(source)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local craftingRep = Player.PlayerData.metadata['craftingrep']
    TriggerClientEvent('RSGCore:Notify', src,  Lang:t('primary.your_crafting_rep_is')..craftingRep, 'primary')
end)

--------------------------------------------------------------------------

-- bpo shovel copy
RSGCore.Functions.CreateUseableItem('bposhovel', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    ------------------------
    local bpo = 'bposhovel'
    local bpc = 'bpcshovel'
    local name = 'Shovel'
    local repneeded = Config.ShovelRepRequired
    local copycost = Config.ShovelCopyCost
    ------------------------
    local cashBalance = Player.PlayerData.money["cash"]
    local craftingRep = Player.PlayerData.metadata['craftingrep']
    if craftingRep >= repneeded then
        if cashBalance >= copycost then
            Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.taken_for_the_copy',{copycost = copycost}), 'success')
            TriggerClientEvent('rsg-crafting:client:makecopy', src, bpo, bpc, name)
        else 
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_dont_have_enough_cash_to_do_that'), 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src,  Lang:t('error.not_enough_reputation_repneeded_required',{repneeded = repneeded}), 'error')
    end
end)

-- craft shovel
RegisterServerEvent('rsg-crafting:server:craftshovel')
AddEventHandler('rsg-crafting:server:craftshovel', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local craftingRep = Player.PlayerData.metadata["craftingrep"]
    if craftingRep >= Config.ShovelRepRequired then
        -- remove items
        Player.Functions.RemoveItem('bpcshovel', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['bpcshovel'], "remove")
        Player.Functions.RemoveItem('steel', 3)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['steel'], "remove")
        Player.Functions.RemoveItem('wood', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['wood'], "remove")
        -- add items
        Player.Functions.AddItem('shovel', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['shovel'], "add")
        Player.Functions.SetMetaData("craftingrep", Player.PlayerData.metadata["craftingrep"] + 1)
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.crafting_successful'), 'success')
        Wait(5000)
        TriggerEvent('rsg-crafting:server:craftingrep', src)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.not_enough_crafting_reputation_to_make_this'), 'success')
    end
end)

--------------------------------------------------------------------------

-- bpo axe copy
RSGCore.Functions.CreateUseableItem('bpoaxe', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    ------------------------
    local bpo = 'bpoaxe'
    local bpc = 'bpcaxe'
    local name = 'Axe'
    local repneeded = Config.AxeRepRequired
    local copycost = Config.AxeCopyCost
    ------------------------
    local cashBalance = Player.PlayerData.money["cash"]
    local craftingRep = Player.PlayerData.metadata['craftingrep']
    if craftingRep >= repneeded then
        if cashBalance >= copycost then
            Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.taken_for_the_copy',{copycost = copycost}), 'success')
            TriggerClientEvent('rsg-crafting:client:makecopy', src, bpo, bpc, name)
        else 
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_dont_have_enough_cash_to_do_that'), 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.not_enough_reputation_repneeded_required',{repneeded = repneeded}), 'error')
    end
end)

-- craft axe
RegisterServerEvent('rsg-crafting:server:craftaxe')
AddEventHandler('rsg-crafting:server:craftaxe', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local craftingRep = Player.PlayerData.metadata["craftingrep"]
    if craftingRep >= Config.AxeRepRequired then
        -- remove items
        Player.Functions.RemoveItem('bpcaxe', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['bpcaxe'], "remove")
        Player.Functions.RemoveItem('steel', 3)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['steel'], "remove")
        Player.Functions.RemoveItem('wood', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['wood'], "remove")
        -- add items
        Player.Functions.AddItem('axe', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['axe'], "add")
        Player.Functions.SetMetaData("craftingrep", Player.PlayerData.metadata["craftingrep"] + 1)
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.crafting_successful'), 'success')
        Wait(5000)
        TriggerEvent('rsg-crafting:server:craftingrep', src)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.not_enough_crafting_reputation_to_make_this'), 'success')
    end
end)

--------------------------------------------------------------------------

-- bpo pickaxe copy
RSGCore.Functions.CreateUseableItem('bpopickaxe', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    ------------------------
    local bpo = 'bpopickaxe'
    local bpc = 'bpcpickaxe'
    local name = 'PickAxe'
    local repneeded = Config.PickAxeRepRequired
    local copycost = Config.PickAxeCopyCost
    ------------------------
    local cashBalance = Player.PlayerData.money["cash"]
    local craftingRep = Player.PlayerData.metadata['craftingrep']
    if craftingRep >= repneeded then
        if cashBalance >= copycost then
            Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.taken_for_the_copy',{copycost = copycost}), 'success')
            TriggerClientEvent('rsg-crafting:client:makecopy', src, bpo, bpc, name)
        else 
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.you_dont_have_enough_cash_to_do_that'), 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('error.not_enough_reputation_repneeded_required',{repneeded = repneeded}), 'error')
    end
end)

-- craft pickaxe
RegisterServerEvent('rsg-crafting:server:craftpickaxe')
AddEventHandler('rsg-crafting:server:craftpickaxe', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local craftingRep = Player.PlayerData.metadata["craftingrep"]
    if craftingRep >= Config.AxeRepRequired then
        -- remove items
        Player.Functions.RemoveItem('bpcpickaxe', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['bpcpickaxe'], "remove")
        Player.Functions.RemoveItem('steel', 3)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['steel'], "remove")
        Player.Functions.RemoveItem('wood', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['wood'], "remove")
        -- add items
        Player.Functions.AddItem('pickaxe', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['pickaxe'], "add")
        Player.Functions.SetMetaData("craftingrep", Player.PlayerData.metadata["craftingrep"] + 1)
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.crafting_successful'), 'success')
        Wait(5000)
        TriggerEvent('rsg-crafting:server:craftingrep', src)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t('success.not_enough_crafting_reputation_to_make_this'), 'success')
    end
end)

--------------------------------------------------------------------------

-- give blueprint copy
RegisterServerEvent('rsg-crafting:server:givecopy')
AddEventHandler('rsg-crafting:server:givecopy', function(copy)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(copy, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[copy], "add")
end)

-- get new craftingrep
RegisterServerEvent('rsg-crafting:server:craftingrep')
AddEventHandler('rsg-crafting:server:craftingrep', function(source)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata["craftingrep"]
    TriggerClientEvent('RSGCore:Notify', src, Lang:t('primary.your_crafting_reputation_increased_to').. curRep, 'primary')
end)

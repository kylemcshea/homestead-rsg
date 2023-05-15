local RSGCore = exports['rsg-core']:GetCoreObject()

-- store pelt to inventory
RegisterNetEvent('rsg-trapperplus:server:storepelt')
AddEventHandler('rsg-trapperplus:server:storepelt', function(rewarditem1, rewarditem2)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(rewarditem1, 1)
	Player.Functions.AddItem(rewarditem2, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem1], "add")
	TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem2], "add")
end)

RegisterServerEvent('rsg-trapperplus:server:sellpelts')
AddEventHandler('rsg-trapperplus:server:sellpelts', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local price = 0
    local haspelts = false
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then
                -- bear_pelt
                if Player.PlayerData.items[k].name == "poor_bear_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_bear_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_bear_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_bear_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_bear_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_bear_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- black_bear_pelt
                elseif Player.PlayerData.items[k].name == "poor_black_bear_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_black_bear_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_black_bear_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_black_bear_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_black_bear_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_black_bear_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- poor_boar_pelt
                elseif Player.PlayerData.items[k].name == "poor_boar_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_boar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_boar_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_boar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_boar_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_boar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- buck_pelt
                elseif Player.PlayerData.items[k].name == "poor_buck_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_buck_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_buck_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_buck_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_buck_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_buck_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- buffalo_pelt
                elseif Player.PlayerData.items[k].name == "poor_buffalo_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_buffalo_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_buffalo_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_buffalo_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_buffalo_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_buffalo_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- bull_pelt
                elseif Player.PlayerData.items[k].name == "poor_bull_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_bull_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_bull_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_bull_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_bull_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_bull_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- cougar_pelt
                elseif Player.PlayerData.items[k].name == "poor_cougar_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_cougar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_cougar_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_cougar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_cougar_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_cougar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- cow_pelt
                elseif Player.PlayerData.items[k].name == "poor_cow_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_cow_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_cow_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_cow_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_cow_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_cow_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- coyote_pelt
                elseif Player.PlayerData.items[k].name == "poor_coyote_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_coyote_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_coyote_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_cow_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_coyote_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_coyote_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- deer_pelt
                elseif Player.PlayerData.items[k].name == "poor_deer_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_deer_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_deer_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_deer_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_deer_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_deer_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- elk_pelt
                elseif Player.PlayerData.items[k].name == "poor_elk_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_elk_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_elk_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_elk_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_elk_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_elk_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- fox_pelt
                elseif Player.PlayerData.items[k].name == "poor_fox_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_fox_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_fox_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_fox_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_fox_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_fox_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- goat_pelt
                elseif Player.PlayerData.items[k].name == "poor_goat_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_goat_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_goat_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_goat_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_goat_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_goat_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- javelina_pelt
                elseif Player.PlayerData.items[k].name == "poor_javelina_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_javelina_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_javelina_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_javelina_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_javelina_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_javelina_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- moose_pelt
                elseif Player.PlayerData.items[k].name == "poor_moose_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_moose_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_moose_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_moose_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_moose_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_moose_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- ox_pelt
                elseif Player.PlayerData.items[k].name == "poor_ox_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_ox_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_ox_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_ox_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_ox_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_ox_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- panther_pelt
                elseif Player.PlayerData.items[k].name == "poor_panther_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_panther_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_panther_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_panther_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_panther_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_panther_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- pig_pelt
                elseif Player.PlayerData.items[k].name == "poor_pig_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_pig_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_pig_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_pig_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_pig_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_pig_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- pronghorn_pelt
                elseif Player.PlayerData.items[k].name == "poor_pronghorn_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_pronghorn_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_pronghorn_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_pronghorn_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_pronghorn_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_pronghorn_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- bighornram_pelt
                elseif Player.PlayerData.items[k].name == "poor_bighornram_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_bighornram_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_bighornram_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_bighornram_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_bighornram_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_bighornram_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- sheep_pelt
                elseif Player.PlayerData.items[k].name == "poor_sheep_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_sheep_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_sheep_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_sheep_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_sheep_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_sheep_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- wolf_pelt
                elseif Player.PlayerData.items[k].name == "poor_wolf_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_wolf_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_wolf_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_wolf_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_wolf_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_wolf_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- alligator_pelt
                elseif Player.PlayerData.items[k].name == "poor_alligator_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_alligator_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_alligator_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_alligator_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_alligator_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_alligator_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- legendary_alligator_pelt
                elseif Player.PlayerData.items[k].name == "legendary_alligator_pelt" then 
                    price = price + (Config.LegendaryPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("legendary_alligator_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- legendary_boar_pelt
                elseif Player.PlayerData.items[k].name == "legendary_boar_pelt" then 
                    price = price + (Config.LegendaryPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("legendary_boar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- legendary_cougar_pelt
                elseif Player.PlayerData.items[k].name == "legendary_cougar_pelt" then 
                    price = price + (Config.LegendaryPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("legendary_cougar_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- legendary_coyote_pelt
                elseif Player.PlayerData.items[k].name == "legendary_coyote_pelt" then 
                    price = price + (Config.LegendaryPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("legendary_coyote_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- legendary_panther_pelt
                elseif Player.PlayerData.items[k].name == "legendary_panther_pelt" then 
                    price = price + (Config.LegendaryPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("legendary_panther_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- legendary_wolf_pelt
                elseif Player.PlayerData.items[k].name == "legendary_wolf_pelt" then 
                    price = price + (Config.LegendaryPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("legendary_wolf_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                -- raccoon_pelt
                elseif Player.PlayerData.items[k].name == "poor_raccoon_pelt" then 
                    price = price + (Config.PoorPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("poor_raccoon_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "good_raccoon_pelt" then 
                    price = price + (Config.GoodPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("good_raccoon_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                elseif Player.PlayerData.items[k].name == "perfect_raccoon_pelt" then 
                    price = price + (Config.PerfectPeltPrice * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_raccoon_pelt", Player.PlayerData.items[k].amount, k)
                    haspelts = true
                end
            end
        end
        if haspelts == true then
            Player.Functions.AddMoney(Config.PaymentType, price, "pelts-sold")
            RSGCore.Functions.Notify(source, Lang:t('success.you_have_sold_all_your_pelts_for')..price, 'success')
            haspelts = false
        else
            RSGCore.Functions.Notify(source, Lang:t('error.you_dont_have_any_pelts_to_sell'), 'error')
        end
    end
end)

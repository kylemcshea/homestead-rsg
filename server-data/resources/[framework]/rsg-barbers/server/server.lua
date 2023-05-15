local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('rsg-barber:server:SaveSkin')
AddEventHandler('rsg-barber:server:SaveSkin', function(CreatorCache, gender)
    local src = source
    local player = RSGCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid
    local PedIsMale = gender
    local price = Config.BarberCost
    local money = player.Functions.GetMoney('cash')

    if money < price then
        RSGCore.Functions.Notify('You dont have enough money!', 'error')
        return
    end

    local result = MySQL.Sync.fetchAll('SELECT skin FROM playerskins WHERE citizenid = @citizenid',
    {
        citizenid = citizenid
    })

    if result[1] == nil then return end

    local skin = {}
    skin = json.decode(result[1].skin)

    if skin['hair'] == nil then
        skin['hair'] = {}
        skin['hair'].model = 0
        skin['hair'].texture = 1
    end

    if skin['beard'] == nil then
        skin['beard'] = {}
        skin['beard'].model = 0
        skin['beard'].texture = 1
    end

    if CreatorCache['hair'].model ~= nil then
        skin['hair'].model = tostring(CreatorCache['hair'].model)
    end

    if CreatorCache['hair'].texture ~= nil then
        skin['hair'].texture = tostring(CreatorCache['hair'].texture)
    end

    if PedIsMale then
        if CreatorCache['beard'].model ~= nil then
            skin['beard'].model = tostring(CreatorCache['beard'].model)
        end

        if CreatorCache['beard'].texture ~= nil then
            skin['beard'].texture = tostring(CreatorCache['beard'].texture)
        end
    end

    if CreatorCache['beardstabble_t'] ~= nil then
        skin['beardstabble_t'] = tostring(CreatorCache['beardstabble_t'])
    end

    if CreatorCache['beardstabble_op'] ~= nil then
        skin['beardstabble_op'] = tostring(CreatorCache['beardstabble_op'])
    end

    if CreatorCache['shadows_t'] ~= nil then
        skin['shadows_t'] = tostring(CreatorCache['shadows_t'])
    end

    if CreatorCache['shadows_op'] ~= nil then
        skin['shadows_op'] = tostring(CreatorCache['shadows_op'])
    end

    if CreatorCache['shadows_id'] ~= nil then
        skin['shadows_id'] = tostring(CreatorCache['shadows_id'])
    end

    if CreatorCache['shadows_c1'] ~= nil then
        skin['shadows_c1'] = tostring(CreatorCache['shadows_c1'])
    end

    if CreatorCache['blush_t'] ~= nil then
        skin['blush_t'] = tostring(CreatorCache['blush_t'])
    end

    if CreatorCache['blush_op'] ~= nil then
        skin['blush_op'] = tostring(CreatorCache['blush_op'])
    end

    if CreatorCache['blush_id'] ~= nil then
        skin['blush_id'] = tostring(CreatorCache['blush_id'])
    end

    if CreatorCache['blush_c1'] ~= nil then
        skin['blush_c1'] = tostring(CreatorCache['blush_c1'])
    end

    if CreatorCache['lipsticks_t'] ~= nil then
        skin['lipsticks_t'] = tostring(CreatorCache['lipsticks_t'])
    end

    if CreatorCache['lipsticks_op'] ~= nil then
        skin['lipsticks_op'] = tostring(CreatorCache['lipsticks_op'])
    end

    if CreatorCache['lipsticks_id'] ~= nil then
        skin['lipsticks_id'] = tostring(CreatorCache['lipsticks_id'])
    end

    if CreatorCache['lipsticks_c1'] ~= nil then
        skin['lipsticks_c1'] = tostring(CreatorCache['lipsticks_c1'])
    end

    if CreatorCache['lipsticks_c2'] ~= nil then
        skin['lipsticks_c2'] = tostring(CreatorCache['lipsticks_c2'])
    end

    if CreatorCache['eyeliners_t'] ~= nil then
        skin['eyeliners_t'] = tostring(CreatorCache['eyeliners_t'])
    end

    if CreatorCache['eyeliners_op'] ~= nil then
        skin['eyeliners_op'] = tostring(CreatorCache['eyeliners_op'])
    end

    if CreatorCache['eyeliners_id'] ~= nil then
        skin['eyeliners_id'] = tostring(CreatorCache['eyeliners_id'])
    end

    if CreatorCache['eyeliners_c1'] ~= nil then
        skin['eyeliners_c1'] = tostring(CreatorCache['eyeliners_c1'])
    end

    MySQL.query.await("UPDATE playerskins SET skin = @skin WHERE citizenid = @citizenid",
    {
        ['citizenid'] = citizenid,
        ['skin'] = json.encode(skin)
    })

    player.Functions.RemoveMoney('cash', price)

    RSGCore.Functions.Notify('You have purchased a new style!', 'success')
end)
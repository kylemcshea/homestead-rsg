local RSGCore = exports['rsg-core']:GetCoreObject()

--------------------------------------------------------------------------------------------------

-- rent room
RegisterNetEvent('rsg-hotel:server:RentRoom', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local fullname = (firstname..' '..lastname)
    local location = data.location
    local result = MySQL.prepare.await('SELECT COUNT(*) FROM player_rooms WHERE location = ? AND citizenid = ?', { location, citizenid })
    if result == 0 then
        local roomid = RSGCore.Player.CreateRoomId()
        local credit = Config.StartCredit
        local date = os.date()
        local cashBalance = Player.PlayerData.money["cash"]
        if cashBalance >= credit then
            MySQL.insert('INSERT INTO player_rooms (citizenid, fullname, location, credit, roomid) VALUES (?, ?, ?, ?, ?)', {
                citizenid,
                fullname,
                location,
                credit,
                roomid
            })
            Player.Functions.RemoveMoney("cash", credit, "room-rental")
            RSGCore.Functions.Notify(src, Lang:t('success.you_rented_room')..roomid, 'success')
        else
            RSGCore.Functions.Notify(src, Lang:t('error.not_enought_cash_to_rent_room'), 'error')
        end
    else
        RSGCore.Functions.Notify(src, Lang:t('error.you_already_have_room_here'), 'error')
    end
end)

-- room check-in
RegisterNetEvent('rsg-hotel:server:CheckIn', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local location = data.location
    local result = MySQL.prepare.await('SELECT COUNT(*) FROM player_rooms WHERE location = ? AND citizenid = ?', { location, citizenid })
    if result ~= 0 then
        local roomresult = MySQL.query.await('SELECT * FROM player_rooms WHERE location = ? AND citizenid = ?', { location, citizenid })
        local roomid = roomresult[1].roomid
        SetPlayerRoutingBucket(src, tonumber(roomid))
        local currentbucket = GetPlayerRoutingBucket(src)
        if Config.Debug == true then
            print('Current Bucket:'..currentbucket)
        end
        MySQL.update('UPDATE player_rooms SET active = ? WHERE roomid = ? AND citizenid = ?', { 1, roomid, citizenid })
        TriggerClientEvent('rsg-hotel:client:gotoRoom', src, location)
    else
        RSGCore.Functions.Notify(src, Lang:t('error.you_dont_have_room_here'), 'error')
    end
end)

--------------------------------------------------------------------------------------------------

-- get active room data
RSGCore.Functions.CreateCallback('rsg-hotel:server:GetActiveRoom', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM player_rooms WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
    if result[1] ~= nil then
        return cb(result[1])
    end
    return cb(nil)
end)

RegisterNetEvent('rsg-hotel:server:addcredit', function(newcredit, removemoney, roomid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local cashBalance = Player.PlayerData.money["cash"]
    if cashBalance >= removemoney then
        Player.Functions.RemoveMoney("cash", removemoney, "room-credit")
        MySQL.update('UPDATE player_rooms SET credit = ? WHERE roomid = ?', { newcredit, roomid })
        RSGCore.Functions.Notify(src, Lang:t('success.room_credit_added_for')..roomid, 'success')
        Wait(5000)
        RSGCore.Functions.Notify(src,  Lang:t('primary.your_credit_is_now')..newcredit, 'primary')
    else
        RSGCore.Functions.Notify(src,  Lang:t('error.not_enough_cash'), 'error')
    end
end)

--------------------------------------------------------------------------------------------------

-- set player default bucket
RegisterNetEvent('rsg-hotel:server:setdefaultbucket', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    SetPlayerRoutingBucket(src, 0)
    local currentbucket = GetPlayerRoutingBucket(src)
    if Config.Debug == true then
        print('Current Bucket:'..currentbucket)
    end
    MySQL.update('UPDATE player_rooms SET active = ? WHERE citizenid = ?', { 0, Player.PlayerData.citizenid })
end)

--------------------------------------------------------------------------------------------------

-- create unique room id / -- RSGCore.Player.CreateRoomId()
function RSGCore.Player.CreateRoomId()
    local UniqueFound = false
    local RoomId = nil
    while not UniqueFound do
        RoomId = (RSGCore.Shared.RandomInt(2) .. RSGCore.Shared.RandomInt(2))
        local result = MySQL.prepare.await("SELECT COUNT(*) as count FROM player_rooms WHERE roomid = ?", { RoomId })
        if result == 0 then
            UniqueFound = true
        end
    end
    return RoomId
end

--------------------------------------------------------------------------------------------------

-- billing loop
function BillingInterval()
    local result = MySQL.query.await('SELECT * FROM player_rooms')
    if result then
        for i = 1, #result do
            local row = result[i]
            if Config.Debug == true then
                print(row.citizenid, row.fullname, row.location, row.credit, row.roomid)
            end
            if row.credit >= Config.RentPerCycle then
                local creditadjust = (row.credit - Config.RentPerCycle)
                MySQL.update('UPDATE player_rooms SET credit = ? WHERE roomid = ? AND citizenid = ?', { creditadjust, row.roomid, row.citizenid })
                local creditwarning = (Config.RentPerCycle * Config.CreditWarning)
                if row.credit < creditwarning then
                    MySQL.insert('INSERT INTO telegrams (citizenid, recipient, sender, sendername, subject, sentDate, message) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                        row.citizenid,
                        row.fullname,
                        'NO-REPLY',
                        'Hotel Reception',
                        'Credit Due to Run Out!',
                        os.date("%x"),
                        'Your credit for room '..row.roomid..' in '..row.location..' is due to run out!',
                    })
                end
            else
                MySQL.insert('INSERT INTO telegrams (citizenid, recipient, sender, sendername, subject, sentDate, message) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                    row.citizenid,
                    row.fullname,
                    'NO-REPLY',
                    'Hotel Reception',
                    'Credit Ran Out!',
                    os.date("%x"),
                    'Due to lack of credit, you have been checked out of room '..row.roomid..' in '..row.location..'. Thanks for choosing our hotel.',
                })
                Wait(1000)
                MySQL.update('DELETE FROM player_rooms WHERE roomid = ? AND citizenid = ?', { row.roomid, row.citizenid })
                TriggerEvent('rsg-log:server:CreateLog', 'hotel', 'Hotel Room Lost', 'red', row.fullname..' room '..row.roomid..' in '..row.location..' has been deleted')
            end
        end
    end
    SetTimeout(Config.BillingCycle * (60 * 60 * 1000), BillingInterval) -- hours
end

SetTimeout(Config.BillingCycle * (60 * 60 * 1000), BillingInterval) -- hours

--------------------------------------------------------------------------------------------------
--SetTimeout(Config.BillingCycle * (60 * 1000), BillingInterval) -- mins

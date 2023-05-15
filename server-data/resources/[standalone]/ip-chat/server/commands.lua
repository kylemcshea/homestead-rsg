local RSGcore = exports['rsg-core']:GetCoreObject()

local canAdvertise = true

local reportCooldown = {}


if Config.AllowPlayersToClearTheirChat then
    RegisterCommand(Config.ClearChatCommand, function(source, args, rawCommand)
        TriggerClientEvent('chat:client:ClearChat', source)
    end)
end

if Config.AllowStaffsToClearEveryonesChat then
    RegisterCommand(Config.ClearEveryonesChatCommand, function(source, args, rawCommand)
        local Player = RSGcore.Functions.GetPlayer(source)
        local time = os.date(Config.DateFormat)
        local src = source

        if RSGcore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
            TriggerClientEvent('chat:client:ClearChat', -1)
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">The chat has been cleared!</div></div>',
                args = { time }
            })
        end
    end)
end

if Config.EnableStaffCommand then
    RegisterCommand(Config.StaffCommand, function(source, args, rawCommand)
        local Player = RSGcore.Functions.GetPlayer(source)
        local length = string.len(Config.StaffCommand)
        local message = rawCommand:sub(length + 1)
        local time = os.date(Config.DateFormat)
        playerName = Player.PlayerData.name
        local src = source

        if RSGcore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div class="chat-message staff"><i class="fas fa-shield-alt"></i> <b><span style="color: #1ebc62">[ANNOUNCEMENT]</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;">{0}</div></div>',
                args = { message, time }
            })
        end
    end)
end

if Config.EnableStaffOnlyCommand then
    RegisterCommand(Config.StaffOnlyCommand, function(source, args, rawCommand)
        local Player = RSGcore.Functions.GetPlayer(source)
        local length = string.len(Config.StaffOnlyCommand)
        local message = rawCommand:sub(length + 2)
        local time = os.date(Config.DateFormat)
        local playerName = Player.PlayerData.name
        local src = source

        if RSGcore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
            local players = getPlayersWithStaffRoles()
            for k, v in ipairs(players) do
                TriggerClientEvent('chat:addMessage', v, {
                    template = '<div class="chat-message staffonly"><i class="fas fa-eye-slash"></i> <b><span style="color: #1ebc62">[ADMIN] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
                    args = { playerName, message, time }
                })
            end
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message staffonly"><i class="fas fa-eye-slash"></i> <b><span style="color: #1ebc62">[ADMIN] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
                args = { playerName, message, time }
            })
        end
    end)
end

if Config.EnableAdvertisementCommand then
    RegisterCommand(Config.AdvertisementCommand, function(source, args, rawCommand)
        local Player = RSGcore.Functions.GetPlayer(source)
        local length = string.len(Config.AdvertisementCommand)
        local message = rawCommand:sub(length + 1)
        local time = os.date(Config.DateFormat)
        local PlayerData = Player.PlayerData
        local firstname = PlayerData.charinfo.firstname
        local lastname = PlayerData.charinfo.lastname
        local playerName = firstname .. ' ' .. lastname
        local bankMoney = PlayerData.money.bank

        if canAdvertise then
            if bankMoney >= Config.AdvertisementPrice then
                Player.Functions.RemoveMoney('bank', Config.AdvertisementPrice)
                TriggerClientEvent('chat:addMessage', -1, {
                    template = '<div class="chat-message advertisement"><i class="fas fa-ad"></i> <b><span style="color: #81db44">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
                    args = { playerName, message, time }
                })

                RSGcore.Functions.Notify("Advertisement successfully made for "..Config.AdvertisementPrice..'$', success, 5000)

                local time = Config.AdvertisementCooldown * 60
                local pastTime = 0
                canAdvertise = false

                while (time > pastTime) do
                    Citizen.Wait(1000)
                    pastTime = pastTime + 1
                    timeLeft = time - pastTime
                end
                canAdvertise = true
            else
                RSGcore.Functions.Notify("You don't have enough money to make an advertisement", 'error')
            end
        else
            RSGcore.Functions.Notify("You can only advertise once every "..Config.AdvertisementCooldown.." minutes.", 'error', 5000)
        end
    end)
end


if Config.EnableValentineCommand then
    RegisterCommand(Config.ValentineCommand, function(source, args, rawCommand)
        local xPlayer = RSGcore.Functions.GetPlayer(source)
        local length = string.len(Config.ValentineCommand)
        local message = rawCommand:sub(length + 1)
        local time = os.date(Config.DateFormat)
        playerName = xPlayer.PlayerData.name
        local job = xPlayer.PlayerData.job.name

        if job == Config.ValentineJobName then
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div class="chat-message valentine"><i class="fas fa-cog"></i> <b><span style="color: #595858">[VALENTINE] {0}</span>&nbsp;<span style="font-size: 14px; color: #fcf7f5;">{1}</div></b><div style="margin-top: 5px; font-weight: 300;"</div>',
                args = { message, time }
            })
        end
    end)
end

if Config.EnableRhodesCommand then
    RegisterCommand(Config.RhodesCommand, function(source, args, rawCommand)
        local xPlayer = RSGcore.Functions.GetPlayer(source)
        local length = string.len(Config.RhodesCommand)
        local message = rawCommand:sub(length + 1)
        local time = os.date(Config.DateFormat)
        local job = xPlayer.PlayerData.job.name

        if job == Config.RhodesJobName then
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div class="chat-message rhodes"><i class="fas fa-cog"></i> <b><span style="color: #32406e">[RHODES] {0}</span>&nbsp;<span style="font-size: 14px; color: #62a2f5;">{1}</div></b><div style="margin-top: 5px; font-weight: 300;"</div>',
                args = { message, time }
            })
        end
    end)
end

RegisterCommand('report', function(source, args, rawCommand)
    local Player = RSGcore.Functions.GetPlayer(source)
    local playerName = Player.PlayerData.name
    local message = table.concat(args, ' ')
    local time = os.date(Config.DateFormat)
    local src = source

    local players = getPlayersWithStaffRoles()
    for k, v in ipairs(players) do
        TriggerClientEvent('chat:addMessage', v, {
            template = '<div class="chat-message report"><i class="fas fa-flag"></i> <b><span style="color: #ff3838">[REPORT] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
            args = { playerName, message, time }
        })
    end
    TriggerClientEvent('chat:addMessage', src, {
        template = '<div class="chat-message report"><i class="fas fa-flag"></i> <b><span style="color: #ff3838">[REPORT] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
        args = { 'Your report has been submitted successfully!', message, time }
    })
end)

RegisterCommand('reply', function(source, args, rawCommand)
    local player = RSGcore.Functions.GetPlayer(source)
    local playerName = player.PlayerData.name
    local message = table.concat(args, ' ')
    local time = os.date(Config.DateFormat)
    local src = source

    if RSGcore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        -- Check if the user provided an ID and a message
        if #args < 2 then
            player.Functions.Notify('Usage: /reply [report ID] [message]', 'error')
            return
        end
        
        -- Get the report ID and message
        local reportId = tonumber(args[1])
        local replyMessage = table.concat(args, ' ', 2)
        
        -- Get the report from the ID
        local report = reportCooldown[reportId]
        if not report then
            player.Functions.Notify('Invalid report ID.', 'error')
            return
        end
        
        -- Get the player who made the report
        local reportedPlayer = RSGcore.Functions.GetPlayer(report.reporter)
        if not reportedPlayer then
            player.Functions.Notify('Reported player is not online.', 'error')
            return
        end
        
        -- Send the reply message to the player who made the report
        TriggerClientEvent('chat:addMessage', reportedPlayer.PlayerData.source, {
            template = '<div class="chat-message report-reply"><i class="fas fa-comment"></i> <b><span style="color: #feca57">[REPORT REPLY] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;">{2}</div></div>',
            args = { playerName, replyMessage, time }
        })
        
        -- Notify the admin that the message was sent
        player.Functions.Notify(string.format('Your message was sent to %s.', reportedPlayer.PlayerData.name))
        
        -- Add the reply message to the report log
        table.insert(report.log, {
            author = playerName,
            message = replyMessage,
            time = os.date(Config.DateFormat)
        })
    end
end)

RegisterCommand('gossip', function(source, args, rawCommand)
    local message = table.concat(args, ' ')
    local time = os.date(Config.DateFormat)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message gossip"><i class="fas fa-comment"></i> <b><span style="color: #ffc107">[GOSSIP]</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;">{0}</div></div>',
        args = { message, time }
    })
end)

RegisterCommand('ooc', function(source, args, rawCommand)
    
    local Player = RSGcore.Functions.GetPlayer(source)
    local message = table.concat(args, ' ')
    local time = os.date(Config.DateFormat)
    local PlayerData = Player.PlayerData
    local firstname = PlayerData.charinfo.firstname
    local lastname = PlayerData.charinfo.lastname
    local playerName = firstname .. ' ' .. lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message ooc"><i class="fas fa-comment"></i> <b><span style="color: #ffc107">[OOC] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;">{2}</div></div>',
        args = {playerName, time, message}
    })
    TriggerEvent('rsg-log:server:CreateLog', 'ooc', 'OOC', 'white', '**' .. GetPlayerName(source) .. '** (CitizenID: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. source .. ') **Message:** ' .. message, false)
end)

if Config.EnableWhisperCommand then
    RegisterCommand(Config.WhisperCommand, function(source, args, rawCommand)
        local xPlayer = RSGcore.Functions.GetPlayer(source)
        local length = string.len(Config.WhisperCommand)
        local message = rawCommand:sub(length + 1)
        local time = os.date(Config.DateFormat)
        playerName = xPlayer.PlayerData.name
        TriggerClientEvent('chat:whisper', -1, source, playerName, message, time)
    end)
end


function getPlayersWithStaffRoles()
    local players = {}
    for k, v in ipairs(RSGcore.Functions.GetPlayers()) do
        for k, x in ipairs(Config.StaffGroups) do
            if RSGcore.Functions.GetPermission(v) == x then
                table.insert(players, v)
                break
            end
        end
    end

    return players
end

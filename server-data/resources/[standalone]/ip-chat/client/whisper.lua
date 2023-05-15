local RSGcore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('chat:whisper')
AddEventHandler('chat:whisper', function(id, name, message, time)
    local id1 = PlayerId()
    local id2 = GetPlayerFromServerId(id)
    local sourcePlayer = GetPlayerFromServerId(id1) 

    -- Asynchronously retrieve the player data
    RSGcore.Functions.GetPlayerData(function(PlayerData)
        local firstname = PlayerData.charinfo.firstname
        local lastname = PlayerData.charinfo.lastname
        local playerName = firstname .. ' ' .. lastname

        -- Check the distance and broadcast the message if it's within the bisikDistance limit
        if id2 == id1 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id1)), GetEntityCoords(GetPlayerPed(id2)), true) < Config.bisikDistance then
            TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message ooc"><i class="fas fa-comment"></i> <b><span style="color: #0b0d0b">[WHISPER] {0}</span>&nbsp;<span style="font-size: 14px; color: #0b0d0b;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
                args = {playerName, message, time}
            })
        end
    end)
end)

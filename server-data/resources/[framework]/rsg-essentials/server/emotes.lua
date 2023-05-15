local RSGCore = exports['rsg-core']:GetCoreObject()

RSGCore.Commands.Add('emotemenu', Lang:t('commands.emoteMenu'), {}, false, function(source)
    local src = source
    TriggerClientEvent('emotes:client:EmoteMenu', src)
end)

RSGCore.Commands.Add('em', Lang:t('commands.emoteMenu'), {}, false, function(source)
    local src = source
    TriggerClientEvent('emotes:client:EmoteMenu', src)
end)

CreateThread(function()
    for k, v in pairs(Config.Emotes.Actions) do
        RSGCore.Commands.Add(k, v.desc, {}, false, function(source)
            local src = source
            TriggerClientEvent('emotes:client:doemote', src, v.anim)
        end)        
    end
    for k, v in pairs(Config.Emotes.Greeting) do
        RSGCore.Commands.Add(k, v.desc, {}, false, function(source)
            local src = source
            TriggerClientEvent('emotes:client:doemote', src, v.anim)
        end)        
    end
    for k, v in pairs(Config.Emotes.Reactions) do
        RSGCore.Commands.Add(k, v.desc, {}, false, function(source)
            local src = source
            TriggerClientEvent('emotes:client:doemote', src, v.anim)
        end)        
    end
    for k, v in pairs(Config.Emotes.Taunting) do
        RSGCore.Commands.Add(k, v.desc, {}, false, function(source)
            local src = source
            TriggerClientEvent('emotes:client:doemote', src, v.anim)
        end)        
    end
    for k, v in pairs(Config.Emotes.Dancing) do
        RSGCore.Commands.Add(k, v.desc, {}, false, function(source)
            local src = source
            TriggerClientEvent('emotes:client:dodictemote', src, v.dict, v.anim, v.duration)
        end)        
    end
end)
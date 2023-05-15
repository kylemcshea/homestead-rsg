local RSGCore = exports['rsg-core']:GetCoreObject()
local pianoPlayed = false

RegisterNetEvent('rsg-piano:PianoPlay', function(position, heading, animation)
    local pos = position
    local head = heading
    local anim = nil 
    if IsPedMale(PlayerPedId()) then 
        anim =  animation.Man
    else anim = animation.Woman end

    if not pianoPlayed then 
        pianoPlayed = true
        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey(anim), pos.x - 0.08, pos.y, pos.z + 0.03, head, 0, true, true, 0, true) 
    end      
end)

CreateThread(function()
    for k, v in pairs(Config.PianoLocation) do
        exports['rsg-core']:createPrompt("rsg-piano:Piano"..k, v.SitPosition, RSGCore.Shared.Keybinds['J'], 'Play Piano', {
            type = 'client',
            event = 'rsg-piano:PianoPlay',
            args = {v.SitPosition,v.SitHeading,v.Animation}
        })
        exports['rsg-core']:createPrompt("rsg-piano:PianoRemove"..k, v.SitPosition, RSGCore.Shared.Keybinds['ENTER'], 'Get Up', {
            type = 'client',
            event = 'rsg-piano:PianoPause',
        })
    end
end)

RegisterNetEvent('rsg-piano:PianoPause', function()
    pianoPlayed = false
    ClearPedTasks(PlayerPedId())
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k,v in pairs(Config.PianoLocation) do 
            exports['rsg-core']:deletePrompt('rsg-piano:Piano'..k)
            exports['rsg-core']:deletePrompt('rsg-piano:PianoRemove'..k)
        end
    end
end)

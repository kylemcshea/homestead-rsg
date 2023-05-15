-- Toggle all UI ON/OFF
RegisterCommand('hideui', function()
    TriggerEvent('HideAllUI')
end)

CreateThread(function ()
    Wait(1000)
    TriggerEvent('chat:addSuggestion','/hideui', 'Toggle all UIs ON/OFF (i.e. for taking Screenshot)', {})
end)
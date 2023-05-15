local RSGCore = exports['rsg-core']:GetCoreObject()

local Webhooks = {
    ['default'] = GetConvar('webhook:default', ''),
    ['testwebhook'] = GetConvar('webhook:testwebhook', ''),
    ['anticheat'] = GetConvar('webhook:anticheat', ''),
    ['levels'] = GetConvar('webhook:levels', ''),
    ['playermoney'] = GetConvar('webhook:playermoney', ''),
    ['joinleave'] = GetConvar('webhook:joinleave', ''),
    ['banking'] = GetConvar('webhook:banking', ''),
    ['ooc'] = GetConvar('webhook:ooc', ''),
    ['playerinventory'] = GetConvar('webhook:playerinventory', ''),
    ['robbing'] = GetConvar('webhook:robbing', ''),
    ['stash'] = GetConvar('webhook:stash', ''),
    ['drop'] = GetConvar('webhook:drop', ''),
    ['dealers'] = GetConvar('webhook:dealers', ''),
    ['shops'] = GetConvar('webhook:shops', ''),
    ['bans'] = GetConvar('webhook:bans', ''),
    ['bossmenu'] = GetConvar('webhook:bossmenu', ''),
    ['gangmenu'] = GetConvar('webhook:gangmenu', ''),
    ['fishing'] = GetConvar('webhook:fishing', ''),
    ['goldpanning'] = GetConvar('webhook:goldpanning', ''),
    ['loot'] = GetConvar('webhook:loot', ''),
    ['hotel'] = GetConvar('webhook:hotel', ''),
    ['beekeeper'] = GetConvar('webhook:beekeeper', '')
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('rsg-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = Config.DiscordWHAuthorName,
                ['icon_url'] = Config.DiscordWHImage,
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.DiscordWHLogUserName, embeds = embedData }), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.DiscordWHLogUserName, content = '@everyone' }), { ['Content-Type'] = 'application/json' })
    end
    exports.homestead_splunk:send_to_splunk({ pretty = (message:gsub("*","")) }, title)
end)

RSGCore.Commands.Add('testwebhook', Lang:t('log.test_your_discord_webhook'), {}, false, function()
    TriggerEvent('rsg-log:server:CreateLog', 'testwebhook', Lang:t('log.test_webhook'), 'default', Lang:t('log.webhook_setup_successfully'))
end, 'god')

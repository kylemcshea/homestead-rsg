local RSGCore = exports['rsg-core']:GetCoreObject()

CreateThread(function()	-- Check if player has weapon in inventory --
    while true do
        Wait(5000)
        local player = PlayerPedId()
        local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, player)
        local WeaponData = RSGCore.Shared.Weapons[weapon]
        if WeaponData ~= nil and WeaponData["name"] ~= "weapon_unarmed" then
            local weaponGroup = Citizen.InvokeNative(0xEDCA14CA5199FF25, weapon)
            if weaponGroup ~= `group_thrown` then
                RSGCore.Functions.GetPlayerData(function(PlayerData)
                    firstname = PlayerData.charinfo.firstname
                    lastname = PlayerData.charinfo.lastname
                    fullname = firstname..' '..lastname
                end)
                local hasItem = RSGCore.Functions.HasItem(WeaponData["name"])
                --print(hasItem)
                if not hasItem then
                    SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
                    RemoveAllPedWeapons(player, true, true)
                    TriggerServerEvent("rsg-log:server:CreateLog", "anticheat",  Lang:t('log.weapon_removed'), "orange", '** @staff ** '..fullname..' had a weapon on them that they did not have in his inventory : anticheat has removed the weapon')
                end
            end
        end
    end
end)

local RSGCore = exports['rsg-core']:GetCoreObject()

CreateThread(function()
    while true do
        Wait(7)

        if IsControlJustPressed(0, RSGCore.Shared.Keybinds['B']) then
            RSGCore.Functions.GetPlayerData(function(PlayerData)
                local ped = PlayerPedId()

                if not PlayerData.metadata["isdead"]
                and not IsEntityDead(ped) -- unconditional death
                and not PlayerData.metadata["ishandcuffed"]
                and not Citizen.InvokeNative(0x9682F850056C9ADE, ped) then
                    local animDict = "ai_react@point@base"

                    if not IsEntityPlayingAnim(ped, animDict, "point_fwd", 3) then
                        if not HasAnimDictLoaded(animDict) then
                            RequestAnimDict(animDict)
                            while not HasAnimDictLoaded(animDict) do
                                Wait(0)
                            end
                        end

                        TaskPlayAnim(ped, animDict, "point_fwd", 2.0, -2.0, -1, 31, 0.0, true, 0, false, 0, false)
                        RequestAnimDict(animDict)
                    else
                        ClearPedSecondaryTask(ped)
                    end
                end
            end)
        end
    end
end)
local bandana = false

RegisterNetEvent('rsg-bandana:client:ToggleBandana')
AddEventHandler('rsg-bandana:client:ToggleBandana', function()
    local ped = PlayerPedId()
    local male = IsPedMale(ped)
    local neckwear = exports['rsg-clothes']:GetClothesCurrentComponentHash('neckwear')

    -- Beard of Power: https://www.nexusmods.com/skyrimspecialedition/mods/42635
    -- local beardofpower = exports['rsg-appearance']:GetBodyCurrentComponentHash('beard')

    if not bandana then
        if not male then
            Citizen.InvokeNative(0xAE72E7DF013AAA61, ped, `KIT_BANDANA`, `BANDANA_ON_RIGHT_HAND`, 1, 0, -1082130432)
            Wait(700)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0xC615A086, true, true, true)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)

            bandana = true

            return
        end

        Citizen.InvokeNative(0xAE72E7DF013AAA61, ped, `KIT_BANDANA`, `BANDANA_ON_RIGHT_HAND`, 1, 0, -1082130432)
        Wait(700)
        Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, -1100875244)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)

        bandana = true

        return
    end

    if not male then
        Citizen.InvokeNative(0xAE72E7DF013AAA61, ped, `KIT_BANDANA`, `BANDANA_OFF_RIGHT_HAND`, 1, 0, -1082130432)
        Wait(700)
        Citizen.InvokeNative(0xD710A5007C2AC539, ped, 0x5FC29285, 0)
        Wait(100)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, neckwear, true, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)

        bandana = false

        return
    end

    Citizen.InvokeNative(0xAE72E7DF013AAA61, ped, `KIT_BANDANA`, `BANDANA_OFF_RIGHT_HAND`, 1, 0, -1082130432)
    Wait(700)
    Citizen.InvokeNative(0xD710A5007C2AC539, ped, 0x5FC29285, 0)
    Wait(100)
    Citizen.InvokeNative(0xD710A5007C2AC539, ped, 0xF8016BCA, 0)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, beardofpower, true, true, true)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)

    bandana = false
end)

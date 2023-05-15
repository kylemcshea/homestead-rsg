local ClothingCamera = nil
local c_zoom = 2.8
local c_offset = -0.15
local Outfits_tab = {}
local CurrentPrice = 0

MenuData = {}
TriggerEvent("rsg-menubase:getData", function(call)
    MenuData = call
end)

function OpenClothingMenu()
    MenuData.CloseAll()
    local elements = {}
    for v, k in pairsByKeys(Config.MenuElements) do
        table.insert(elements, {label = k.label or v, value = v, category = v, desc = ""})
    end
    table.insert(elements, {label = Config.Label["save"] or "Save", value = "save", desc = ""})
    MenuData.Open('default', GetCurrentResourceName(), 'clothing_store_menu',
            {title = 'Clothes', subtext = 'Options', align = 'top-left', elements = elements}, function(data, menu)
        if data.current.value ~= "save" then
            OpenCateogry(data.current.value)
        else
            destory()
            menu.close()
            local output = nil
            AddTextEntry('FMMC_MPM_NA', "The name of the outfit:")
            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "name", "", "", "", 30)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0)
                Citizen.Wait(0)
            end
            if (GetOnscreenKeyboardResult()) then
                output = GetOnscreenKeyboardResult()
            end
            saveOutfit = true
            TriggerServerEvent("rsg-clothes:Save", ClothesCache, output, CurrentPrice)
            OldClothesCache = {}
        end
    end, function(data, menu)
        menu.close()
        OldClothesCache = {}
        destory()
        TriggerServerEvent("rsg-appearance:LoadSkin")
    end)
end

function OpenCateogry(menu_catagory)
    MenuData.CloseAll()
    local elements = {}
    if IsPedMale(PlayerPedId()) then
        local a = 1
        for v, k in pairsByKeys(Config.MenuElements[menu_catagory].category) do
            if clothes_list["male"][k] ~= nil then
                local category = clothes_list["male"][k]
                if ClothesCache[k] == nil then
                    ClothesCache[k] = {}
                    ClothesCache[k].model = 0
                    ClothesCache[k].texture = 1
                end
                local options = {}
                for k, v in pairs(category) do
                    table.insert(options, k)
                end
                table.insert(elements,
                    {label = Config.Price[k] .. "$ " .. Config.Label[k] or v, value = ClothesCache[k].model or 0, category = k, desc = "", type = "slider", min = 0, max = #category, change_type = "model", id = a, options = options}
                )
                a = a + 1
                options = {}
                for i = 1, GetMaxTexturesForModel(k, ClothesCache[k].model or 1), 1 do
                    table.insert(options, i)
                end
                table.insert(elements,
                    {label = "Color " .. Config.Label[k] or v, value = ClothesCache[k].texture or 1, category = k, desc = "", type = "slider", min = 1, max = GetMaxTexturesForModel(k, ClothesCache[k].model or 1), change_type = "texture", id = a, options = options}
                )
                options = {}
                a = a + 1
            end
        end
    else
        local a = 1
        for v, k in pairsByKeys(Config.MenuElements[menu_catagory].category) do
            if clothes_list["female"][k] ~= nil then
                local category = clothes_list["female"][k]
                if ClothesCache[k] == nil then
                    ClothesCache[k] = {}
                    ClothesCache[k].model = 0
                    ClothesCache[k].texture = 0
                end
                local options = {}
                for k, v in pairs(category) do
                    table.insert(options, k)
                end
                table.insert(elements,
                    {label = Config.Price[k] .. "$ " .. Config.Label[k] or v, value = ClothesCache[k].model or 0, category = k, desc = "", type = "slider", min = 0, max = #category, change_type = "model", id = a,options = options}
                )
                a = a + 1
                options = {}
                for i = 1, GetMaxTexturesForModel(k, ClothesCache[k].model or 1), 1 do
                    table.insert(options, i)
                end
                table.insert(elements,
                    {label = "Color " .. Config.Label[k] or v, value = ClothesCache[k].texture or 1, category = k, desc = "", type = "slider", min = 1, max = GetMaxTexturesForModel(k, ClothesCache[k].model or 1), change_type = "texture", id = a, options = options}
                )
                options = {}
                a = a + 1
            end
        end
    end
    MenuData.Open('default', GetCurrentResourceName(), 'clothing_store_menu_category',
        {title = 'Clothes', subtext = 'Options', align = 'top-left', elements = elements}, function(data, menu)
    end, function(data, menu)
        menu.close()
        OpenClothingMenu()
    end, function(data, menu)
        MenuUpdateClothes(data, menu)
    end)
end

function MenuUpdateClothes(data, menu)
    if data.current.change_type == "model" then
        if ClothesCache[data.current.category].model ~= data.current.value then
            ClothesCache[data.current.category].texture = 1
            ClothesCache[data.current.category].model = data.current.value
            if data.current.value > 0 then
                local options = {}
                if GetMaxTexturesForModel(data.current.category, data.current.value) > 1 then
                    for i = 1, GetMaxTexturesForModel(data.current.category, data.current.value), 1 do
                        table.insert(options, i)
                    end
                else
                    table.insert(options, "Lack")
                end
                menu.setElement(data.current.id + 1, "options", options)
                menu.setElement(data.current.id + 1, "max",
                    GetMaxTexturesForModel(data.current.category, data.current.value))
                menu.setElement(data.current.id + 1, "min", 1)
                menu.setElement(data.current.id + 1, "value", 1)
                menu.refresh()
            else
                menu.setElement(data.current.id + 1, "max", 0)
                menu.setElement(data.current.id + 1, "min", 0)
                menu.setElement(data.current.id + 1, "value", 0)
                menu.refresh()
            end
            if CurrentPrice ~= CalculatePrice() then
                CurrentPrice = CalculatePrice()
                local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING",
                    tostring(CurrentPrice .. "$"), Citizen.ResultAsLong())
                Citizen.InvokeNative(0xFA233F8FE190514C, str)
                Citizen.InvokeNative(0xE9990552DEC71600)
            end
            Change(data.current.value, data.current.category, data.current.change_type)
        end
    end
    if data.current.change_type == "texture" then
        if ClothesCache[data.current.category].texture ~= data.current.value then
            ClothesCache[data.current.category].texture = data.current.value
            Change(data.current.value, data.current.category, data.current.change_type)
        end
    end

end
function GetMaxTexturesForModel(category, model)
    if model == 0 then
        model = 1
    end
    if IsPedMale(PlayerPedId()) then
        return #clothes_list["male"][category][model]
    else
        return #clothes_list["female"][category][model]
    end
end

function ClothingLight()
    Citizen.CreateThread(function()
        while ClothingCamera do
            Wait(0)
            if IsDisabledControlPressed(0, 0x06052D11) then
                local heading = GetEntityHeading(PlayerPedId())
                SetEntityHeading(PlayerPedId(), heading + 2)
            end
            if IsDisabledControlPressed(0, 0x110AD1D2) then
                local heading = GetEntityHeading(PlayerPedId())
                SetEntityHeading(PlayerPedId(), heading - 2)
            end
            if IsDisabledControlPressed(0, 0xFD0F0C2C) then
                if c_zoom + 0.25 < 2.8 and c_zoom + 0.25 > 0.7 then
                    c_zoom = c_zoom + 0.25
                    camera(c_zoom, c_offset)
                end
            end
            if IsDisabledControlPressed(0, 0xCC1075A7) then
                if c_zoom - 0.25 < 2.8 and c_zoom - 0.25 > 0.7 then
                    c_zoom = c_zoom - 0.25
                    camera(c_zoom, c_offset)
                end
            end
            if IsDisabledControlPressed(0, 0x53296B75) then
                local cursor_y = -0.5 + GetDisabledControlNormal(0, `INPUT_CURSOR_Y`)
                if c_offset - cursor_y / 7 < 1.2 and c_offset - cursor_y / 7 > -1.0 then
                    c_offset = c_offset - cursor_y / 7
                    camera(c_zoom, c_offset)
                end
            end
        end
    end)
    Citizen.CreateThread(function()
        while ClothingCamera do
            Wait(0)
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
            local coords = GetEntityCoords(PlayerPedId())
            DrawLightWithRange(coords.x + 1, coords.y + 1, coords.z + 1, 255, 255, 255, 5.5, 5.0)
        end
    end)
end

RegisterNetEvent('rsg-clothes:OpenClothingMenu')
AddEventHandler('rsg-clothes:OpenClothingMenu', function(ClothesComponents)
    ClothesCache = ClothesComponents
    if IsPedMale(PlayerPedId()) then
        for k,v in pairs(clothes_list["male"]) do
            if ClothesCache[k] == nil then
                ClothesCache[k] = {}
                ClothesCache[k].model = 0
                ClothesCache[k].texture = 0
            end
        end
    else
        for k,v in pairs(clothes_list["female"]) do
            if ClothesCache[k] == nil then
                ClothesCache[k] = {}
                ClothesCache[k].model = 0
                ClothesCache[k].texture = 0
            end
        end
    end
    OldClothesCache = deepcopy(ClothesCache)
    camera(2.8, -0.15)
    ClothingLight()
    OpenClothingMenu()
end)

function Change(id, category, change_type)
    if id < 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), GetHashKey(category), 0)
        NativeUpdatePedVariation(PlayerPedId())
        if category == "pants" or category == "boots" then
            NativeSetPedComponentEnabled(PlayerPedId(), exports['rsg-appearance']:GetBodyCurrentComponentHash("BODIES_LOWER"), false, true, true)
        end
        if category == "shirts_full" then
            NativeSetPedComponentEnabled(PlayerPedId(), exports['rsg-appearance']:GetBodyCurrentComponentHash("BODIES_UPPER"), false, true, true)
        end
    else
        if IsPedMale(PlayerPedId()) then
            if change_type == "model" then
                NativeSetPedComponentEnabled(PlayerPedId(), clothes_list["male"][category][id][1].hash, false, true, true)
            else
                local hash = clothes_list["male"][category][ClothesCache[category].model]

                if not hash then return end

                NativeSetPedComponentEnabled(PlayerPedId(), clothes_list["male"][category][ClothesCache[category].model][id].hash, false, true, true)
            end
        else
            if change_type == "model" then
                NativeSetPedComponentEnabled(PlayerPedId(), clothes_list["female"][category][id][1].hash, false, true, true)
            else
                local hash = clothes_list["female"][category][ClothesCache[category].model]

                if not hash then return end

                NativeSetPedComponentEnabled(PlayerPedId(), clothes_list["female"][category][ClothesCache[category].model][id].hash, false, true, true)
            end
        end
    end
end

RegisterNetEvent('rsg-clothes:ApplyClothes')
AddEventHandler('rsg-clothes:ApplyClothes', function(ClothesComponents, Target)
    Citizen.CreateThread(function()
        local _Target = Target or PlayerPedId()
        local LoadingCheck = false
        if type(ClothesComponents) ~= "table" then
            return
        end
        if next(ClothesComponents) == nil then
            return
        end
        SetEntityAlpha(_Target, 0)
        ClothesCache = ClothesComponents
        for k, v in pairs(ClothesComponents) do
            if v ~= nil then
                local id = tonumber(v.model)
                if id >= 1 then
                    if IsPedMale(_Target) then
                        if clothes_list["male"][k] ~= nil then
                            if clothes_list["male"][k][tonumber(v.model)] ~= nil then
                                if clothes_list["male"][k][tonumber(v.model)][tonumber(v.texture)] ~= nil then
                                    NativeSetPedComponentEnabled(_Target, tonumber(clothes_list["male"][k][tonumber(v.model)][tonumber(v.texture)].hash), false, true, true)
                                end
                            end
                        end
                    else
                        if clothes_list["female"][k] ~= nil then
                            if clothes_list["female"][k][tonumber(v.model)] ~= nil then
                                if clothes_list["female"][k][tonumber(v.model)][tonumber(v.texture)] ~= nil then
                                    NativeSetPedComponentEnabled(_Target, tonumber(clothes_list["female"][k][tonumber(v.model)][tonumber(v.texture)].hash), false, true, true)
                                end
                            end
                        end
                    end
                end
            end
        end
        SetEntityAlpha(_Target, 255)
    end)
end)

function destory()
    SetCamActive(ClothingCamera, false)
    RenderScriptCams(false, true, 500, true, true)
    DisplayHud(true)
    DisplayRadar(true)
    DestroyAllCams(true)
    ClothingCamera = nil
end

function camera(zoom, offset)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = 45.0
    local zoomOffset = zoom
    local camOffset = offset
    local angle = heading * math.pi / 180.0
    local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
    }
    local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y)
    }
    if not ClothingCamera then
        DestroyAllCams(true)
        ClothingCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, coords.z + camOffset, 300.00, 0.00, 0.00, 40.00, false, 0)
        local pCoords = GetEntityCoords(PlayerPedId())
        PointCamAtCoord(ClothingCamera, pCoords.x, pCoords.y, pCoords.z + camOffset)
        SetCamActive(ClothingCamera, true)
        RenderScriptCams(true, true, 1000, true, true)
        DisplayRadar(false)
        SetEntityHeading(playerPed, 334.0)
    else
        local ClothingCamera2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, coords.z + camOffset, 300.00, 0.00, 0.00, 40.00, false, 0)
        SetCamActive(ClothingCamera2, true)
        SetCamActiveWithInterp(ClothingCamera2, ClothingCamera, 750)
        local pCoords = GetEntityCoords(PlayerPedId())
        PointCamAtCoord(ClothingCamera2, pCoords.x, pCoords.y, pCoords.z + camOffset)
        Wait(150)
        SetCamActive(ClothingCamera, false)
        DestroyCam(ClothingCamera)
        ClothingCamera = ClothingCamera2
    end

end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Zones) do
        local blip = N_0x554d9d53f696d002(1664425300, v)
        SetBlipSprite(blip, Config.BlipSprite, 1)
        SetBlipScale(blip, Config.BlipScale)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
    end
    for k, v in pairs(Config.Cloakroom) do
        local blip = N_0x554d9d53f696d002(1664425300, v)
        SetBlipSprite(blip, Config.BlipSpriteCloakRoom, 1)
        SetBlipScale(blip, Config.BlipScale)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipNameCloakRoom)
    end
end)

RegisterNetEvent('rsg-clothes:OpenOutfits')
AddEventHandler('rsg-clothes:OpenOutfits', function()
    TriggerServerEvent('rsg-clothes:getOutfits')
end)

RegisterNetEvent('rsg-clothes:putInTable')
AddEventHandler('rsg-clothes:putInTable', function(outfit)
    Outfits_tab = {}
    for i, k in pairs(outfit) do
        table.insert(Outfits_tab, {
            name = outfit[i].name
        })
    end
    Outfits()
end)

function Outfits()
    local elements_outfits = {}
    if Outfits_tab ~= nil then
        for j, z in pairs(Outfits_tab) do
            table.insert(elements_outfits, {label = Outfits_tab[j].name, value = Outfits_tab[j].name, desc = "choose your clothes"})
        end
    end
    MenuData.CloseAll()
    MenuData.Open('default', GetCurrentResourceName(), 'outfits_menu',
        {title = 'Clothes', subtext = 'choose your clothes', align = 'top-left', elements = elements_outfits}, function(data, menu)
        OutfitsManage(data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end

local elements_outfits_manage = {
    {label = "wear", value = "SetOutfits", desc = "dress up"},
    {label = "delete outfit", value = "DeleteOutfit", desc = ""}
}

function OutfitsManage(outfit)
    MenuData.CloseAll()
    MenuData.Open('default', GetCurrentResourceName(), 'outfits_menu_manage',
        {title = 'Clothes', subtext = 'Options', align = 'top-left', elements = elements_outfits_manage}, function(data, menu)
        menu.close()
        TriggerServerEvent('rsg-clothes:' .. data.current.value, outfit)
    end, function(data, menu)
        Outfits()
    end)
end

local active = false
local target
Citizen.CreateThread(function()
    while true do
        Wait(1)
        local canwait = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        if isCreatorOpened then
            DrawLightWithRange(coords.x + 1, coords.y + 1, coords.z + 1, 255, 255, 255, 2.5, 10.0)
        end
        for k, v in pairs(Config.Zones) do
            local dist = Vdist(coords, v)
            if dist < 2 then
                if dist < 20 then
                    canwait = false
                end
                if not active then
                    active = true
                    target = k
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", Config.Shoptext,
                    Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                end
                if IsControlJustReleased(0, Config.OpenKey) then
                    TriggerServerEvent("rsg-clothes:LoadClothes", 2)
                end
            else
                if active and k == target then
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ",
                        Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                    active = false
                end
            end
        end
        if canwait then
            Wait(1000)
        end
    end
end)

exports('GetClothesComponents', function()
    return {ComponentsClothesMale, ComponentsClothesFemale}
end)

exports('GetClothesCache', function(name)
    return ClothesCache
end)

exports('GetClothesComponentId', function(name)
    return ClothesCache[name]
end)

exports('GetClothesCurrentComponentHash', function(name)
    if ClothesCache[name] == nil then
        return 0
    end
    local texture = ClothesCache[name].texture
    local model = ClothesCache[name].model
    if model == 0 or texture == 0 then
        return 0
    end
    local hash
    if IsPedMale(PlayerPedId()) then
        if clothes_list["male"][name] ~= nil then
            hash = clothes_list["male"][name][model][texture].hash
        end
    else
        if clothes_list["female"][name] ~= nil then
            hash = clothes_list["female"][name][model][texture].hash
        end
    end
    return hash
end)

local active2 = false
local target2
Citizen.CreateThread(function()
    while true do
        Wait(1)
        local canwait = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Cloakroom) do
            local dist =  Vdist(coords, v)
            if dist < 2 then
                if dist  < 20 then
                    canwait = false
                end
                if not active2 then
                    active2 = true
                    target2 = k
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", Config.Cloakroomtext, Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                end
                if IsControlJustReleased(0, Config.OpenKey) or IsDisabledControlJustReleased(0, Config.OpenKey) then
                    TriggerEvent('rsg-clothes:OpenOutfits')
                end
            else
                if active2 and k == target2 then
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                    active2 = false
                end
            end
        end
        if canwait then
            Wait(1000)
        end
    end
end)
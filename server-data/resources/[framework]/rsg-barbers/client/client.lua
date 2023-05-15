local ComponentsMale = {}
local ComponentsFemale = {}
local CreatorCache = {}
local blipEntries = {}
local textureId = -1
local sit = false
local cam = nil
local camPos = nil
local camRot = nil
local lighting = nil

MenuData = {}
TriggerEvent('rsg-menubase:getData',function(call)
    MenuData = call
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.barberlocations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
        SetBlipSprite(blip, -2090472724, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.name.. Lang:t('menu.barber'))
        blipEntries[#blipEntries + 1] = {type = "BLIP", handle = blip}
        exports['rsg-target']:AddCircleZone(v.name, v.coords, 1, {
            name = v.name,
            debugPoly = false,
            }, {
                options = {
                {
                    type = "client",
                    action = function()
                    TriggerEvent('rsg-barber:client:menu', v.location)
                    end,
                    icon = "fas fa-shopping-basket",
                    label = Lang:t('menu.open_barber'),
                },
            },
            distance = 4.0,
        })
    end
end)

RegisterNetEvent("rsg-barber:client:menu", function()
    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)
    local camFov = GetGameplayCamFov()
    local seat = GetHashKey("PROP_PLAYER_BARBER_SEAT")

    for i = 1, #Config.barberlocations do
        local loc = Config.barberlocations[i]

        if #(playerCoords - loc.coords) < 2 then
            Citizen.InvokeNative(0x4D1F61FC34AF3CD1, ped, seat, loc.seat, 0, 0, 1)

            camPos = loc.camPos
            camRot = loc.camRot
            lighting = loc.lighting

            sit = true

            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            FreezeEntityPosition(ped, true)

            MainMenu()

            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            RenderScriptCams(true, true, 2000, true, true)
            SetCamFov(cam, camFov)
            SetCamCoord(cam, camPos)
            SetCamRot(cam, camRot, 2)
        end
    end
end)

local MainMenus =
{
    ["hair"] = function()
        OpenHairMenu()
    end,
    ["makeup"] = function()
        OpenMakeupMenu()
    end,
    ["save"] = function()
        MenuData.CloseAll()

        LoadedComponents = CreatorCache
        local ped = PlayerPedId()
        local male = true

        if not IsPedMale(ped) then
            male = false
        end

        TriggerServerEvent("rsg-barber:server:SaveSkin", CreatorCache, male)

        RenderScriptCams(false, true, 1000, true, true)
        SetCamActive(cam, false)
        DetachCam(cam)
        DestroyCam(cam, true)

        sit = false
        cam = nil
        lighting = nil

        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)
        ClearPedSecondaryTask(ped)

        Wait(1000)

        TriggerServerEvent("rsg-appearance:LoadSkin")

        CreatorCache = {}
    end
}

local HairFunctions = {
    ["hair"] = function(target, data)
        LoadHair(target, data)
    end,
    ["beard"] = function(target, data)
        LoadBeard(target, data)
    end
}

function MainMenu(Target)
    MenuData.CloseAll()
    local _Target = Target or PlayerPedId()
    local elements = {
        {label = Config.Texts.Hair_beard, value = 'hair',   desc = ""},
        {label = Config.Texts.Makeup,     value = 'makeup', desc = ""},
        {label = Config.Texts.save,       value = 'save',   desc = ""}
    }
    MenuData.Open('default', GetCurrentResourceName(), 'main_character_creator_menu',
        { 
            title = Lang:t('menu.barber_shop'),
            subtext = Config.Texts.Options,
            align = Config.Texts.align,
            elements = elements
        }, function(data, menu)
        MainMenus[data.current.value]()
        end, function(data, menu)
            menu.close()

        RenderScriptCams(false, true, 2000, true, true)
        SetCamActive(cam, false)
        DetachCam(cam)
        DestroyCam(cam, true)

        sit = false
        cam = nil
        lighting = nil

        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())

        Wait(1000)

        TriggerServerEvent("rsg-appearance:LoadSkin")

        CreatorCache = {}
    end)
end

function OpenHairMenu()
    MenuData.CloseAll()
    local elements = {}
    if IsPedMale(PlayerPedId()) then
        local a = 1
        if  CreatorCache["hair"] == nil or type(CreatorCache["hair"]) ~= "table" then
            CreatorCache["hair"] = {}
            CreatorCache["hair"].model = CreatorCache["hair"].model
            CreatorCache["hair"].texture = CreatorCache["hair"].texture
        end
        if  CreatorCache["beard"] == nil or type(CreatorCache["beard"]) ~= "table" then
            CreatorCache["beard"] = {}
            CreatorCache["beard"].model = CreatorCache["beard"].model
            CreatorCache["beard"].texture = CreatorCache["beard"].texture
            
        end
        local options = {}
        -- male hair selection
        local category = hairs_list["male"]["hair"]
        for k, v in pairs(category) do
            table.insert(options, Config.Texts.Style .. k)
        end
        table.insert(elements, {label = Config.Texts.HairStyle, value = CreatorCache["hair"].model or 0, category = "hair", desc = "", type = "slider", min = 0, max = #category, change_type = "model", id = a, options = options})
        a = a + 1
        options = {}
        for i = 1, GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), 1 do
            table.insert(options, Config.Texts.Color .. i)
        end
        table.insert(elements, {label = Config.Texts.HairColor, value = CreatorCache["hair"].texture or 1, category = "hair", desc = "", type = "slider", min = 1, max = GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), change_type = "texture", id = a, options = options})
        options = {}
        a = a + 1
        -- male beard selection
        local category = hairs_list["male"]["beard"]
        for k, v in pairs(category) do
            table.insert(options, Config.Texts.Style .. k)
        end
        table.insert(elements, { label = Config.Texts.BeardStyle, value = CreatorCache["beard"].model or 0, category = "beard", desc = "", type = "slider", min = 0, max = #category, change_type = "model", id = a, options = options})
        a = a + 1
        options = {}
        for i = 1, GetMaxTexturesForModel("beard", CreatorCache["beard"].model or 1), 1 do
            table.insert(options, Config.Texts.Color .. i)
        end
        table.insert(elements, {label = Config.Texts.BeardColor, value = CreatorCache["beard"].texture or 1, category = "beard", desc = "", type = "slider", min = 1, max = GetMaxTexturesForModel("beard", CreatorCache["beard"].model or 1), change_type = "texture", id = a, options = options})
        options = {}
        a = a + 1
    else
        local a = 1
        if CreatorCache["hair"] == nil or type(CreatorCache["hair"]) ~= "table" then
            CreatorCache["hair"] = {}
            CreatorCache["hair"].model = CreatorCache["hair"].model
            CreatorCache["hair"].texture = CreatorCache["hair"].texture
        end
        local options = {}
        -- female hair options
        local category = hairs_list["female"]["hair"]
        for k, v in pairs(category) do
            table.insert(options, Config.Texts.Style .. k)
        end
        table.insert(elements,
            {label = Config.Texts.Hair, value = CreatorCache["hair"].model or 0, category = "hair", desc = "", type = "slider", min = 0, max = #category, change_type = "model", id = a, options = options}
        )
        a = a + 1
        options = {}
        for i = 1, GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), 1 do
            table.insert(options, Config.Texts.HairColor .. i)
        end
        table.insert(elements,
            {label = Config.Texts.Hair, value = CreatorCache["hair"].texture or 1, category = "hair", desc = "", type = "slider", min = 1, max = GetMaxTexturesForModel("hair", CreatorCache["hair"].model or 1), change_type = "texture", id = a, options = options}
        )
        options = {}
        a = a + 1
    end
    MenuData.Open('default', GetCurrentResourceName(), 'hair_main_character_creator_menu',
        {title = Config.Texts.Hair_beard, subtext = Config.Texts.Options, align = Config.Texts.align, elements = elements}, function(data, menu)
    end, function(data, menu)
        MainMenu()
    end, function(data, menu)
        if data.current.change_type == "model" then
            if CreatorCache[data.current.category].model ~= data.current.value then
                CreatorCache[data.current.category].texture = 1
                CreatorCache[data.current.category].model = data.current.value
                if data.current.value > 0 then
                    local options = {}
                    if GetMaxTexturesForModel(data.current.category, data.current.value) > 1 then
                        for i = 1, GetMaxTexturesForModel(data.current.category, data.current.value), 1 do
                            table.insert(options, Config.Texts.Color .. i)
                        end
                    else
                        table.insert(options, "Brak")
                    end
                    menu.setElement(data.current.id + 1, "options", options)
                    menu.setElement(data.current.id + 1, "max", GetMaxTexturesForModel(data.current.category, data.current.value))
                    menu.setElement(data.current.id + 1, "min", 1)
                    menu.setElement(data.current.id + 1, "value", 1)
                    menu.refresh()
                else
                    menu.setElement(data.current.id + 1, "max", 0)
                    menu.setElement(data.current.id + 1, "min", 0)
                    menu.setElement(data.current.id + 1, "value", 0)
                    menu.refresh()
                end
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
         elseif data.current.change_type == "texture" then
            if CreatorCache[data.current.category].texture ~= data.current.value then
                CreatorCache[data.current.category].texture = data.current.value
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
        else
            if CreatorCache[data.current.category] ~= data.current.value then
                CreatorCache[data.current.category] = data.current.value
                HairFunctions[data.current.category](PlayerPedId(), CreatorCache)
            end
        end
    end)
end

function OpenMakeupMenu()
    MenuData.CloseAll()
    local elements = {
        {label = " Stubble Type",               value = CreatorCache["beardstabble_t"] or 1,  category = "beardstabble_t",  desc = "", type = "slider", min = 0, max = 1},
        {label = " Stabble Opacity",            value = CreatorCache["beardstabble_op"] or 0, category = "beardstabble_op", desc = "", type = "slider", min = 0, max = 100, hop = 10},
        {label = Config.Texts.Shadow,           value = CreatorCache["shadows_t"] or 1,       category = "shadows_t",       desc = "", type = "slider", min = 1, max = 5},
        {label = Config.Texts.Clarity,          value = CreatorCache["shadows_op"] or 0,      category = "shadows_op",      desc = "", type = "slider", min = 0, max = 100, hop = 5},
        {label = Config.Texts.ColorShadow,      value = CreatorCache["shadows_id"] or 1,      category = "shadows_id",      desc = "", type = "slider", min = 1, max = 25},
        {label = Config.Texts.ColorFirst_Class, value = CreatorCache["shadows_c1"] or 0,      category = "shadows_c1",      desc = "", type = "slider", min = 0, max = 64},
        {label = Config.Texts.Blushing_Cheek,   value = CreatorCache["blush_t"] or 1,         category = "blush_t",         desc = "", type = "slider", min = 1, max = 4},
        {label = Config.Texts.Clarity,          value = CreatorCache["blush_op"] or 0,        category = "blush_op",        desc = "", type = "slider", min = 0, max = 100, hop = 5},
        {label = Config.Texts.blush_id,         value = CreatorCache["blush_id"] or 1,        category = "blush_id",        desc = "", type = "slider", min = 1, max = 25},
        {label = Config.Texts.blush_c1,         value = CreatorCache["blush_c1"] or 0,        category = "blush_c1",        desc = "", type = "slider", min = 0, max = 64},
        {label = Config.Texts.Lipstick,         value = CreatorCache["lipsticks_t"] or 1,     category = "lipsticks_t",     desc = "", type = "slider", min = 1, max = 7},
        {label = Config.Texts.Clarity,          value = CreatorCache["lipsticks_op"] or 0,    category = "lipsticks_op",    desc = "", type = "slider", min = 0, max = 100, hop = 5},
        {label = Config.Texts.ColorLipstick,    value = CreatorCache["lipsticks_id"] or 1,    category = "lipsticks_id",    desc = "", type = "slider", min = 1, max = 25},
        {label = Config.Texts.lipsticks_c1,     value = CreatorCache["lipsticks_c1"] or 0,    category = "lipsticks_c1",    desc = "", type = "slider", min = 0, max = 64},
        {label = Config.Texts.lipsticks_c2,     value = CreatorCache["lipsticks_c2"] or 0,    category = "lipsticks_c2",    desc = "", type = "slider", min = 0, max = 64},
        {label = Config.Texts.Eyeliners,        value = CreatorCache["eyeliners_t"] or 1,     category = "eyeliners_t",     desc = "", type = "slider", min = 1, max = 15},
        {label = Config.Texts.Clarity,          value = CreatorCache["eyeliners_op"] or 0,    category = "eyeliners_op",    desc = "", type = "slider", min = 0, max = 100, hop = 5},
        {label = Config.Texts.eyeliners_id,     value = CreatorCache["eyeliners_id"] or 1,    category = "eyeliners_id",    desc = "", type = "slider", min = 1, max = 25},
        {label = Config.Texts.eyeliners_c1,     value = CreatorCache["eyeliners_c1"] or 0,    category = "eyeliners_c1",    desc = "", type = "slider", min = 0, max = 64}
    }
    MenuData.Open('default', GetCurrentResourceName(), 'makeup_character_creator_menu',
        {title = Config.Texts.Make_up, subtext = Config.Texts.Options, align = Config.Texts.align, elements = elements}, function(data, menu)
    end, function(data, menu)
        MainMenu()
    end, function(data, menu)
        if CreatorCache[data.current.category] ~= data.current.value then
            CreatorCache[data.current.category] = data.current.value
            LoadOverlays(PlayerPedId(), CreatorCache)
        end
    end)
end


function GetMaxTexturesForModel(category, model)
    -- print(model)
    -- print(category)
    if model == 0 then
        model = 1
    end
    if IsPedMale(PlayerPedId()) then
        return #hairs_list["male"][category][model]
    else
        return #hairs_list["female"][category][model]
    end
end

function LoadHair(target, data)
    if data.hair ~= nil then
        if type(data.hair) == "table" then
            if data.hair.model ~= nil then
                if tonumber(data.hair.model) > 0 then
                    if IsPedMale(target) then
                        if hairs_list["male"]["hair"][tonumber(data.hair.model)] ~= nil then
                            if hairs_list["male"]["hair"][tonumber(data.hair.model)][tonumber(data.hair.texture)] ~= nil then       
                                local hair = hairs_list["male"]["hair"][tonumber(data.hair.model)][tonumber(data.hair.texture)].hash
                                NativeSetPedComponentEnabled(target, tonumber(hair), false, true, true)
                            end
                        end
                    else
                        if hairs_list["female"]["hair"][tonumber(data.hair.model)] ~= nil then
                            if hairs_list["female"]["hair"][tonumber(data.hair.model)][tonumber(data.hair.texture)] ~=
                                nil then
                                    local hair = hairs_list["female"]["hair"][tonumber(data.hair.model)][tonumber(data.hair.texture)].hash
                                NativeSetPedComponentEnabled(target, tonumber(hair), false, true, true)
                            end
                        end
                    end
                else
                    Citizen.InvokeNative(0xD710A5007C2AC539, target, 0x864B03AE, 0)
                    NativeUpdatePedVariation(target)
                end
            end
        end
    end
end

function LoadBeard(target, data)
    if data.beard ~= nil then
        if type(data.beard) == "table" then
            if data.beard.model ~= nil then
                if tonumber(data.beard.model) > 0 then
                    if IsPedMale(target) then
                        if hairs_list["male"]["beard"][tonumber(data.beard.model)] ~= nil then
                            if hairs_list["male"]["beard"][tonumber(data.beard.model)][tonumber(data.beard.texture)] ~=
                                nil then
                                    local beard = hairs_list["male"]["beard"][tonumber(data.beard.model)][tonumber(data.beard.texture)].hash
                                NativeSetPedComponentEnabled(target, tonumber(beard), false, true, true)
                            end
                        end
                    end
                else
                    Citizen.InvokeNative(0xD710A5007C2AC539, target, 0xF8016BCA, 0)
                    NativeUpdatePedVariation(target)
                end
            end
        end
    end
end

function LoadHead(target, data)
    if IsPedMale(target) then
        local head = ComponentsMale["heads"][tonumber(data.head) or 1]
        NativeSetPedComponentEnabled(target, tonumber(head), false, true, true)
    else
        local head = ComponentsFemale["heads"][tonumber(data.head) or 1]
        NativeSetPedComponentEnabled(target, tonumber(head), false, true, true)
    end
end

function NativeSetPedFaceFeature(ped, index, value)
    Citizen.InvokeNative(0x5653AB26C82938CF, ped, index, value)
    NativeUpdatePedVariation(ped)
end

function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, true)
    NativeUpdatePedVariation(ped)
end

function NativeHasPedComponentLoaded(ped)
    return Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped)
end

function NativeUpdatePedVariation(ped)
    Citizen.InvokeNative(0x704C908E9C405136, ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
    while not NativeHasPedComponentLoaded(ped) do
        Wait(1)
    end
end

function ChangeOverlays(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk, palette_id,
    palette_color_primary, palette_color_secondary, palette_color_tertiary, var, opacity)
    for k, v in pairs(overlay_all_layers) do
        if v.name == name then
            v.visibility = visibility
            if visibility ~= 0 then
                v.tx_normal = tx_normal
                v.tx_material = tx_material
                v.tx_color_type = tx_color_type
                v.tx_opacity = tx_opacity
                v.tx_unk = tx_unk
                if tx_color_type == 0 then
                    v.palette = color_palettes[palette_id][1]
                    v.palette_color_primary = palette_color_primary
                    v.palette_color_secondary = palette_color_secondary
                    v.palette_color_tertiary = palette_color_tertiary
                end
                if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
                    v.var = var
                    v.tx_id = overlays_info[name][1].id
                else
                    v.var = 0
                    v.tx_id = overlays_info[name][tx_id].id
                end
                v.opacity = opacity
            end
        end
    end

end

function ApplyOverlays(overlayTarget)
    if IsPedMale(overlayTarget) then
        current_texture_settings = texture_types["male"]
    else
        current_texture_settings = texture_types["female"]
    end
    if textureId ~= -1 then
        Citizen.InvokeNative(0xB63B9178D0F58D82, textureId) -- reset texture
        Citizen.InvokeNative(0x6BEFAA907B076859, textureId) -- remove texture
    end
    textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, current_texture_settings.albedo,
        current_texture_settings.normal, current_texture_settings.material); -- create texture
    for k, v in pairs(overlay_all_layers) do
        if v.visibility ~= 0 then
            local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02, textureId, v.tx_id, v.tx_normal, v.tx_material,
                v.tx_color_type, v.tx_opacity, v.tx_unk); -- create overlay
            if v.tx_color_type == 0 then
                Citizen.InvokeNative(0x1ED8588524AC9BE1, textureId, overlay_id, v.palette); -- apply palette
                Citizen.InvokeNative(0x2DF59FFE6FFD6044, textureId, overlay_id, v.palette_color_primary,
                    v.palette_color_secondary, v.palette_color_tertiary) -- apply palette colours
            end
            Citizen.InvokeNative(0x3329AAE2882FC8E4, textureId, overlay_id, v.var); -- apply overlay variant
            Citizen.InvokeNative(0x6C76BC24F8BB709A, textureId, overlay_id, v.opacity); -- apply overlay opacity
        end
    end
    while not Citizen.InvokeNative(0x31DC8D3F216D8509, textureId) do -- wait till texture fully loaded
        Citizen.Wait(0)
    end
    Citizen.InvokeNative(0x92DAABA2C1C10B0E, textureId) -- update texture
    Citizen.InvokeNative(0x8472A1789478F82F, textureId) -- reset texture
    Citizen.InvokeNative(0x0B46E25761519058, overlayTarget, GetHashKey("heads"), textureId) -- apply texture to current component in category "heads"
    Citizen.InvokeNative(0xCC8CA3E88256E58F, overlayTarget, 0, 1, 1, 1, false); -- refresh ped components
    -- --print(PlayerPedId() , overlayTarget)
    -- Citizen.InvokeNative(0x0B46E25761519058, overlayTarget, GetHashKey("heads"), textureId) -- apply texture to current component in category "heads"
    -- Citizen.InvokeNative(0x92DAABA2C1C10B0E, textureId) -- update texture
    -- Citizen.InvokeNative(0xCC8CA3E88256E58F, overlayTarget, 0, 1, 1, 1, false); -- refresh ped components
end

function LoadOverlays(target, data)

    if tonumber(data.eyebrows_t) ~= nil and tonumber(data.eyebrows_op) ~= nil then
        ChangeOverlays("eyebrows", 1, tonumber(data.eyebrows_t), 0, 0, 0, 1.0, 0, tonumber(data.eyebrows_id) or 1,
            tonumber(data.eyebrows_c1) or 0, 0, 0, 0, tonumber(data.eyebrows_op / 100))
    else
        ChangeOverlays("eyebrows", 1, 1, 0, 0, 0, 1.0, 0, 10, 0, 0, 0, 0, 1.0)
    end

    if tonumber(data.scars_t) ~= nil and tonumber(data.scars_op) ~= nil then
        ChangeOverlays("scars", 1, tonumber(data.scars_t), 0, 0, 1, 1.0, 0, tonumber(0), 0, 0, 0, tonumber(0),
            tonumber(data.scars_op / 100))
    end

    if tonumber(data.ageing_t) ~= nil and tonumber(data.ageing_op) ~= nil then
        ChangeOverlays("ageing", 1, tonumber(data.ageing_t), 0, 0, 1, 1.0, 0, tonumber(0), 0, 0, 0, tonumber(0),
            tonumber(data.ageing_op / 100))
    end

    if tonumber(data.freckles_t) ~= nil and tonumber(data.freckles_op) ~= nil then
        ChangeOverlays("freckles", 1, tonumber(data.freckles_t), 0, 0, 1, 1.0, 0, tonumber(0), 0, 0, 0, tonumber(0),
            tonumber(data.freckles_op / 100))
    end

    if tonumber(data.moles_t) ~= nil and tonumber(data.moles_op) ~= nil then
        ChangeOverlays("moles", 1, tonumber(data.moles_t), 0, 0, 1, 1.0, 0, tonumber(0), 0, 0, 0, tonumber(0),
            tonumber(data.moles_op / 100))
    end

    if tonumber(data.spots_t) ~= nil and tonumber(data.spots_op) ~= nil then
        ChangeOverlays("spots", 1, tonumber(data.spots_t), 0, 0, 1, 1.0, 0, tonumber(0), 0, 0, 0, tonumber(0),
            tonumber(data.spots_op / 100))
    end

    if tonumber(data.eyeliners_t) ~= nil and tonumber(data.eyeliners_op) ~= nil then
        ChangeOverlays("eyeliners", 1, 1, 0, 0, 0, 1.0, 0, tonumber(data.eyeliners_id) or 1,
            tonumber(data.eyeliners_c1) or 0, 0, 0, tonumber(data.eyeliners_t), tonumber(data.eyeliners_op / 100))
    end

    if tonumber(data.shadows_t) ~= nil and tonumber(data.shadows_op) ~= nil then
        ChangeOverlays("shadows", 1, tonumber(1), 0, 0, 0, 1.0, 0, tonumber(data.shadows_id) or 1,
            tonumber(data.shadows_c1) or 0, 0, 0, tonumber(data.shadows_t), tonumber(data.shadows_op / 100))
    end

    if tonumber(data.lipsticks_t) ~= nil and tonumber(data.lipsticks_op) ~= nil then
        ChangeOverlays("lipsticks", 1, 1, 0, 0, 0, 1.0, 0, tonumber(data.lipsticks_id) or 1,
            tonumber(data.lipsticks_c1) or 0, tonumber(data.lipsticks_c2) or 0, 0, tonumber(data.lipsticks_t),
            tonumber(data.lipsticks_op / 100))
    end

    if tonumber(data.blush_t) ~= nil and tonumber(data.blush_op) ~= nil then
        ChangeOverlays("blush", 1, tonumber(data.blush_t), 0, 0, 0, 1.0, 0, tonumber(data.blush_id) or 1,
            tonumber(data.blush_c1) or 0, 0, 0, 0, tonumber(data.blush_op / 100))
    end

    if tonumber(data.beardstabble_t) ~= nil and tonumber(data.beardstabble_op) ~= nil then
        ChangeOverlays("beardstabble", 1, 1, 0, 0, 0, 1.0, 0, 10, 0, 0, 0, 0, tonumber(data.beardstabble_op / 100))
    end
    ApplyOverlays(target)
end

-- Cameras & Lihtings
CreateThread(function()
    while true do
        local t = 3000

        if not sit then goto continue end

        DrawLightWithRange(lighting, 255, 255, 255, 2.5, 50.0)
        SetCamCoord(cam, camPos)
        SetCamRot(cam, camRot, 2)

        t = 4

        ::continue::

        Wait(t)
    end
end)

-- Cleanup
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    MenuData.CloseAll()

    CreatorCache = {}
    MenuData = {}

    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DetachCam(cam)
    DestroyCam(cam, true)

    sit = false
    cam = nil
    lighting = nil

    ClearPedTasks(PlayerPedId())
    ClearPedSecondaryTask(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)

    for i = 1, #blipEntries do
        if blipEntries[i].type == "BLIP" then
            RemoveBlip(blipEntries[i].handle)
        end
    end
end)
local RSGCore = exports['rsg-core']:GetCoreObject()
BathingPed = nil
local inbath = false
local playerCoords = nil
local isBathingActive = false

exports('IsBathingActive', function()
    return inbath
end)

Citizen.CreateThread(function()
    CreateBlips()
    CloseBathDoors()
    if RegisterPrompts() then
        local bath = nil

        while true do
            bath = GetClosestConsumer()

            if bath then
                if not PromptsEnabled then TogglePrompts({ "START_BATHING" }, true) end
                if PromptsEnabled then
                    if IsPromptCompleted("START_BATHING") then
                        Action("START_BATHING", bath)
                    end
                end
            else 
                if PromptsEnabled then TogglePrompts({ "START_BATHING" }, false) end
                Citizen.Wait(250) 
            end
            Citizen.Wait(100)
        end
    end
end)

local playerCoords = nil
GetClosestConsumer = function()
    playerCoords = GetEntityCoords(PlayerPedId())

    for townName,data in pairs(Config.BathingZones) do
        if #(playerCoords - data.consumer) < 1.0 then
            return townName
        end
    end
    return nil
end

RegisterNetEvent('rsg-bathing:client:StartBath')
AddEventHandler('rsg-bathing:client:StartBath', function(town)
    inbath = true 
    if Config.BathingZones[town] then
        SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true, 0, true, true)

        LoadAllStreamings()

        LoadModel(`P_CS_RAG02X`)
        local rag = CreateObject(`P_CS_RAG02X`, GetEntityCoords(PlayerPedId()), false, false, false, false, true)
        table.insert(Config.CreatedEntries, { type = "PED", handle = rag })
        SetModelAsNoLongerNeeded(`P_CS_RAG02X`)

        SetPedCanLegIk(PlayerPedId(), false)
        SetPedLegIkMode(PlayerPedId(), 0)
        ClearPedTasksImmediately(PlayerPedId(), true, true)

        local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0, "s_regular_intro", false, true)
        SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
        SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)
        
        LoadAnimScene(animscene)  
        while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED

        TriggerMusicEvent("MG_BATHING_START")
        StartAnimScene(animscene)

        while Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) <= 0.3 do Citizen.Wait(0) end
        
		UndressCharacter()

        while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(0) end

        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        table.insert(Config.CreatedEntries, { type = "CAM", handle = cam })

        N_0x69d65e89ffd72313(true, true)
        SetCamCoord(cam, GetFinalRenderedCamCoord(), 0.0, 0.4, 0.5)
        SetCamRot(cam, GetFinalRenderedCamRot(1), 1)
        SetCamFov(cam, GetFinalRenderedCamFov())
        RenderScriptCams(true, true, 0, true, false, 0)

        TogglePrompts({ "STOP_BATHING", "REQUEST_DELUXE_BATHING", "SCRUB" }, true)
		
        TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Regular", `CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR`, `DEFAULT`, "BATHING" })
        TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { rag, "Script_Mini_Game_Bathing_Regular", `CLIPSET@MINI_GAMES@BATHING@REGULAR@RAG`, `DEFAULT`, "BATHING" })    

        ForceEntityAiAndAnimationUpdate(rag, true);
        Citizen.InvokeNative(0x55546004A244302A, PlayerPedId())

        local holdTime, bathMode = 0, 1
        while DoesCamExist(cam) do
            while not IsTaskMoveNetworkReadyForTransition(PlayerPedId()) do Citizen.Wait(100) end

            if IsPromptEnabled("SCRUB") and bathMode == #Config.BathingModes+1 then TogglePrompts({ "SCRUB" }, false) end
            if IsControlPressed(0, `INPUT_CONTEXT_X`) and IsPromptEnabled("SCRUB") then
                if IsPromptEnabled("REQUEST_DELUXE_BATHING") then TogglePrompts({ "REQUEST_DELUXE_BATHING" }, false) end

                while GetTaskMoveNetworkState(PlayerPedId()) ~= "Scrub_Idle" do
                    RequestTaskMoveNetworkStateTransition(PlayerPedId(), "Scrub_Idle");
                    RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, "Scrub_Idle");
                    Citizen.Wait(200)
                end

                while IsControlPressed(0, `INPUT_CONTEXT_X`) do
                    if IsPromptCompleted("SCRUB") then
                        if DoesEntityExist(BathingPed) and not Config.BathingModes[bathMode].deluxe then 
                            bathMode = bathMode+1    
                        end
                        
                        holdTime = holdTime + (Config.BathingModes[bathMode].hold_power or 0.01)

                        if GetTaskMoveNetworkState(PlayerPedId()) ~= Config.BathingModes[bathMode].transition then
                            SetCurrentCleaniest(rag, 0.0)

                            RequestTaskMoveNetworkStateTransition(PlayerPedId(), Config.BathingModes[bathMode].transition);
                            RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, Config.BathingModes[bathMode].transition);                    
                        end

                        SetTaskMoveNetworkSignalFloat(PlayerPedId(), "scrub_freq", Config.BathingModes[bathMode].scrub_freq);
                        SetTaskMoveNetworkSignalFloat((DoesEntityExist(BathingPed) and BathingPed) or rag, "scrub_freq", Config.BathingModes[bathMode].scrub_freq);

                        SetCurrentCleaniest(rag, holdTime)

                        if holdTime >= 1.0 then
                            holdTime = 0.0

                            if bathMode+1 > #Config.BathingModes then

                                TogglePrompts({ "REQUEST_DELUXE_BATHING", "SCRUB" }, false)                            
                                
                                ClearPedEnvDirt(PlayerPedId())
                                ClearPedBloodDamage(PlayerPedId())
                                N_0xe3144b932dfdff65(PlayerPedId(), 0.0, -1, 1, 1)
                                ClearPedDamageDecalByZone(PlayerPedId(), 10, "ALL")
                                Citizen.InvokeNative(0x7F5D88333EE8A86F, PlayerPedId(), 1)

                                bathMode = #Config.BathingModes+1
                                if DoesEntityExist(BathingPed) then
                                    Citizen.Wait(750) ExitPremiumBath(animscene, town, cam, true)
                                end
                            else bathMode = bathMode+1 end

                            break 
                        end
                    end
                    Citizen.Wait(100)
                end
                while not IsTaskMoveNetworkReadyForTransition(PlayerPedId()) do Citizen.Wait(10) end

                local resetTo = (((bathMode == #Config.BathingModes+1) or DoesEntityExist(BathingPed)) and "Bathing" or "Scrub_Idle")
                while GetTaskMoveNetworkState(PlayerPedId()) ~= resetTo do
                    SetCurrentCleaniest(rag, 1.0)
                    
                    while GetTaskMoveNetworkState(PlayerPedId()) ~= "Scrub_Idle" do
                        RequestTaskMoveNetworkStateTransition(PlayerPedId(), "Scrub_Idle");
                        RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, "Scrub_Idle");
                        Citizen.Wait(200)
                    end

                    if resetTo ~= "Scrub_Idle" and (DoesEntityExist(BathingPed) and not IsControlPressed(0, `INPUT_CONTEXT_X`) or not DoesEntityExist(BathingPed)) then
                        RequestTaskMoveNetworkStateTransition(PlayerPedId(), "Bathing");
                        RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, "Bathing");
                    elseif resetTo ~= "Scrub_Idle" and DoesEntityExist(BathingPed) and IsControlPressed(0, `INPUT_CONTEXT_X`) then
                        resetTo = "Scrub_Idle"
                    end
                    Citizen.Wait(500)
                end
            end

            if IsPromptCompleted("REQUEST_DELUXE_BATHING") then
                Action("REQUEST_DELUXE_BATHING", animscene, town, cam) 
            end

            if IsPromptCompleted("STOP_BATHING") then
                Action("STOP_BATHING", animscene, town, cam)
            end
            Citizen.Wait(10)
        end
    end
end)

ExitBathing = function(animscene, town, cam)
    inbath = false 
    if DoesEntityExist(BathingPed) then
        ExitPremiumBath(animscene, town, cam)
        return
    end

    if Citizen.InvokeNative(0x25557E324489393C, animscene) then 
        Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE
    end

    local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_regular_outro", false, true)
    SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
    SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)

    LoadAnimScene(animscene)  
    while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
    StartAnimScene(animscene)

    if DoesCamExist(cam) then 
        RenderScriptCams(false, false, 0, true, false, 0)
        DestroyCam(cam) 
    end

    while Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) <= 0.35 do Citizen.Wait(1) end
    
    while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED
    
	DressCharacter()
    UnloadAllStreamings()
    N_0x69d65e89ffd72313(false, false)
    TriggerMusicEvent("MG_BATHING_STOP")
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    TriggerServerEvent("rsg-bathing:server:setBathAsFree", town)

    if DoesEntityExist(Citizen.InvokeNative(0xE5822422197BBBA3, animscene, "Female", false)) then
        DeletePed(Citizen.InvokeNative(0xE5822422197BBBA3, animscene, "Female", false))
    end

    SetPedCanLegIk(PlayerPedId(), true)
    SetPedLegIkMode(PlayerPedId(), 2)
end

RegisterNetEvent('rsg-bathing:client:StartDeluxeBath')
AddEventHandler('rsg-bathing:client:StartDeluxeBath', function(animscene, town, cam)
    if not IsPedMale(PlayerPedId()) then
        if not Citizen.InvokeNative(0x25557E324489393C, animscene) then return end
        Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

        local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_deluxe_intro", false, true)
        SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
        SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)
        
        LoadModel(Config.BathingZones[town].guy)
        BathingPed = CreatePed(Config.BathingZones[town].guy, GetEntityCoords(PlayerPedId())-vector3(0.0, 0.0, -5.0), 0.0, false, false, true, true)
        table.insert(Config.CreatedEntries, { type = "PED", handle = BathingPed })
        Citizen.InvokeNative(0x283978A15512B2FE, BathingPed, true)
        SetAnimSceneEntity(animscene, "Female", BathingPed, 0)
        SetModelAsNoLongerNeeded(Config.BathingZones[town].guy)

        LoadAnimScene(animscene)  
        while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
        PlaySoundFrontend("BATHING_DOOR_KNOCK_MASTER", 0, true, 0)
        Citizen.Wait(1000)
        StartAnimScene(animscene)

        RenderScriptCams(false, false, 0, true, false, 0)

        while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED
        Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

        TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR`, `DEFAULT`, "BATHING" })
        TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { BathingPed, "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID`, `DEFAULT`, "BATHING" })    
            
        TogglePrompts({ "STOP_BATHING", "SCRUB" }, true)

        RenderScriptCams(true, true, 0, true, false, 0)
    else
        if not Citizen.InvokeNative(0x25557E324489393C, animscene) then return end
        Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

        local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_deluxe_intro", false, true)
        SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
        SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)
        
        LoadModel(Config.BathingZones[town].lady)
        BathingPed = CreatePed(Config.BathingZones[town].lady, GetEntityCoords(PlayerPedId())-vector3(0.0, 0.0, -5.0), 0.0, false, false, true, true)
        table.insert(Config.CreatedEntries, { type = "PED", handle = BathingPed })
        Citizen.InvokeNative(0x283978A15512B2FE, BathingPed, true)
        SetAnimSceneEntity(animscene, "Female", BathingPed, 0)
        SetModelAsNoLongerNeeded(Config.BathingZones[town].lady)

        LoadAnimScene(animscene)  
        while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
        PlaySoundFrontend("BATHING_DOOR_KNOCK_MASTER", 0, true, 0)
        Citizen.Wait(1000)
        StartAnimScene(animscene)

        RenderScriptCams(false, false, 0, true, false, 0)

        while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED
        Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

        TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR`, `DEFAULT`, "BATHING" })
        TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { BathingPed, "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID`, `DEFAULT`, "BATHING" })    
            
        TogglePrompts({ "STOP_BATHING", "SCRUB" }, true)

        RenderScriptCams(true, true, 0, true, false, 0)
    end
end)

RegisterNetEvent('rsg-bathing:client:HideDeluxePrompt')
AddEventHandler('rsg-bathing:client:HideDeluxePrompt', function()
    TogglePrompts({ "REQUEST_DELUXE_BATHING" }, false)
    TogglePrompts({ "STOP_BATHING", "SCRUB" }, true)
end)

ExitPremiumBath = function(animscene, town, cam, disableScrub)
    local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_deluxe_outro", false, true)
    SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
    SetAnimSceneEntity(animscene, "Female", BathingPed, 0)
    SetAnimSceneEntity(animscene, "Door", Citizen.InvokeNative(0xF7424890E4A094C0, Config.BathingZones[town].door, 0), 0)

    LoadAnimScene(animscene)  
    while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
    StartAnimScene(animscene)

    RenderScriptCams(false, false, 0, true, false, 0)

    while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED

    TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Regular", `CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR`, `DEFAULT`, "BATHING" })
    TriggerEvent("rsg-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { BathingPed, "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@REGULAR@MAID`, `DEFAULT`, "BATHING" })    
        
    TogglePrompts({ "STOP_BATHING", "SCRUB" }, true)
    if IsPromptEnabled("SCRUB") and disableScrub then TogglePrompts({ "SCRUB" }, false) end

    RenderScriptCams(true, true, 0, true, false, 0)
    DeletePed(BathingPed)
end

LoadModel = function(model)
    while not HasModelLoaded(model) do RequestModel(model) Citizen.Wait(10) end
end

LoadAllStreamings = function()
    RequestAnimDict("MINI_GAMES@BATHING@REGULAR@ARTHUR");
    RequestAnimDict("MINI_GAMES@BATHING@REGULAR@RAG");
    RequestAnimDict("MINI_GAMES@BATHING@DELUXE@ARTHUR");
    RequestAnimDict("MINI_GAMES@BATHING@DELUXE@MAID");

    RequestClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR");
    RequestClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@RAG");
    RequestClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR");
    RequestClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID");

    Citizen.InvokeNative(0x2B6529C54D29037A, "Script_Mini_Game_Bathing_Regular");
    Citizen.InvokeNative(0x2B6529C54D29037A, "Script_Mini_Game_Bathing_Deluxe");
end

UnloadAllStreamings = function()
    RemoveAnimDict("MINI_GAMES@BATHING@REGULAR@ARTHUR");
    RemoveAnimDict("MINI_GAMES@BATHING@REGULAR@RAG");
    RemoveAnimDict("MINI_GAMES@BATHING@DELUXE@ARTHUR");
    RemoveAnimDict("MINI_GAMES@BATHING@DELUXE@MAID");

    RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR");
    RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@RAG");
    RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR");
    RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID");

    Citizen.InvokeNative(0x57A197AD83F66BBF, "Script_Mini_Game_Bathing_Regular");
    Citizen.InvokeNative(0x57A197AD83F66BBF, "Script_Mini_Game_Bathing_Deluxe");
end

UndressCharacter = function()
    local ped = PlayerPedId()
    local EquippedWeapons = {}

    EquippedWeapons = exports['rsg-weapons']:EquippedWeapons()

    for i = 1, #EquippedWeapons do
        RemoveWeaponFromPed(ped, EquippedWeapons[i])
    end
    TriggerEvent('rsg-wardrobe:client:removeAllClothing')
end

DressCharacter = function()
    TriggerServerEvent('rsg-appearance:LoadSkin')
end

SetCurrentCleaniest = function(rag, value)
    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Right_Arm", value);
    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Left_Arm", value);
    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Left_Leg", value);
    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Right_Leg", value);
    SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Head", value);

    SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Right_Arm", value);
    SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Left_Arm", value);
    SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Left_Leg", value);
    SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Right_Leg", value);
    SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Head", value);

    if DoesEntityExist(BathingPed) then
        SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Right_Arm", value);
        SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Left_Arm", value);
        SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Left_Leg", value);
        SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Right_Leg", value);
        SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Head", value);
    end
end

Action = function(name, p1, p2, p3)
    TogglePrompts("ALL", false)

    if (name == "START_BATHING") then
        TriggerServerEvent("rsg-bathing:server:canEnterBath", p1)
    elseif (name == "REQUEST_DELUXE_BATHING") then
        TriggerServerEvent("rsg-bathing:server:canEnterDeluxeBath", p1 , p2 , p3)
    elseif (name == "STOP_BATHING") then
        ExitBathing(p1, p2, p3)
    end
    Citizen.Wait(500)
end

-- prompts
RegisterPrompts = function()
    local newTable = {}

    for i=1, #Config.Prompts do
        local prompt = Citizen.InvokeNative(0x04F97DE45A519419, Citizen.ResultAsInteger())
        Citizen.InvokeNative(0x5DD02A8318420DD7, prompt, CreateVarString(10, "LITERAL_STRING", Config.Prompts[i].label))
        Citizen.InvokeNative(0xB5352B7494A08258, prompt, Config.Prompts[i].control or 0xDFF812F9)
        Citizen.InvokeNative(0x94073D5CA3F16B7B, prompt, Config.Prompts[i].time or 1000)

        Citizen.InvokeNative(0xF7AA2696A22AD8B9, prompt)

        Citizen.InvokeNative(0x8A0FB4D03A630D21, prompt, false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, prompt, false)

        table.insert(Config.CreatedEntries, { type = "PROMPT", handle = prompt })
        newTable[Config.Prompts[i].id] = prompt
    end

    Config.Prompts = newTable
    return true
end

TogglePrompts = function(data, state)
    for index,prompt in pairs((data ~= "ALL" and data) or Config.Prompts) do
        if Config.Prompts[(data ~= "ALL" and prompt) or index] then
            Citizen.InvokeNative(0x8A0FB4D03A630D21, (data ~= "ALL" and Config.Prompts[prompt]) or prompt, state)
            Citizen.InvokeNative(0x71215ACCFDE075EE, (data ~= "ALL" and Config.Prompts[prompt]) or prompt, state)
        end
    end
    PromptsEnabled = state
end

IsPromptCompleted = function(name)
    if Config.Prompts[name] then
        return Citizen.InvokeNative(0xE0F65F0640EF0617, Config.Prompts[name])
    end return
end

IsPromptEnabled = function(name)
    if Config.Prompts[name] then
        return PromptIsEnabled(Config.Prompts[name])
    end return
end

-- blips
CreateBlips = function()
    for townName,data in pairs(Config.BathingZones) do
        Citizen.Wait(10)
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 0xB04092F8, data.consumer)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, CreateVarString(10, "blip_bath_house"))
        SetBlipSprite(blip, `blip_bath_house`)

        table.insert(Config.CreatedEntries, { type = "BLIP", handle = blip })
    end
end

-- doors
CloseBathDoors = function()
    for townName,data in pairs(Config.BathingZones) do
        if data.door then
            if not IsDoorRegisteredWithSystem(data.door) then
                Citizen.InvokeNative(0xD99229FE93B46286, data.door, 1, 1, 0, 0, 0, 0)
                DoorSystemSetDoorState(data.door, 1)     
            end
        end
    end      
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for i=1, #Config.CreatedEntries do
            if Config.CreatedEntries[i].type == "PED" then
                if DoesEntityExist(Config.CreatedEntries[i].handle) then DeleteEntity(Config.CreatedEntries[i].handle) end
            elseif Config.CreatedEntries[i].type == "BLIP" then
                RemoveBlip(Config.CreatedEntries[i].handle)
            elseif Config.CreatedEntries[i].type == "PROMPT" then
                Citizen.InvokeNative(0x00EDE88D4D13CF59, Config.CreatedEntries[i].handle)
            elseif Config.CreatedEntries[i].type == "CAM" then
                if DoesCamExist(Config.CreatedEntries[i].handle) then RenderScriptCams(false, false, 0, false, false, false) DestroyCam(Config.CreatedEntries[i].handle) end
            end
        end
    end
end)

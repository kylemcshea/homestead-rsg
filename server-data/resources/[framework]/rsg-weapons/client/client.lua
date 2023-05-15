local RSGCore = exports['rsg-core']:GetCoreObject()
local currentSerial = nil
local alreadyUsed = false
local UsedWeapons = {}
local EquippedWeapons = {}

exports('EquippedWeapons', function()
    if EquippedWeapons ~= nil then
        return EquippedWeapons
    end
end)

-- Models Loader
local LoadModel = function(model)
    if not IsModelInCdimage(model) then
        return false
    end

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(0)
    end

    return true
end

local getGuidFromItemId = function(inventoryId, itemData, category, slotId)
    local outItem = DataView.ArrayBuffer(8 * 13)

    if not itemData then
        itemData = 0
    end

    local success = Citizen.InvokeNative(0x886DFD3E185C8A89, inventoryId, itemData, category, slotId, outItem:Buffer())

    if success then
        return outItem:Buffer()
    end

    return nil
end

local addWardrobeInventoryItem = function(itemName, slotHash)
    local itemHash = GetHashKey(itemName)
    local addReason = `ADD_REASON_DEFAULT`
    local inventoryId = 1
    local isValid = Citizen.InvokeNative(0x6D5D51B188333FD1, itemHash, 0)

    if not isValid then
        return false
    end

    local characterItem = getGuidFromItemId(inventoryId, nil, `CHARACTER`, 0xA1212100)

    if not characterItem then
        return false
    end

    local wardrobeItem = getGuidFromItemId(inventoryId, characterItem, `WARDROBE`, 0x3DABBFA7)

    if not wardrobeItem then
        return false
    end

    local itemData = DataView.ArrayBuffer(8 * 13)
    local isAdded = Citizen.InvokeNative(0xCB5D11F9508A928D, inventoryId, itemData:Buffer(), wardrobeItem, itemHash, slotHash, 1, addReason)

    if not isAdded then
        return false
    end

    local equipped = Citizen.InvokeNative(0x734311E2852760D0, inventoryId, itemData:Buffer(), true)

    return equipped
end

local GiveWeaponComponentToEntity = function(entity, componentHash, weaponHash, p3)
    return Citizen.InvokeNative(0x74C9090FDD1BB48E, entity, componentHash, weaponHash, p3)
end

RegisterNetEvent('rsg-weapons:client:AutoDualWield', function()
    local ped = PlayerPedId()

    addWardrobeInventoryItem("CLOTHING_ITEM_M_OFFHAND_000_TINT_004", 0xF20B6B4A)
    addWardrobeInventoryItem("UPGRADE_OFFHAND_HOLSTER", 0x39E57B01)

    Citizen.InvokeNative(0x1B7C5ADA8A6910A0, `SP_WEAPON_DUALWIELD`, true)
    Citizen.InvokeNative(0x46B901A8ECDB5A61, `SP_WEAPON_DUALWIELD`, true)
    Citizen.InvokeNative(0x83B8D50EB9446BBA, ped, true)
end)

RegisterNetEvent('rsg-weapons:client:UseWeapon', function(weaponData, shootbool)
    local ped = PlayerPedId()
    local weaponName = tostring(weaponData.name)
    local hash = GetHashKey(weaponData.name)
    local wepSerial = tostring(weaponData.info.serie)

    for i = 1, #EquippedWeapons do
        local usedHash = EquippedWeapons[i]

        if hash == usedHash then
            alreadyUsed = true
        end
    end

    EquippedWeapons[#EquippedWeapons + 1] = hash

    if not alreadyUsed and not UsedWeapons[tonumber(hash)] then

        if string.find(weaponName, 'thrown') == false then
            UsedWeapons[tonumber(hash)] = {
                name = weaponData.name,
                WeaponHash = hash,
                data = weaponData,
                serie = weaponData.info.serie,
            }
        end

        if weaponName == 'weapon_bow' or weaponName == 'weapon_bow_improved' then
            if weaponData.info.ammo == nil or weaponData.info.ammo == 0 then
                local hasItem = RSGCore.Functions.HasItem('ammo_arrow', 1)
                if hasItem then
                    weaponData.info.ammo = Config.AmountArrowAmmo
                    weaponData.info.ammoclip = Config.AmountArrowAmmo
                    TriggerServerEvent('rsg-weapons:server:removeWeaponAmmoItem', 'ammo_arrow')
                else
                    weaponData.info.ammo = 0
                    weaponData.info.ammoclip = 0
                    RSGCore.Functions.Notify(Lang:t('error.no_arrows_your_inventory_load'), 'error')
                end
            end
            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, hash, 0, false, true)

        --check throwables weapons
        elseif string.find(weaponName, 'thrown') then
            GiveWeaponToPed_2(ped, hash, 0, false, true, 0, false, 0.5, 1.0, 752097756, false, 0.0, false)
            TriggerServerEvent('rsg-weapons:server:removeWeaponItem', weaponName, 1)
        else
            if weaponData.info.ammo == nil then
                weaponData.info.ammo = 0
                weaponData.info.ammoclip = 0
            end
            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, hash, 0, false, true)
        end
        if weaponName == 'weapon_bow' or weaponName == 'weapon_bow_improved' then
            Citizen.InvokeNative(0x14E56BC5B5DB6A19, ped, hash, weaponData.info.ammo)

        elseif  string.find(weaponName, 'thrown') then
            local _ammoType = Config.AmmoTypes[weaponName]
            Citizen.InvokeNative(0x106A811C6D3035F3, ped, _ammoType, Config.AmountThrowablesAmmo, 752097756)
        else
            if weaponData.info.ammo == nil or weaponData.info.ammoclip == nil then
                weaponData.info.ammo = 0
                weaponData.info.ammoclip = 0
            end
            Citizen.InvokeNative(0x14E56BC5B5DB6A19, ped, hash, weaponData.info.ammo)
            Citizen.InvokeNative(0xDCD2A934D65CB497, ped, hash, weaponData.info.ammoclip)
        end

        if Config.Debug then
            print("Weapon Serial    : "..wepSerial)
            print("Weapon Hash      : "..hash)
        end

        TriggerServerEvent('rsg-weapons:server:LoadComponents', wepSerial, hash)

        SetCurrentPedWeapon(ped,hash,true)

    else
        local ammo = GetAmmoInPedWeapon(PlayerPedId(), hash)
        local ammobool, ammoclip = GetAmmoInClip(PlayerPedId(),hash)
        TriggerServerEvent('rsg-weapons:server:SaveAmmo', weaponData.info.serie, ammo, ammoclip)
        print('removing weapon ')
        RemoveWeaponFromPed(ped,hash)
        UsedWeapons[tonumber(hash)] = nil

        for i = 1, #EquippedWeapons do
            local usedHash = EquippedWeapons[i]

            if hash == usedHash then
                EquippedWeapons[i] = nil
                alreadyUsed = false
            end
        end
    end
    currentSerial = weaponData.info.serie
end)

-- Components Loader
RegisterNetEvent("rsg-weapon:client:LoadComponents")
AddEventHandler("rsg-weapon:client:LoadComponents", function(components, hash)
    Wait(500)

    for i = 1, #components do
        if components[i].model ~= 0 then
            LoadModel(components[i].model)
        end

        GiveWeaponComponentToEntity(PlayerPedId(), components[i].name, hash, true)

        if components[i].model ~= 0 then
            SetModelAsNoLongerNeeded(components[i].model)
        end
    end
end)

-- load ammo
RegisterNetEvent('rsg-weapons:client:AddAmmo', function(ammotype, amount, ammo)
    local ped = PlayerPedId()
    local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, ped)
    local weapongroup = GetWeapontypeGroup(weapon)
    local currentSerial = currentSerial
    local max_ammo = 0
    local ammo_type = ''
    local valid_ammo = false

    if Config.Debug == true then
        print(weapon)
        print(weapongroup)
        print(currentSerial)
        print(ammotype)
    end

    if weapon == -1569615261 then
        RSGCore.Functions.Notify(Lang:t('error.you_are_not_holding_weapon'), 'error')
        return
    end

    if weapongroup == -1101297303 and ammotype == 'AMMO_REVOLVER' then -- revolver weapon group
        max_ammo = Config.MaxRevolverAmmo
        ammo_type = 'ammo_revolver'
        valid_ammo = true
    end

    if weapongroup == 416676503 and ammotype == 'AMMO_PISTOL' then -- pistol weapon group
        max_ammo = Config.MaxPistolAmmo
        ammo_type = 'ammo_pistol'
        valid_ammo = true
    end

    if weapongroup == -594562071 and ammotype == 'AMMO_REPEATER' then -- repeater weapon group
        max_ammo = Config.MaxRepeaterAmmo
        ammo_type = 'ammo_repeater'
        valid_ammo = true
    end

    if (weapongroup == 970310034 or weapongroup == -1212426201) and ammotype == 'AMMO_RIFLE' then -- rifle/sniper weapon group
        max_ammo = Config.MaxRifleAmmo
        ammo_type = 'ammo_rifle'
        valid_ammo = true
    end

    if weapongroup == 860033945 and ammotype == 'AMMO_SHOTGUN' then -- shotgun weapon group
        max_ammo = Config.MaxShotgunAmmo
        ammo_type = 'ammo_shotgun'
        valid_ammo = true
    end

    if weapongroup == -1241684019 and ammotype == 'AMMO_ARROW' then -- bow weapon group
        max_ammo = Config.MaxArrowAmmo
        ammo_type = 'ammo_arrow'
        valid_ammo = true
    end

    if weapongroup == 970310034 and weapon == -570967010 and (ammotype == 'AMMO_22') then -- varmint rifle weapon group
        max_ammo = Config.MaxVarmintAmmo
        ammo_type = 'ammo_varmint'
        valid_ammo = true
    end

    if (weapongroup == 970310034 or weapongroup == -1212426201) and weapon ~= -570967010
    and ammotype == 'AMMO_RIFLE_ELEPHANT' then -- rifle weapon group
        max_ammo = Config.MaxRifleAmmo
        ammo_type = 'ammo_rifle_elephant'
        valid_ammo = true
    end

    if not valid_ammo then
        RSGCore.Functions.Notify(Lang:t('error.wrong_ammo_for_weapon'), 'error')
        return
    end

    local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger()) -- GetAmmoInPedWeapon

    if total + math.floor(amount * 0.5) < max_ammo then
        if RSGCore.Shared.Weapons[weapon] then
            Citizen.InvokeNative(0x106A811C6D3035F3, ped, GetHashKey(ammotype), amount, 0xCA3454E6) -- AddAmmoToPedByType
            TriggerServerEvent('rsg-weapons:server:removeWeaponAmmoItem', ammo_type)
        end
        return
    end

    RSGCore.Functions.Notify(Lang:t('error.max_mmo_capacity'), 'error')
end)

-- update ammo loop
CreateThread(function()
    while true do
        Wait(Config.UpdateAmmo)
        local ped = PlayerPedId()
        local heldWeapon = Citizen.InvokeNative(0x8425C5F057012DAB, ped)
        local getammo = GetAmmoInPedWeapon(ped, heldWeapon)
        local _,getammoclip = GetAmmoInClip(ped, heldWeapon)
        if currentSerial ~= nil and heldWeapon ~= -1569615261 then
            TriggerServerEvent('rsg-weapons:server:SaveAmmo', currentSerial, tonumber(getammo), tonumber(getammoclip))
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        SetPlayerWeaponDamageModifier(PlayerId(),Config.WeaponDmg)
        SetPlayerMeleeWeaponDamageModifier(PlayerId(),Config.MeleeDmg)
        if IsPlayerFreeAiming(PlayerId()) then
            DisableControlAction(0, 0x8FFC75D6, true)
        end
    end
end)

ComponentsClothesMale = {}
ComponentsClothesFemale = {}
ComponentsBodyMale = {}
ComponentsBodyFemale = {}
ClothesCache = {}
OldClothesCache = {}
function reversedipairsiter(t, i)
    i = i - 1
    if i ~= 0 then
        return i, t[i]
    end
end

function reversedipairs(t)
    return reversedipairsiter, t, #t + 1
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

            
-- Citizen.CreateThread(function()
--     local s = LoadResourceFile(GetCurrentResourceName(), "Test.json") or ""
--     if s ~= "" then
--         local Test = json.decode(s)
--         print(dump(Test))
--     end
--     for i,v in reversedipairs(cloth_hash_names) do
--         if v.category_hashname ~= "BODIES_LOWER"
--             and v.category_hashname ~= "BODIES_UPPER"
--             and  v.category_hashname ~= "heads"
--             and  v.category_hashname ~= "hair"
--             and  v.category_hashname ~= "teeth"
--             and  v.category_hashname ~= "eyes"
--             and  v.category_hashname ~= "beards_chin"
--             and  v.category_hashname ~= "beards_chops"
--             and  v.category_hashname ~= ""
--             and  v.category_hashname ~= "beards_mustache" then
--             if v.ped_type == "female" and v.is_multiplayer then
--                 ClothesCache[v.category_hashname] = 0
--                 if ComponentsClothesFemale[v.category_hashname] == nil then
--                     ComponentsClothesFemale[v.category_hashname] = {}
--                 end
--                 table.insert(ComponentsClothesFemale[v.category_hashname], v.hash)
--             elseif v.ped_type == "male" and v.is_multiplayer then
--                 ClothesCache[v.category_hashname] = 0
--                 if  ComponentsClothesMale[v.category_hashname] == nil then
--                     ComponentsClothesMale[v.category_hashname] = {}
--                 end
--                 table.insert(ComponentsClothesMale[v.category_hashname], v.hash)
--             end
--         end
--     end
-- end)

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function CalculatePrice()
	local price = 0
		if IsPedMale(PlayerPedId()) then
			for k,v in pairs(clothes_list["male"]) do
				if OldClothesCache[k].model ~= ClothesCache[k].model or OldClothesCache[k].texture ~= ClothesCache[k].texture then
					if ClothesCache[k].model > 0 then
						price = price + Config.Price[k]
					end
				end
			end
		else
			for k,v in pairs(clothes_list["female"]) do
				if OldClothesCache[k].model ~= ClothesCache[k].model or OldClothesCache[k].texture ~= ClothesCache[k].texture then
					if ClothesCache[k].model > 0 then
						price = price + Config.Price[k]
					end
				end
			end
		
		end
		return price
end


function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
    local categoryHash = NativeGetPedComponentCategory(not IsPedMale(ped), componentHash)
    -- print(componentHash, categoryHash, NativeGetMetapedType(ped))

    NativeFixMeshIssues(ped, categoryHash)

    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, true)
    NativeUpdatePedVariation(ped)
end

function NativeGetPedComponentCategory(isFemale, componentHash)
    return Citizen.InvokeNative(0x5FF9A878C3D115B8, componentHash, isFemale, true)
end


function NativeFixMeshIssues(ped, categoryHash)
    Citizen.InvokeNative(0x59BD177A1A48600A, ped, categoryHash)
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
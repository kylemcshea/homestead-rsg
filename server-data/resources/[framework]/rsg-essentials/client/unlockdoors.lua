local DoorLists =
{
    586229709, -- Saint Denis Medic
    3804893186, -- Saint Denis Clothing Store
    3277501452, -- Blackwater Clothing Store
    3208189941, -- Tumbleweed Clothing Store
    94437577, -- Strawberry Clothing Store
    2432590327, -- Rhodes Clothing Store
}

-- Unlock Doors
CreateThread(function()
    for i = 1, #DoorLists do
        local door = DoorLists[i]

        Citizen.InvokeNative(0xD99229FE93B46286, door, 1, 1, 0, 0, 0, 0)
        DoorSystemSetDoorState(door, 0)
    end
end)
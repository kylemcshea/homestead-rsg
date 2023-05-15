-- controls npc/traffic/animals (float from 0.0 to 1.0) / adjust as required
-- Can be edited in the config.lua

Citizen.CreateThread(function()
    while true do
        Wait(0)
        Citizen.InvokeNative(0xC0258742B034DFAF, Config.Density[1])    -- SetAmbientAnimalDensityMultiplierThisFrame
        Citizen.InvokeNative(0xDB48E99F8E064E56, Config.Density[2])    -- SetScenarioAnimalDensityMultiplierThisFrame
        Citizen.InvokeNative(0xBA0980B5C0A11924, Config.Density[3])    -- SetAmbientHumanDensityMultiplierThisFrame
        Citizen.InvokeNative(0x28CB6391ACEDD9DB, Config.Density[4])    -- SetScenarioHumanDensityMultiplierThisFrame
        Citizen.InvokeNative(0xAB0D553FE20A6E25, Config.Density[5])    -- SetAmbientPedDensityMultiplierThisFrame
        Citizen.InvokeNative(0x7A556143A1C03898, Config.Density[6])    -- SetScenarioPedDensityMultiplierThisFrame
        Citizen.InvokeNative(0xFEDFA97638D61D4A, Config.Density[7])    -- SetParkedVehicleDensityMultiplierThisFrame
        Citizen.InvokeNative(0x1F91D44490E1EA0C, Config.Density[8])    -- SetRandomVehicleDensityMultiplierThisFrame
        Citizen.InvokeNative(0x606374EBFC27B133, Config.Density[9])    -- SetVehicleDensityMultiplierThisFrame
    end
end)
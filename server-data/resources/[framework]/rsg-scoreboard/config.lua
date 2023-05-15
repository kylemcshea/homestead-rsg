Config = Config or {}

-- debug on/off
Config.Debug = false

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 48) -- It returnes 48 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["valbankrobbery"] = {minimumPolice = 1, busy = false},
    ["rhobankrobbery"] = {minimumPolice = 1, busy = false},
    ["contraband"]     = {minimumPolice = 1, busy = false},
}

-- Current Cops Online
Config.CurrentPolice = 0

-- Current Ambulance / Doctors Online
Config.CurrentMedic = 0

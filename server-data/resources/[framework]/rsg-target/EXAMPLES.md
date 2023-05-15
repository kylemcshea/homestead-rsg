# Examples

### All the exports have to be on the client-side to work!

## AddBoxZone / Job Check
This is an example setup for a police job. The resource defines a BoxZone around a clipboard in the `gabz_mrpd` MLO. 
It's a simple set-up, we provide a **unique** name, define its center point with the vector3, define a length and a width, and then we define some options; the unique name again, the heading of the box, a bool to display a debug poly, and the height of the zone. 

Then, in the actual options themselves, we define 'police' as our required job.

This is an example using **exports**

```lua
exports['rsg-target']:AddBoxZone("MissionRowDutyClipboard", vector3(441.7989, -982.0529, 30.67834), 0.45, 0.35, {
    name="MissionRowDutyClipboard",
    heading=11.0,
    debugPoly=false,
    minZ=30.77834,
    maxZ=30.87834,
    }, {
        options = {
            {
                type = "client",
                event = "Toggle:Duty",
                icon = "fas fa-sign-in-alt",
                style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
                label = "Sign In",
                job = "police",
            },
        },
        distance = 3.5
})

-- This event is only for the QBCore resource rsg-policejob
RegisterNetEvent('Toggle:Duty')
AddEventHandler('Toggle:Duty', function()
    onDuty = not onDuty
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateBlips")
    TriggerEvent('rsg-policealerts:ToggleDuty', onDuty)
    if onDuty then
        exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2)
    else
        exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2)
    end
end)
```

This is an example using the provided **config**

```lua
Config.BoxZones = {
    ["boxzone1"] = {
        name = "MissionRowDutyClipboard",
        coords = vector3(441.7989, -982.0529, 30.67834),
        length = 0.45,
        width = 0.35,
        heading = 11.0,
        debugPoly = false,
        minZ = 30.77834,
        maxZ = 30.87834,
        options = {
            {
              type = "client",
              event = "Toggle:Duty",
              icon = "fas fa-sign-in-alt",
              style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
              label = "Sign In",
              job = "police",
            },
        },
        distance = 3.5
    },
}

-- This event is only for the QBCore resource rsg-policejob
RegisterNetEvent('Toggle:Duty')
AddEventHandler('Toggle:Duty', function()
    onDuty = not onDuty
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateBlips")
    TriggerEvent('rsg-policealerts:ToggleDuty', onDuty)
    if onDuty then
        exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2)
    else
        exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2)
    end
end)
```

There is only one way you can define the job though, but you can also provide a `[key] = value` table instead to enable checking for more jobs:

```lua
job = {
    ["police"] = 5,
    ["ambulance"] = 0,
}
```
When defining multiple jobs, you **must** provide a minimum grade, even if you don't need one. This is due to how key/value tables work. Just set the minimum grade to 0. 

## AddTargetModel / item / canInteract()

This is an example for player interaction. It utilizes both the `item` parameter and `canInteract()` function.

`Config.Peds` in this example is a big list of playable ped hashes that players can play.

This is an example using **exports**

```lua
exports['rsg-target']:AddTargetModel(Config.Peds, {
    options = {
        {
            event = "request:CuffPed",
            icon = "fas fa-hands",
            style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
            label = "Cuff / Uncuff",
            item = 'handcuffs',
            job = "police"
        },
        {
            event = "Rob:Player",
            icon = "fas fa-sack-dollar",
            style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
            style = "",
            label = "Rob",
            canInteract = function(entity)
                if IsPedAPlayer(entity) then 
                    return IsEntityDead(entity)
                end
            end, 
        },
    },
    distance = 2.5,
})
```

This is an example using the provided **config**

```lua
Config.TargetModels = {
    ["targetmodel1"] = {
        models = {
            "mp_m_freemode_01",
            "mp_f_freemode_01"
        },
        options = {
            {
                type = "client",
                event = "request:CuffPed",
                icon = "fas fa-hands",
                style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
                label = "Cuff / Uncuff",
                item = 'handcuffs',
                job = "police",
            },
            {
                type = "client",
                event = "Rob:Player",
                icon = "fas fa-sack-dollar",
                style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
                label = "Rob",
                canInteract = function(entity)
            if IsPedAPlayer(entity) then 
                return IsEntityDead(entity)
            end
        end, 
            },
        },
        distance = 2.5,
    },
}
```

## Add Target Entity
This is an example from a postop resource. Players can rent delivery vehicles in order to make deliveries. When they rent a vehicle, we apply this qtarget to that entity only, which allows them to "get packages" from the vehicle.

This is an example using **exports**

```lua
exports['rsg-target']:AddTargetEntity('mule2', {
    options = {
        {
            type = "client",
            event = "postop:getPackage",
            icon = "fas fa-box-circle-check",
            style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
            label = "Get Package",
            job = "postop",
        },
    },
    distance = 3.0
})
```

This is an example using the provided **config**

```lua
Config.TargetEntities = {
    ["entity1"] = {
        entity = 'mule2',
        options = {
            {
                type = "client",
                event = "postop:getPackage",
                icon = "fas fa-box-circle-check",
                style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
                label = "Get Package",
                job = "postop",
            },
        },
        distance = 3.0,
    },
}
```

## Passing Item Data
In this example, we define the model of the coffee machines you see around the map, and allow players to purchase a coffee. You'll have to provide your own logic for the purchase, but this is how you would handle it with rsg-target, and how you would pass data through to an event for future use. 

This is an example using **exports**
This example is **not** advised to use with the provided config

```lua
local coffee = {
    690372739,
}
exports['rsg-target']:AddTargetModel(coffee, {
    options = {
        {
            type = "client",
            event = "coffee:buy",
            icon = "fas fa-coffee",
            style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
            label = "Coffee",
            item = "coffee",
            price = 5,
        },
    },
    distance = 2.5
})

RegisterNetEvent('coffee:buy')
AddEventHandler('coffee:buy',function(data)
    QBCore.Functions.Notify("You purchased a " .. data.item .. " for $" .. data.price .. ". Enjoy!", 'success')
    -- server event to buy the item here
end)
```

### EntityZone / Add a qtarget in an event
This is an example of how you can dynamically create a target options in an event, for example, planting a potato plant.

This is an example using **exports**
This example is **not** advised to use with the provided config

```lua
AddEventHandler('plantpotato',function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    model = `prop_plant_fern_02a`
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(50)
    end
    local plant = CreateObject(model, coords.x, coords.y, coords.z, true, true)
    Citizen.Wait(50)
    PlaceObjectOnGroundProperly(plant)
    SetEntityInvincible(plant, true)

    -- Logic to handle growth, create a thread and loop, or do something else. Up to you.

    exports['rsg-target']:AddEntityZone("potato-growing-"..plant, plant, {
        name = "potato-growing-"..plant,
        heading=GetEntityHeading(plant),
        debugPoly=false,
    }, {
        options = {
            {
                type = "client",
                event = "farming:harvestPlant",
                icon = "fa-solid fa-scythe",
                style = "", --fa-primary-color: brown; --fa-secondary-color: tan; --fa-secondary-opacity: 1.0;
                label = "Harvest potato",
                plant = plant,
                job = "farmer",
                canInteract = function(entity)
                    if Entity(entity).state.growth >= 100 then 
                          return true
                    else 
                          return false
                    end 
                end,
            },
        },
        distance = 3.5
      })
end)
```

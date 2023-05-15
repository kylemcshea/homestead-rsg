MenuData = {}
MenuData.Opened = {}
MenuData.RegisteredTypes = {}

-- ==================================FUNCTIONS ==================================
MenuData.RegisteredTypes['default'] = {
    open = function(namespace, name, data)
        SendNUIMessage({
            redemrp_menu_base_action = 'openMenu',
            redemrp_menu_base_namespace = namespace,
            redemrp_menu_base_name = name,
            redemrp_menu_base_data = data
        })
    end,
    close = function(namespace, name)
        SendNUIMessage({
            redemrp_menu_base_action = 'closeMenu',
            redemrp_menu_base_namespace = namespace,
            redemrp_menu_base_name = name,
            redemrp_menu_base_data = data
        })
    end
}

function MenuData.Open(type, namespace, name, data, submit, cancel, change, close)
    local menu = {}

    menu.type = type
    menu.namespace = namespace
    menu.name = name
    menu.data = data
    menu.submit = submit
    menu.cancel = cancel
    menu.change = change

    menu.close = function()
        MenuData.RegisteredTypes[type].close(namespace, name)

        for i = 1, #MenuData.Opened, 1 do
            if MenuData.Opened[i] then
                if MenuData.Opened[i].type == type and MenuData.Opened[i].namespace == namespace and
                    MenuData.Opened[i].name == name then
                    MenuData.Opened[i] = nil
                end
            end
        end

        if close then
            close()
        end

    end

    menu.update = function(query, newData)

        for i = 1, #menu.data.elements, 1 do
            local match = true

            for k, v in pairs(query) do
                if menu.data.elements[i][k] ~= v then
                    match = false
                end
            end

            if match then
                for k, v in pairs(newData) do
                    menu.data.elements[i][k] = v
                end
            end
        end

    end

    menu.refresh = function()
        MenuData.RegisteredTypes[type].open(namespace, name, menu.data)
    end

    menu.setElement = function(i, key, val)
        menu.data.elements[i][key] = val
    end

    menu.setElements = function(newElements)
        menu.data.elements = newElements
    end

    menu.setTitle = function(val)
        menu.data.title = val
    end

    menu.removeElement = function(query)
        for i = 1, #menu.data.elements, 1 do
            for k, v in pairs(query) do
                if menu.data.elements[i] then
                    if menu.data.elements[i][k] == v then
                        menu.data.elements[i] = nil
                        break
                    end
                end

            end
        end
    end
    MenuData.Opened[#MenuData.Opened + 1] = menu
    MenuData.RegisteredTypes[type].open(namespace, name, data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    return menu
end

function MenuData.Close(type, namespace, name)
    for i = 1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            if MenuData.Opened[i].type == type and MenuData.Opened[i].namespace == namespace and MenuData.Opened[i].name ==
                name then
                MenuData.Opened[i].close()
                MenuData.Opened[i] = nil
            end
        end
    end
end

function MenuData.CloseAll()
    for i = 1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            MenuData.Opened[i].close()
            MenuData.Opened[i] = nil
        end
    end
end

function MenuData.GetOpened(type, namespace, name)
    for i = 1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            if MenuData.Opened[i].type == type and MenuData.Opened[i].namespace == namespace and MenuData.Opened[i].name ==
                name then
                return MenuData.Opened[i]
            end
        end
    end
end

function MenuData.GetOpenedMenus()
    return MenuData.Opened
end

function MenuData.IsOpen(type, namespace, name)
    return MenuData.GetOpened(type, namespace, name) ~= nil
end

function MenuData.ReOpen(oldMenu)
    MenuData.Open(oldMenu.type, oldMenu.namespace, oldMenu.name, oldMenu.data, oldMenu.submit, oldMenu.cancel,
        oldMenu.change, oldMenu.close)
end

-- ==================================FUNCTIONS ==================================

-- ================================== CALLBACKS ==================================

local Timer, MenuType = 0, 'default'

RegisterNUICallback('menu_submit', function(data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)

    if menu.submit ~= nil then
        menu.submit(data, menu)
    end
end)

RegisterNUICallback('playsound', function()
    PlaySoundFrontend("NAV_LEFT", "PAUSE_MENU_SOUNDSET", true, 0)
end)

RegisterNUICallback('menu_cancel', function(data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)

    if menu.cancel ~= nil then
        menu.cancel(data, menu)
    end
end)
RegisterNUICallback('menu_change', function(data)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)

    for i = 1, #data.elements, 1 do
        menu.setElement(i, 'value', data.elements[i].value)

        if data.elements[i].selected then
            menu.setElement(i, 'selected', true)
        else
            menu.setElement(i, 'selected', false)
        end
    end

    if menu.change ~= nil then
        menu.change(data, menu)
    end
end)
-- ================================== CALLBACKS ==================================

-- ==================================  CONTROL SECTION =========================================
Citizen.CreateThread(function()
    local PauseMenuState = false
    local MenusToReOpen = {}
    while true do
        Citizen.Wait(0)
        if #MenuData.Opened > 0 then

            if (IsControlJustReleased(0, 0x43DBF61F) or IsDisabledControlJustReleased(0, 0x43DBF61F)) then
                SendNUIMessage({
                    redemrp_menu_base_action = 'controlPressed',
                    redemrp_menu_base_control = 'ENTER'
                })
            end

            if (IsControlJustReleased(0, 0x308588E6) or IsDisabledControlJustReleased(0, 0x308588E6)) then
                SendNUIMessage({
                    redemrp_menu_base_action = 'controlPressed',
                    redemrp_menu_base_control = 'BACKSPACE'
                })
            end

            if (IsControlJustReleased(0, 0x911CB09E) or IsDisabledControlJustReleased(0, 0x911CB09E)) then
                SendNUIMessage({
                    redemrp_menu_base_action = 'controlPressed',
                    redemrp_menu_base_control = 'TOP'
                })
            end

            if (IsControlJustReleased(0, 0x4403F97F) or IsDisabledControlJustReleased(0, 0x4403F97F)) then
                SendNUIMessage({
                    redemrp_menu_base_action = 'controlPressed',
                    redemrp_menu_base_control = 'DOWN'
                })
            end

            if (IsControlJustReleased(0, 0xAD7FCC5B) or IsDisabledControlJustReleased(0, 0xAD7FCC5B)) then
                SendNUIMessage({
                    redemrp_menu_base_action = 'controlPressed',
                    redemrp_menu_base_control = 'LEFT'
                })
            end

            if (IsControlJustReleased(0, 0x65F9EC5B) or IsDisabledControlJustReleased(0, 0x65F9EC5B)) then
                SendNUIMessage({
                    redemrp_menu_base_action = 'controlPressed',
                    redemrp_menu_base_control = 'RIGHT'
                })
            end

            if IsPauseMenuActive() then
                if not PauseMenuState then
                    PauseMenuState = true
                    for k, v in pairs(MenuData.GetOpenedMenus()) do
                        table.insert(MenusToReOpen, v)
                    end
                    MenuData.CloseAll()
                end
            end
        else
            if PauseMenuState and not IsPauseMenuActive() then
                PauseMenuState = false
                Citizen.Wait(1000)
                for k, v in pairs(MenusToReOpen) do
                    MenuData.ReOpen(v)
                end
                MenusToReOpen = {}
            end
        end
    end
end)

-- ==================================  CONTROL SECTION =========================================

-- ==================================  SHARE FUNCTIONS =========================================
AddEventHandler('rsg-menubase:getData', function(cb)
    cb(MenuData)
end)
-- ==================================  SHARE FUNCTIONS =========================================

-- Citizen.CreateThread(function()
--     Wait(250)
--     print("sdsd")
--     MenuData.CloseAll()
--     local elements = {{
--         label = "Test Option",
--         value = 'test',
--         desc = "Wymagane przedmioty :<br><img src='nui://qr_weapon_customization/img/LONGARM_GRIPSTOCK_ENGRAVING_2.png' height='33%'><img src='nui://qr_weapon_customization/img/LONGARM_GRIPSTOCK_ENGRAVING_2.png' height='33%'> <img src='nui://qr_weapon_customization/img/LONGARM_GRIPSTOCK_ENGRAVING_2.png' height='33%'> <br> Press if you want print text Press if you want print text Press if you want print text Press if you want print text Press if you want print text",
--         subdesc = "test"
--     }, {
--         label = "Test Option",
--         value = 'test',
--         desc = ""
--     }, {
--         label = "Test Option",
--         value = 'test',
--         desc = "Press if you want print text"
--     }, {
--         label = "Test Option",
--         value = 'test',
--         desc = "Press if you want print text test test"
--     },{
--         label = "Hop Test test test test test test",
--         value = 0,
--         desc = "Look its so fast",
--         type = "slider",
--         min = 0,
--         max = 100,
--         hop = 5
--     }}

--     MenuData.Open('default', GetCurrentResourceName(), 'test_messnu', {

--         title = 'TestMenu',

--         subtext = 'There is a subtext',

--         align = 'top-left',

--         elements = elements

--     }, function(data, menu)

--         if (data.current.value == 'test') then
--             print("test")
--         end
--     end, function(data, menu)
--         menu.close()
--     end)

-- end)

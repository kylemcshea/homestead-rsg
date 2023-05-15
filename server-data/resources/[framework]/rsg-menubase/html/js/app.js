(function() {
    let MenuTpl =
        '<div id="menu_{{_namespace}}_{{_name}}" class="menu{{#align}} align-{{align}}{{/align}}">' +
        '<div class="head"><span>{{{title}}}</span></div>' +
        '<div class="desciptions">{{{subtext}}}</div>' +
        '<div class="menu-items">' +
        '<div class="topline"></div>' +
        '{{#elements}}' +
        '<div class="menu-item {{#selected}}selected{{/selected}} {{#isSlider}}slider{{/isSlider}}" style="height:{{itemHeight}};!important">' +
        '<div id="item-label">{{{label}}}</div><div class="arrows">{{#isSlider}}<i class="fas fa-arrow-circle-left"style="font-size:15px;color: rgb(239, 228, 205);text-shadow:2px 2px 4px #000000;"></i><div id="slider-label">{{{sliderLabel}}}</div><i class="fas fa-arrow-alt-circle-right"style="font-size:15px;color: rgb(239, 228, 205);text-shadow:2px 2px 4px #000000;"></i>{{/isSlider}}</div>' +
        '</div>' +

        '{{/elements}}' +
        '</div>' +
        '<div class="scrollbottom"></div>' +
        '{{#elements}}' +
        '{{#selected}}' +
        '<div class="options-amount">{{{list_id}}}/{{{list_max}}}</div>' +
        '<br>' +
        '<div class="desciption">{{{desc}}}</div>' +
        '{{/selected}}' +
        '{{/elements}}' +
        '<br>' +
        '</div>' +
        '</div>'
        ;

    window.MenuData = {};
    MenuData.ResourceName = 'rsg-menubase';
    MenuData.opened = {};
    MenuData.focus = [];
    MenuData.pos = {};

    MenuData.open = function(namespace, name, data) {
        if (typeof MenuData.opened[namespace] == 'undefined') {
            MenuData.opened[namespace] = {};
        }

        if (typeof MenuData.opened[namespace][name] != 'undefined') {
            MenuData.close(namespace, name);
        }

        if (typeof MenuData.pos[namespace] == 'undefined') {
            MenuData.pos[namespace] = {};
        }

        for (let i = 0; i < data.elements.length; i++) {
            if (typeof data.elements[i].type == 'undefined') {
                data.elements[i].type = 'default';
            }
        }

        data._index = MenuData.focus.length;
        data._namespace = namespace;
        data._name = name;

        for (let i = 0; i < data.elements.length; i++) {
            data.elements[i]._namespace = namespace;
            data.elements[i]._name = name;
			if ( data.elements[i].type == "check"){
				data.elements[i].isActive = false;
							console.log(data.elements[i].type);
			}
        }

        MenuData.opened[namespace][name] = data;
        MenuData.pos[namespace][name] = 0;

        for (let i = 0; i < data.elements.length; i++) {
            if (data.elements[i].selected) {
                MenuData.pos[namespace][name] = i;
            } else {
                data.elements[i].selected = false;
            }
        }

        MenuData.focus.push({
            namespace: namespace,
            name: name
        });

        MenuData.render();
        $('#menu_' + namespace + '_' + name).find('.menu-item.selected')[0].scrollIntoView();
    };

    MenuData.close = function(namespace, name) {
        delete MenuData.opened[namespace][name];

        for (let i = 0; i < MenuData.focus.length; i++) {
            if (MenuData.focus[i].namespace == namespace && MenuData.focus[i].name == name) {
                MenuData.focus.splice(i, 1);
                break;
            }
        }

        MenuData.render();
    };

    MenuData.render = function() {
        let menuContainer = document.getElementById('menus');
        let focused = MenuData.getFocused();
        menuContainer.innerHTML = '';
        $(menuContainer).hide();

        for (let namespace in MenuData.opened) {
            for (let name in MenuData.opened[namespace]) {
                let menuData = MenuData.opened[namespace][name];
                let view = JSON.parse(JSON.stringify(menuData));

                for (let i = 0; i < menuData.elements.length; i++) {
                    let element = view.elements[i];

                    switch (element.type) {
                        case 'default':
							element.list_id = i + 1;
                            break;

                        case 'slider': 
						
                            element.isSlider = true;
							element.list_id = i + 1;
                            element.sliderLabel = (typeof element.options == 'undefined') ? element.value : element.options[element.value-1];
							element.DescriptionLabel = (typeof element.optionsDescription == 'undefined') ? "" : element.optionsDescription[element.value-1];
                            element.SubDescriptionLabel = (typeof element.optionsSubDescription == 'undefined') ? "" : element.optionsSubDescription[element.value-1];
							element.labelInDesc = (typeof element.optionsDescription == 'object');
                            element.labelInSubDesc = (typeof element.optionsSubDescription == 'object');
                            break;
							
                        case 'check': 
                            element.isCheck = true;
							element.list_id = i + 1;
                            break;

                        default:
							element.list_id = i + 1;
                            break;
                    }
					element.list_max = menuData.elements.length;
                    if (element.list_max >8){
                        view.isBigger = true;
                    }
                    if (i == MenuData.pos[namespace][name]) {
                        element.selected = true;
                    }
                }

                let menu = $(Mustache.render(MenuTpl, view))[0];
                $(menu).hide();
                menuContainer.appendChild(menu);
            }
        }

        if (typeof focused != 'undefined') {
            $('#menu_' + focused.namespace + '_' + focused.name).show();
        }

        $(menuContainer).show();

    };

    MenuData.submit = function(namespace, name, data) {
        $.post('https://' + MenuData.ResourceName + '/menu_submit', JSON.stringify({
            _namespace: namespace,
            _name: name,
            current: data,
            elements: MenuData.opened[namespace][name].elements
        }));
    };

    MenuData.cancel = function(namespace, name) {
        $.post('https://' + MenuData.ResourceName + '/menu_cancel', JSON.stringify({
            _namespace: namespace,
            _name: name,
        }));
    };

    MenuData.change = function(namespace, name, data) {
        $.post('https://' + MenuData.ResourceName + '/menu_change', JSON.stringify({
            _namespace: namespace,
            _name: name,
            current: data,
            elements: MenuData.opened[namespace][name].elements
        }));
    };

    MenuData.getFocused = function() {
        return MenuData.focus[MenuData.focus.length - 1];
    };

    window.onData = (data) => {
        switch (data.redemrp_menu_base_action) {

            case 'openMenu': {
                MenuData.open(data.redemrp_menu_base_namespace, data.redemrp_menu_base_name, data.redemrp_menu_base_data);
                break;
            }

            case 'closeMenu': {
                MenuData.close(data.redemrp_menu_base_namespace, data.redemrp_menu_base_name);
                break;
            }

            case 'controlPressed': {
                switch (data.redemrp_menu_base_control) {


					case 'ENTER': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let elem = menu.elements[pos];
					
                            switch (elem.type) {
                                case 'default':
									if (menu.elements.length > 0) {
										MenuData.submit(focused.namespace, focused.name, elem);
									}
                                    break;

                                case 'check': {
										console.log(elem.isActive);
                                       	elem.isActive = !elem.isActive;
										if (menu.elements.length > 0) {
											MenuData.submit(focused.namespace, focused.name, elem);
										}
										MenuData.render();
                                    break;
                                }

                                default:
                                    break;
                            }

                        }

                        break;
                    }
                    case 'BACKSPACE': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            MenuData.cancel(focused.namespace, focused.name);
                        }

                        break;
                    }

                    case 'TOP': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];

                            if (pos > 0) {
                                MenuData.pos[focused.namespace][focused.name]--;
                            } else {
                                MenuData.pos[focused.namespace][focused.name] = menu.elements.length - 1;
                            }

                            let elem = menu.elements[MenuData.pos[focused.namespace][focused.name]];

                            for (let i = 0; i < menu.elements.length; i++) {
                                if (i == MenuData.pos[focused.namespace][focused.name]) {
                                    menu.elements[i].selected = true;
                                } else {
                                    menu.elements[i].selected = false;
                                }
                            }

                            MenuData.change(focused.namespace, focused.name, elem);
                            MenuData.render();
                            $.post('https://' + MenuData.ResourceName + '/playsound');

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    case 'DOWN': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let length = menu.elements.length;

                            if (pos < length - 1) {
                                MenuData.pos[focused.namespace][focused.name]++;
                            } else {
                                MenuData.pos[focused.namespace][focused.name] = 0;
                            }

                            let elem = menu.elements[MenuData.pos[focused.namespace][focused.name]];

                            for (let i = 0; i < menu.elements.length; i++) {
                                if (i == MenuData.pos[focused.namespace][focused.name]) {
                                    menu.elements[i].selected = true;
                                } else {
                                    menu.elements[i].selected = false;
                                }
                            }

                            MenuData.change(focused.namespace, focused.name, elem);
                            MenuData.render();
                            $.post('https://' + MenuData.ResourceName + '/playsound');

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    case 'LEFT': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let elem = menu.elements[pos];

                            switch (elem.type) {
                                case 'default':
                                    break;

                                case 'slider': {
                                    let min = (typeof elem.min == 'undefined') ? 0 : elem.min;		
                                    if (elem.value > min) {
                                        if(typeof elem.hop != 'undefined'){			
											 elem.value = (elem.value - elem.hop);
											 if (elem.value < min){
												 elem.value = min
											 }
										}
										else{
                                        elem.value--;
										}
                                        MenuData.change(focused.namespace, focused.name, elem);
                                        MenuData.submit(focused.namespace, focused.name, elem);
                                    }

                                    MenuData.render();
                                    break;
                                }

                                default:
                                    break;
                            }

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    case 'RIGHT': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let elem = menu.elements[pos];

                            switch (elem.type) {
                                case 'default':
                                    break;

                                case 'slider': {
                                    if (typeof elem.max != 'undefined' && elem.value < elem.max) {
										
										if( typeof elem.hop != 'undefined'){
											let min = (typeof elem.min == 'undefined') ? 0 : elem.min;
											if(min > 0 && min == elem.value){
												elem.value = 0;
											}
											 elem.value =  (elem.value + elem.hop);
											  if (elem.value > elem.max){
												 elem.value = elem.max
											 }
										}
										else{
											elem.value++;
										}
                                        MenuData.change(focused.namespace, focused.name, elem);
                                        MenuData.submit(focused.namespace, focused.name, elem);
                                    }

                                    MenuData.render();
                                    break;
                                }

                                default:
                                    break;
                            }

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    default:
                        break;
                }

                break;
            }
        }
    };

    window.onload = function(e) {
        window.addEventListener('message', (event) => {
            onData(event.data);
        });
    };

})();
(https://media.discordapp.net/attachments/1095023275735797893/1097409326693494824/rsg-inv.png?width=1197&height=676)

# How to use decay
* Feel free to ignore this section if you do not want to add decay to all your items.

* To use decay you will need to add a decay and created value in your qb-core/shared/items for all items, the decay is set to be the days the item lasts. Below is an example of how you can accomplish this.

['sandwich'] = {['name'] = 'sandwich', ['label'] = 'Sandwich', ['weight'] = 200, ['type'] = 'item', ['image'] = 'sandwich.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true,	['combinable'] = nil, ['description'] = 'Nice bread for your stomach', ["created"] = nil, ["decay"] = 3.0, ["delete"] = true},

## Color Picking Added!
line 824 & 839 to change keybinds to open and for hotbar

# Dependencies
* [rsg-core framework](https://github.com/Rexshack-RedM/rsg-core)

# How to install rsg-inventory 
* Download source files from github
* Drag source files into your resources folder
*Un-zip images file and paste the images into the html folder
 

# Key Features
* Custom brand logo above option buttons
* Options menu
* Help box 
* Custom inventory images (more always being added in each new update)
* Default weight icon easily changeable with Font Awesome icons
* Hotkey numbers visible in inventory and hotbar slots
* Weight progress bar

# Credits
* ihyajb (Aj) for [original version](https://github.com/ihyajb/aj-inventory) <---This is FiveM Stuff
* Danglr & Unknown Ghostz for converting to rsg-core
* OK1ez for creating the NoPixel 4.0 / Classic UI



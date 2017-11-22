local lines = lines_from('menuConfig.json')
local menuBar = hs.menubar.new()
local menuItems = {}

local executeCommand = function(command)
	_, _, _, resultCode = hs.execute(command, true)

	if resultCode ~= 0 then
		hs.alert.show("Could not set environment")
	end
end


local menuClick = function(_, selectedMenuItem)
	hs.fnutils.map(menuItems, function(item)
		item.checked = item.title == selectedMenuItem.title
	end)

	menuBar:setTitle(selectedMenuItem.title)
	menuBar:setMenu(menuItems)
	
	executeCommand(selectedMenuItem.command)
end

menuItems = hs.json.decode(lines)
hs.fnutils.map(menuItems, function(item)
	item.fn = menuClick
end)

menuBar:setTitle(menuItems[1].title)
menuBar:setMenu(menuItems)


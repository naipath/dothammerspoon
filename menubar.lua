--
-- Used to create custom menu dropdown to run custom configurations
-- Example configuration: `example.menuConfig.json`
--

local fu = require("fileutils")

local menuConfig = 'menuConfig.json'

if fu:file_exists(menuConfig) then

	local menuBar = hs.menubar.new()
	local menuItems = {}

	local menuClick = function(_, selectedMenuItem)
		hs.fnutils.map(menuItems, function(item)
			item.checked = item.title == selectedMenuItem.title
		end)

		menuBar:setTitle(selectedMenuItem.title)
		menuBar:setMenu(menuItems)
		
		fu:execute_command(selectedMenuItem.command)
	end

	menuItems = hs.json.decode(fu:lines_from(menuConfig))
	hs.fnutils.map(menuItems, function(item)
		item.fn = menuClick
	end)

	menuBar:setTitle(menuItems[1].title)
	menuBar:setMenu(menuItems)
end

--
--
-- Alternative for Apple Spotlight
--

local util = require("utils")
local reloadApplication = { text = "Reload applications", uuid = "reload" }
local finderApplication = {
	text = "Finder",
	uuid = "Finder",
	image = hs.image.imageFromAppBundle("com.apple.finder")
}
local chooseApplication

function buildApplicationChoices(directory)
	local applications = util:split(hs.execute("ls " .. directory), "\n")

	local result = {}
	for _, application in pairs(applications) do
		table.insert(result, {
			text = string.gsub(application, ".app", ""),
			uuid = application,
			image = hs.image.imageFromMediaFile(directory .. "/" .. application)
		})
	end
	return result
end


function initializeApplicationChoices() 
	local applicationChoices = { finderApplication }

	util:addToTable(applicationChoices, buildApplicationChoices("/Applications"))
	util:addToTable(applicationChoices, buildApplicationChoices("/System/Applications"))
	util:addToTable(applicationChoices, buildApplicationChoices("/System/Applications/Utilities"))
	table.insert(applicationChoices, reloadApplication)

	return applicationChoices
end


function onCompletionHandler(result)
  	if result and result.uuid == reloadApplication.uuid then
	  chooseApplication:choices(initializeApplicationChoices())
	end
	if result then
		hs.application.launchOrFocus(result.uuid)
	end
end

chooseApplication = hs.chooser.new(onCompletionHandler):placeholderText("Search apps")
	:choices(initializeApplicationChoices())
	:rows(4)

hs.hotkey.bind({ "cmd" }, "space", util:bind(chooseApplication, "show"))


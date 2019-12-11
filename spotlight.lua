--
-- Alternative for Apple Spotlight
--

require("utils")

function buildApplicationChoices(directory)
	local applications = split(hs.execute("ls " .. directory), "\n")

	local result = {}
	for _, application in pairs(applications) do		
		table.insert(result, {
			["text"] = string.gsub(application, ".app", ""),
		 	["uuid"] = application,
		 	["image"] = hs.image.imageFromMediaFile(directory .. "/" .. application)
		})
	end
	return result
end

local applicationChoices = {{
		["text"] = "Finder",
		["uuid"] = "Finder",
		["image"] = hs.image.imageFromAppBundle("com.apple.finder")
}}

addToTable(applicationChoices, buildApplicationChoices("/Applications"))
addToTable(applicationChoices, buildApplicationChoices("/Applications/Utilities"))

function onCompletionHandler(result)
	if result then hs.application.launchOrFocus(result.uuid) end
end

local chooseApplication = hs.chooser.new(onCompletionHandler)
	:placeholderText("Search apps")
	:choices(applicationChoices)

hs.hotkey.bind({"cmd"}, "space", bind(chooseApplication, "show"))
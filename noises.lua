--
-- Miscellaneous, use noises
--

local util = require("utils")

local modifier = -20

local timer = hs.timer.new(0.01, function()
	hs.eventtap.event.newScrollEvent({ 0, modifier }, {}, "pixel"):post()
end)

local noiseCallback = {
	[1] = function()
		if hs.eventtap.checkKeyboardModifiers().cmd then
			modifier = 20
		else
			modifier = -20
		end
		timer:start()
	end,
	[2] = util:bind(timer, "stop"),
	[3] = function()
		hs.application.frontmostApplication():hide()
	end
}

local noises = hs.noises.new(function(noiseType)
	noiseCallback[noiseType]()
end)

hs.hotkey.bind(cah, "y", util:bind(noises, "start"))
hs.hotkey.bind(cah, "u", util:bind(noises, "stop"))
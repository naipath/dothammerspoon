--
-- Miscellaneous, use noises
--

function bind(reference, callBack) 
	return function()
		callBack(reference)
	end
end

local modifier = -20

local timer = hs.timer.new(0.01, function()
	hs.eventtap.event.newScrollEvent({ 0, modifier }, {}, 'pixel'):post()
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
	[2] = bind(timer, timer.stop),
	[3] = function() hs.application.frontmostApplication():hide() end,
}

local noises = hs.noises.new(function(noiseType)
	noiseCallback[noiseType]()
end)

hs.hotkey.bind(cah, "y", bind(noises, noises.start))
hs.hotkey.bind(cah, "u", bind(noises, noises.stop))

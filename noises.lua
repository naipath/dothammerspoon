--
-- Miscellaneous, use noises
--

local noises = hs.noises.new(
function(noiseType)
	if noiseType == 3 then
		hs.application.frontmostApplication():hide()
	end
end)


function bind(reference, callBack) 
	return function()
		callBack(reference)
	end
end

hs.hotkey.bind(cah, "y", bind(noises, noises.start))
hs.hotkey.bind(cah, "u", bind(noises, noises.stop))
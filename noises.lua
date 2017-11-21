local noises = hs.noises.new(
function(noiseType)
	if noiseType == 3 then
		hs.application.frontmostApplication():hide()
	end
end)

hs.hotkey.bind(cah, "y",  function()
	noises:start()
end)


hs.hotkey.bind(cah, "u",  function()
	noises:stop()
end)
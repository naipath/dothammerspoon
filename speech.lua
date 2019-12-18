--
-- Miscellaneous, use osx speech recognizer to control Spotify
--

local getKeys = function(table)
	local keys = {}
	local n = 0
	for k, v in pairs(table) do
		n = n + 1
		keys[n] = k
	end
	return keys
end

local speeches = {
	lunch = function(a, b)
		hs.caffeinate.lockScreen()
	end,
	start = function(a, b)
		hs.spotify.play()
	end,
	stop = function(a, b)
		hs.spotify.pause()
	end,
	next = function(a, b)
		hs.spotify.next()
	end,
	current = function(a, b)
		hs.spotify.displayCurrentTrack()
	end
}

local speechListener

hs.hotkey.bind(cah, "r", function()
	speechListener = hs.speech.listener.new("spotify-speech-commands")
	speechListener:commands(getKeys(speeches))
	speechListener:foregroundOnly(false)
	speechListener:setCallback(function(a, b)
		speeches[b](a, b)
	end)
	speechListener:start()
end)
hs.hotkey.bind(cah, "t", function()
	if speechListener then
		speechListener:stop()
		speechListener:delete()
	end
end)
--
-- Window hints
--

hs.hints.iconAlpha = 1

hs.hotkey.bind(cah, "h", function()
	hs.hints.windowHints(nil, nil, true)
end)
--
-- Window manipulation
--

hs.window.animationDuration = 0

-- Window hints
hs.hotkey.bind(cah, "E", hs.hints.windowHints)

-- Grid setup

hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 10
hs.grid.GRIDHEIGHT = 2

-- a helper function that returns another function that resizes the current window
-- to a certain grid size.
local gridset = function(x, y, w, h)
	return function()
		local win = hs.window.focusedWindow()
		hs.grid.set(
			win,
			{
				x = x,
				y = y,
				w = w,
				h = h
			},
			win:screen()
		)
	end
end

-- Entire screen
hs.hotkey.bind(cah, "Up", gridset(0, 0, 10, 2))
-- Left 1/2 of the screen
hs.hotkey.bind(cah, "Left", gridset(0, 0, 5, 2))
-- Right 1/2 of the screen
hs.hotkey.bind(cah, "Right", gridset(5, 0, 5, 2))

-- Toggle Fullscreen mode
hs.hotkey.bind(cah, "M", function()
	hs.window.focusedWindow():toggleFullScreen()
end)
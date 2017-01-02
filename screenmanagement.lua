--
-- Screen manipulation
--

-- Move screen to north
hs.hotkey.bind(csh, "Up", function()
    hs.window.focusedWindow():moveOneScreenNorth()
end)
-- Move screen to west
hs.hotkey.bind(csh, "Left", function()
    hs.window.focusedWindow():moveOneScreenWest()
end)
-- Move screen to east
hs.hotkey.bind(csh, "Right", function()
    hs.window.focusedWindow():moveOneScreenEast()
end)
-- Move screen to south
hs.hotkey.bind(csh, "Down", function()
    hs.window.focusedWindow():moveOneScreenSouth()
end)
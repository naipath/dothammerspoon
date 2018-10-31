--
-- Switch between terminal and a different application
--

-- local terminalApp = "com.apple.Terminal"
local terminalApp = "com.googlecode.iterm2"

-- Toggle between the terminal and the previously focussed app

hs.hotkey.bind({"alt"}, "space", function()
    if hs.window.focusedWindow() == nil then
        hs.application.launchOrFocusByBundleID(terminalApp)
    else
        local focussedApp = hs.window.focusedWindow():application():bundleID()
        if focussedApp ~= terminalApp then
            hs.application.launchOrFocusByBundleID(terminalApp)
        else
        	hs.window.switcher.nextWindow()
        end
    end
end)

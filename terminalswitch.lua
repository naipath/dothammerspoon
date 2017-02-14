-- local terminalApp = "com.apple.Terminal"
local terminalApp = "com.googlecode.iterm2"
local previousOpenedApp = ""

-- Toggle between the terminal and the previously focussed app
hs.hotkey.bind({"alt"}, "space", function()
    local focussedApp = hs.window.focusedWindow():application():bundleID()

    if focussedApp ~= terminalApp then
        previousOpenedApp = focussedApp
        hs.application.launchOrFocusByBundleID(terminalApp)
    elseif previousOpenedApp then
        hs.application.launchOrFocusByBundleID(previousOpenedApp)
    end
end)
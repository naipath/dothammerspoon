---
--- Change mac os appearance to light or dark mode
---

local _, darkMode = hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")

hs.hotkey.bind(csh, "l", function()
    darkMode = not darkMode
    hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode = " .. tostring(darkMode))
end)

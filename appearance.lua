---
--- Change mac os appearance to light or dark mode
---

hs.hotkey.bind(csh, "l", function()
    local _, darkMode = hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")
    darkMode = not darkMode
    hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode = " .. tostring(darkMode))
end)

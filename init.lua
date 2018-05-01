-- Auto-reload config
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

--
-- Key defs
--

cah = {"cmd", "alt", "ctrl"}
csh = {"cmd", "ctrl", "shift"}

--
-- Sugar for binding functions
--

function bind(reference, callBack) 
	return function()
		callBack(reference)
	end
end

--
-- Imports
--
require("windowmanagement")
require("terminalswitch")
require("screenmanagement")
require("ping")
require("noises")
require("menubar")
require("speech")

hs.alert.show("Hammerspoon loaded")



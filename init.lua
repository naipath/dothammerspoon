-- Auto-reload hammerspoon
function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

fileWatcher =
	hs.pathwatcher.new(
		os.getenv("HOME") .. "/.hammerspoon/",
		reloadConfig
	):start()

--
-- Key defs
--

cah = { "cmd", "alt", "ctrl" }
csh = { "cmd", "ctrl", "shift" }

--
-- Imports
--
require("windowmanagement")
require("terminalswitch")
require("screenmanagement")
require("desktopBackground")
require("ping")
require("noises")
require("menubar")
require("speech")
require("spotlight")
require("windowhints")
require("usb")
require("appearance")

hs.alert.show("Hammerspoon loaded")


---
--- Play a sound when usb interaction occurs
---

local watchUsbEvents = hs.usb.watcher.new(function (event)
    if event.eventType == 'added' then
        hs.alert.show(event.eventType)
    end
    if event.eventType == 'removed' then
        hs.alert.show(event.eventType)
    end
end)

hs.hotkey.bind(cah, "i", function()
    watchUsbEvents:start()
end)
hs.hotkey.bind(cah, "o", function()
    watchUsbEvents:stop()
end)

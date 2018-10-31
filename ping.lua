--
-- Check internet connection with a ping to 8.8.8.8
--

local successNotification = "display notification \"> ping 8.8.8.8\" with title \"Successful\" sound name \"blow\""
local errorNotification = "display notification \"> ping 8.8.8.8\" with title \"Failed\" sound name \"sosumi\""

local pingResponses = {
	didFail = errorNotification,
	sendPacketFailed = errorNotification,
	receivedPacket = successNotification
}

hs.hotkey.bind(cah, "p", function() 
	hs.network.ping.ping("8.8.8.8", 1, 1, 0.5, "any", function(_, message)
		if pingResponses[message] ~= nil then
			hs.osascript.applescript(pingResponses[message])
		end
	end)
end)

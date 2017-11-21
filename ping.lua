--
-- Use ping to check internet
--

local pingResponses = {
	didFail = "failed",
	sendPacketFailed = "failed",
	receivedPacket = "success"
}

hs.hotkey.bind(cah, "p", function() 
	hs.network.ping.ping("8.8.8.8", 1, 1, 0.5, "any", function(_, message)
		if pingResponses[message] ~= nil then 
			hs.alert.show(pingResponses[message])
		end
	end)
end)
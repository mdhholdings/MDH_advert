RegisterServerEvent("chatMessage")
AddEventHandler('chatMessage', function(source, n, message)
	pm = stringsplit(message, " ")
	if pm[1] == "/ad" then
		CancelEvent()
		--table.remove(pm, 1)
		if pm[2] == nil then
			TriggerClientEvent("chatMessage", source, "", {0,0,0}, "^1Usage: ^7/ad [company] ^3 Companies: fleeca, maze, ammunation, lscustoms, pegasus, taxi, traffic")
		elseif pm[2] ~= nil then
			TriggerClientEvent("mdh:ad:composeAd", source, pm[2])
		end
	elseif pm[1] == "/toggleads" then
			TriggerClientEvent("mdh:ad:toggle", source)
			RconPrint("Toggle Ads")	
	end
end)

RegisterServerEvent("mdh:ad:pushAd")
AddEventHandler("mdh:ad:pushAd", function(company, message)
	TriggerClientEvent("mdh:ad", -1, company, message)
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
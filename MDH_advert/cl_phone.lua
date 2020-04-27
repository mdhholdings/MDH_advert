input = true
textdone = false
adsDisabled = false

RegisterNetEvent("mdh:ad:composeAd")
AddEventHandler("mdh:ad:composeAd", function(company)
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
	local inputText = ""
	input = true
	textdone = false
	Citizen.CreateThread(function()
		while (input == true) do
			Citizen.Wait(10)
			HideHudAndRadarThisFrame()
			if (UpdateOnscreenKeyboard() == 3) then
				if (textdone) then
					input = false
				end
			elseif (UpdateOnscreenKeyboard() == 1) then
				inputText = GetOnscreenKeyboardResult()
				if string.len(inputText) > 0 then
					input = false
					textdone = true
					TriggerServerEvent("mdh:ad:pushAd", company, inputText)
				else
					DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8FS", "", inputText, "", "", "", 64)
				end
			elseif (UpdateOnscreenKeyboard() == 2) then
				if (textdone) then
					input = false
				end
			end
		end
	end)
end)

company= {}
company['fleeca'] = {name = 'fleeca', image = 'CHAR_BANK_FLEECA', title='Fleeca Bank' }
company['maze'] = {name = 'maze', image = 'CHAR_BANK_MAZE', title='Maze Bank' }
company['ammunation'] = {name = 'ammunation', image = 'CHAR_AMMUNATION', title='Ammunation' }
company['lscustoms'] = {name = 'lscustoms', image = 'CHAR_LS_CUSTOMS', title='LS Customs' }
company['pegasus'] = {name = 'pegasus', image = 'CHAR_PEGASUS_DELIVERY', title='Pegasus' }
company['taxi'] = {name = 'taxi', image = 'CHAR_TAXI', title='Downtown Cab Co.' }
company['traffic'] = {name = 'traffic', image = 'CHAR_LS_TOURIST_BOARD', title='LS Traffic Information' }
company['247'] = {name = '247', image = 'CHAR_AMANDA', title='24/7 General Store' }
company['casey'] = {name = 'casey', image = 'CHAR_ALL_PLAYERS_CONF', title='Casy\'s Highway Clearance' }
company['weazel'] = {name = 'weazel', image = 'CHAR_ANDREAS', title='Weazel News' }



RegisterNetEvent("mdh:ad")
AddEventHandler("mdh:ad", function(cmpny, msg)
	if adsDisabled == false then
		drawNotification(company[cmpny].image, 1, msg, company[cmpny].title, "~c~Advertisement")
	end
end)

RegisterNetEvent("mdh:ad:toggle")
AddEventHandler("mdh:ad:toggle", function()
	if adsDisabled then
		adsDisabled = false
		TriggerEvent('chatMessage', "^3MDH Adverts", {255, 0, 0}, "Ads enabled!")
	elseif adsDisabled == false then
		adsDisabled = true
		TriggerEvent('chatMessage', "^3MDH Adverts", {255, 0, 0}, "Ads disabled!")
	end
end)

function drawNotification(picture, icon, message, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationMessage(picture, picture, true, icon, title, subtitle)
end
CreateClientConVar("chatping_enable", "1", true, false, "Enable chatpinging: play a sound when the player's nickname is mentioned by another player in chat.", 0, 1)
CreateClientConVar("chatping_loopback", "0", true, false, "Allows the player to chatping themselves", 0, 1)
CreateClientConVar("chatping_sound", "default", true, false, "Defines a custom sound for chatpinging. Set to 'default' for default addon sound. Set to 'custom' to play a custom sound (must be named 'chatping_sound.wav')")
CreateClientConVar("chatping_alphanumeric", "0", true, false, "Defines whether the addon should ignore non-alphanumeric characters. This can help a bit with names that contain weird characters or that are not usually autocompleted, but it is not perfect and can cause issues with some characters. If set to 0, a perfect match must be achieved to play the sound (this can be done by autocompleting nicknames with the TAB key).", 0, 1)
CreateClientConVar("chatping_casesentitive", "0", true, false, "Defines whether the addon is case-sensitive or not. Disabled by default, enable to only chatping whenever a perfect case-sensitive match is achieved.", 0, 1)

function chatpinging(ply, text)
	-- Close up the function if the addon is disabled or if the player tries to ping themselves without loopback enabled
	if GetConVar('chatping_enable'):GetBool() == false then
		return
	elseif ply:Nick() == LocalPlayer():Nick() && GetConVar('chatping_loopback'):GetBool() == false then
		return
	end

	local pingsound = GetConVar('chatping_sound'):GetString()

	-- Pingsound error handling
	if pingsound != 'default' && pingsound != 'custom' then
		MsgC(Color(255,0,0), "[ERROR] chatping_sound must be either 'default' or 'custom'!")
		return
	elseif pingsound != 'default' && !file.Exists('chatping_sound.wav', 'GAME') then
		MsgC(Color(255,0,0), "[ERROR] chatping_sound not found! Is it a .wav file?")
		return
	end

	-- Store player's nick as a variable
	local nick = LocalPlayer():Nick()

	-- Non-alphanumeric text handling
	if GetConVar('chatping_alphanumeric'):GetBool() == true then
		nick = nick:gsub('%W','')
	end

	-- Non case-sensitive text handling
	if GetConVar('chatping_casesentitive'):GetBool() == false then
		nick = nick:lower()
		text = text:lower()
	end
	
	-- Try and find the nick within the message
	-- If it is found, play sound
	if string.find(text, nick) then
		if pingsound == 'default' then
			-- Play default addon sound
			surface.PlaySound("pingsound.wav")
		else 
			-- Play custom sound file, handle errors
			sound.PlayFile("chatping_sound.wav", "mono", function( station, errCode, errStr )
				if (IsValid(station)) then
					station:Play()
				else
					print( "Error playing sound!", errCode, errStr )
				end
			end)
		end
	end
end

hook.Add("OnPlayerChat", "jg_chatpinghook", chatpinging)

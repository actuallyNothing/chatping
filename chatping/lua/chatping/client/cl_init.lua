-- Client convars
CreateClientConVar("chatping_enable", "1", true, false, "Enable chatpinging: play a sound when the player's nickname is mentioned by another player in chat.", 0, 1)
CreateClientConVar("chatping_sound", "default", true, false, "Defines a custom sound for chatpinging. Set to 'default' for default addon sound. Set to 'custom' to play a custom sound (must be named 'chatping_sound.wav')")
CreateClientConVar("chatping_casesensitive", "0", true, false, "Defines whether the addon is case-sensitive or not. Disabled by default, enable to only chatping whenever a perfect case-sensitive match is achieved.", 0, 1)
CreateClientConVar("chatping_alias_enable", 0, true, false, "Enables an alias to be chatpinged besides your normal nickname. Set with 'chatping_alias'")
CreateClientConVar("chatping_alias", "", true, false, "Set an alias to be chatpinged besides your normal nickname.", 0, 1)

-- If the current gamemode is TTT, add a tab to its helpmenu
if engine.ActiveGamemode() == 'terrortown' then
	include("chatping/client/cl_ttt_help.lua")
end

function Chatping.Main(ply, text)
	-- Close up the function if the addon is disabled or if the player tries to ping themselves
	if GetConVar('chatping_enable'):GetBool() == false then
		return
	elseif ply:Nick() == LocalPlayer():Nick() then
		return
	end

	local pingsound = GetConVar('chatping_sound'):GetString()

	-- Pingsound error handling
	if pingsound != 'default' && pingsound != 'custom' then
		MsgC(Color(255,0,0), "[ERROR] chatping_sound must be either 'default' or 'custom'!\n")
		return
	elseif pingsound != 'default' && !file.Exists('chatping_sound.wav', 'GAME') then
		MsgC(Color(255,0,0), "[ERROR] chatping_sound not found! Is it a .wav file?\n")
		return
	end

	-- Store player's nick and alias as a local variable
	local nick = LocalPlayer():Nick()
	local alias = nick

	-- Non case-sensitive text handling
	if GetConVar('chatping_casesensitive'):GetBool() == false then
		nick = nick:lower()
		alias = alias:lower()
		text = text:lower()
	end

	-- Try and find the nick within the message
	-- If it is found, play sound
	if string.find(text, nick) || string.find(text, alias) then
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

-- Add main hook
hook.Add("OnPlayerChat", "ChatpingMainHook", Chatping.Main)

function addPingTab(dtabs)

	-- Create initial panel and list
  	local padding = dtabs:GetPadding()
  	local margin = 15 / 2
  	local w, h = 630 / 2, 470 / 2
  	local bw, bh = 50 / 2, 25 / 2

	local pingSettings = vgui.Create("DPanelList", dtabs)
	pingSettings:StretchToParent(0,0,padding,0)
	pingSettings:EnableVerticalScrollbar(true)
	pingSettings:SetPadding(10)
	pingSettings:SetSpacing(10)

	-- Create a form
	local pingUI = vgui.Create("DForm", pingSettings)
	pingUI:SetName("Chatping settings")
	pingUI:SetPos(8.8, 8.8)
	pingUI:SetSize(w * 1.8, h - margin * 3 - bh)

	-- Declare an empty variable, reusing it for each setting and item
	local setting = nil
	setting = pingUI:CheckBox("Enable Chatping", "chatping_enable")
	setting:SetTooltip("Enables chatpinging.")

	setting = pingUI:CheckBox("Case-sensitive matching", "chatping_casesensitive")
	setting:SetTooltip("Should the addon care about uppercase letters?")

	setting = pingUI:ComboBox("Chatping sound:", "chatping_sound")
	setting:AddChoice("Default sound", 'default')
	setting:AddChoice("Custom sound", 'custom')

	setting = pingUI:Help("For a custom sound to work, it must be placed inside the /garrysmod/ folder, with a .wav format and the filename 'chatping_sound.wav'!")
	setting:SetColor(Color(0,0,0))

	aliasEnable = pingUI:CheckBox("Enable alias", "chatping_alias_enable")
	setting:SetPos(5,20)
	setting:SetSize(100,20)

	aliasSet = pingUI:TextEntry("Alias:", "chatping_alias")
	setting = pingUI:Help("An alias is another nickname to which the addon will react upon. If enabled, you will be chatpinged whenever your nickname or alias are typed in chat.")
	setting:SetColor(Color(0,0,0))

	-- Add final tab to TTT settings
	dtabs:AddSheet("Chatping", pingSettings, "icon16/comments.png")
end

-- Run only in TTT
if engine.ActiveGamemode() != 'terrortown' then
	return
else
	hook.Add("TTTSettingsTabs", "pingingpanel", addPingTab)
end

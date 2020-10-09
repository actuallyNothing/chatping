function addPingTab(dtabs)
	-- Run only in TTT
	if engine.ActiveGamemode() != 'terrortown' then
		return
	end

	-- Create initial panel and list
	local chatpingPanel = vgui.Create("DPanel")
	local pingSettings = vgui.Create("DPanelList", chatpingPanel)
	pingSettings:StretchToParent(0,0,padding,0)
	pingSettings:EnableVerticalScrollbar(true)
	pingSettings:SetPadding(10)
	pingSettings:SetSpacing(10)
	pingSettings:SetSize(590, 320)

	-- Create a form
	local pingUI = vgui.Create("DForm", pingSettings)
	pingUI:SetName("Chatping settings")
	pingUI:SetSize(590, 320)

	-- Declare an empty variable, reusing it for each setting and item
	-- Each setting is pretty self-explanatory, I'd say
	local setting = nil
	setting = pingUI:CheckBox("Enable Chatping", "chatping_enable")
	setting:SetTooltip("Enables chatpinging.")

	setting = pingUI:CheckBox("Enable Loopback", "chatping_loopback")
	setting:SetTooltip("Allows you to chatping yourself.")

	setting = pingUI:CheckBox("Alphanumerical matching", "chatping_alphanumeric")
	setting:SetTooltip("Should the addon try and delete any symbols from the message before matching with your name?")

	setting = pingUI:CheckBox("Case-sensitive matching", "chatping_casesensitive")
	setting:SetTooltip("Should the addon care about uppercase letters?")

	setting = pingUI:ComboBox("Chatping sound", "chatping_sound")
	setting:AddChoice("Default sound", 'default')
	setting:AddChoice("Custom sound", 'custom')

	setting = pingUI:Help("For a custom sound to work, it must be placed inside the /garrysmod/ folder, with a .wav format and the filename 'chatping_sound.wav'!")
	setting:SetColor(Color(255,0,0))

	// Add final tab to TTT settings
	dtabs:AddSheet("Chatping", chatpingPanel, "icon16/comments.png")
end

hook.Add("TTTSettingsTabs", "pingingpanel", addPingTab)
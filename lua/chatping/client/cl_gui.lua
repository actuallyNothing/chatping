local black = Color(0,0,0)

local soundIcon = Material("icon16/sound.png")

function Chatping:Panel(parent, ttt)
    local pnl

    if (ttt) then
        pnl = vgui.Create("DPanel", parent)
        pnl:SetPaintBackground(false)

        pnl:StretchToParent(0, 0, parent:GetPadding() * 2, 0)
    else
        pnl = parent
    end

    local main = pnl:Add("DPanel")
        main:Dock(FILL)
        if not ttt then main:SetBackgroundColor(Color(170, 170, 170)) end

    local configPanel = main:Add("DPanel")
        configPanel:Dock(LEFT)
        configPanel:SetWidth(pnl:GetWide() / 2)
        configPanel:DockMargin(0, 0, 5, 0)
        configPanel.Paint = function() end

    local enableChatping = configPanel:Add("DCheckBoxLabel")
        enableChatping:SetText(Chatping:GetPhrase("CheckboxEnable"))
        enableChatping:SizeToContents()
        enableChatping:Dock(TOP)
        enableChatping:DockMargin(5,5,5,5)
        enableChatping:SetChecked(self.enable)
        enableChatping:SetTextColor(black)
        enableChatping:SetConVar("chatping_enable")

    local tooltip = configPanel:Add("DLabel")
        tooltip:SetAutoStretchVertical(true)
        tooltip:SetWrap(true)
        tooltip:SetText(Chatping:GetPhrase("CustomSoundTip"))
        tooltip:Dock(TOP)
        tooltip:DockMargin(5,0,5,5)
        tooltip:SetTextColor(black)

    local choiceSegment = configPanel:Add("DPanel")
        choiceSegment:Dock(TOP)
        choiceSegment:DockMargin(5,0,5,5)
        choiceSegment:SetPaintBackground(false)

        local soundTest = choiceSegment:Add("DButton")
            soundTest:Dock(RIGHT)
            soundTest:SetWidth(choiceSegment:GetTall())
            soundTest:SetText("")
            soundTest.DoClick = function() Chatping:Ping() end

        local icon = soundTest:Add("DImage")
            icon:SetMaterial(soundIcon)
            icon:DockMargin(5,5,5,5)
            icon:Dock(FILL)

        local soundChoice = choiceSegment:Add("DComboBox")
            soundChoice:Dock(FILL)
            soundChoice:SetSortItems(false)

            for k,v in pairs(self.Sounds) do
                soundChoice:AddChoice(k:gsub("^%l", string.upper), k, self.Sound == k, v.icon)
            end

            soundChoice:AddChoice(Chatping:GetPhrase("UseCustomSound"), "custom", self.Sound == "custom", "icon16/wrench_orange.png")

            function soundChoice:OnSelect(_, _, data)
                GetConVar("chatping_sound"):SetString(data)
            end

    local caseSensitive = configPanel:Add("DCheckBoxLabel")
        caseSensitive:SetText(Chatping:GetPhrase("CheckboxCaseSensitive"))
        caseSensitive:SizeToContents()
        caseSensitive:Dock(TOP)
        caseSensitive:DockMargin(5,5,5,5)
        caseSensitive:SetChecked(self.casesensitive)
        caseSensitive:SetTooltip(Chatping:GetPhrase("CaseSensitiveTooltip"))
        caseSensitive:SetTextColor(black)
        caseSensitive:SetConVar("chatping_casesensitive")

    local muting = configPanel:Add("DCheckBoxLabel")
        muting:SetText(Chatping:GetPhrase("CheckboxMuting"))
        muting:SizeToContents()
        muting:Dock(TOP)
        muting:DockMargin(5,5,5,5)
        muting:SetChecked(self.muting)
        muting:SetTooltip(Chatping:GetPhrase("MutingTooltip"))
        muting:SetTextColor(black)
        muting:SetConVar("chatping_muting")

    local selfPing = configPanel:Add("DCheckBoxLabel")
        selfPing:SetText(Chatping:GetPhrase("CheckboxSelfPing"))
        selfPing:SizeToContents()
        selfPing:Dock(TOP)
        selfPing:DockMargin(5,5,5,5)
        selfPing:SetChecked(self.selfping)
        selfPing:SetTextColor(black)
        selfPing:SetConVar("chatping_selfping")

    local alias = configPanel:Add("DCheckBoxLabel")
        alias:SetText(Chatping:GetPhrase("CheckboxEnableAlias"))
        alias:SizeToContents()
        alias:Dock(TOP)
        alias:DockMargin(5,5,5,5)
        alias:SetChecked(self.enable_alias)
        alias:SetTextColor(black)
        alias:SetConVar("chatping_enable_alias")

    local aliasOnly = configPanel:Add("DCheckBoxLabel")
        aliasOnly:SetText(Chatping:GetPhrase("CheckboxAliasOnly"))
        aliasOnly:SizeToContents()
        aliasOnly:Dock(TOP)
        aliasOnly:DockMargin(5,5,5,5)
        aliasOnly:SetChecked(self.alias_only)
        aliasOnly:SetTextColor(black)
        aliasOnly:SetConVar("chatping_alias_only")

        function aliasOnly:Think()
            self:SetEnabled(Chatping.enable_alias and not table.IsEmpty(Chatping.Aliases))
        end

    local visualPing = configPanel:Add("DCheckBoxLabel")
        visualPing:SetText(Chatping:GetPhrase("CheckboxVisualPing"))
        visualPing:SetTooltip(Chatping:GetPhrase("VisualPingTooltip"))
        visualPing:SizeToContents()
        visualPing:Dock(TOP)
        visualPing:DockMargin(5,5,5,5)
        visualPing:SetChecked(self.visual_ping)
        visualPing:SetTextColor(black)
        visualPing:SetConVar("chatping_visual_ping")

    local noSound = configPanel:Add("DCheckBoxLabel")
        noSound:SetText(Chatping:GetPhrase("CheckboxNoSound"))
        noSound:SizeToContents()
        noSound:Dock(TOP)
        noSound:DockMargin(5,5,5,5)
        noSound:SetChecked(self.visual_ping)
        noSound:SetTextColor(black)
        noSound:SetConVar("chatping_no_sound")

        function noSound:Think()
            self:SetEnabled(Chatping.visual_ping)
        end

    local languages = configPanel:Add("DComboBox")
        languages:Dock(TOP)
        languages:DockMargin(5,5,5,5)

        for k,v in pairs(Chatping.Languages) do
            languages:AddChoice(v.Language, k, Chatping:GetLanguage() == k, v.Flag)
        end

        function languages:OnSelect(_, _, data)
            GetConVar("chatping_language"):SetString(data)
        end

    local aliasPanel = main:Add("DPanel")
        aliasPanel:Dock(FILL)
        aliasPanel.Paint = function() end

    local buttons = aliasPanel:Add("DPanel")
        buttons:Dock(BOTTOM)
        buttons:SetHeight(30)
        buttons.Paint = function() end

    local aliases = aliasPanel:Add("DListView")
        aliases:Dock(FILL)
        aliases:AddColumn(Chatping:GetPhrase("Aliases"))

    local function addAliasAndLine(str)
        Chatping:AddAlias(str)

        local l = aliases:AddLine(str)
        function l:OnSelect()
            local m = DermaMenu(false, aliases)
            local o = m:AddOption(Chatping:GetPhrase("RemoveAlias"), function()
                Chatping:RemoveAlias(str)
                aliases:RemoveLine(l:GetID())
            end)

            o:SetIcon("icon16/delete.png")

            m:Open()
        end

        l.OnRightClick = l.OnSelect
    end

    for k,v in pairs(Chatping:GetAliases()) do
        addAliasAndLine(k)
    end

    local addAlias = buttons:Add("DButton")
        addAlias:Dock(LEFT)
        addAlias:SetWidth(pnl:GetWide() / 4)
        addAlias:SetText(Chatping:GetPhrase("ButtonAddAlias"))
        function addAlias:DoClick()
            Derma_StringRequest(Chatping:GetPhrase("AliasQueryTitle"),
                Chatping:GetPhrase("AliasQueryHelp"),
                nil,
                function(text)
                    if (text == "" or text:Trim() == "") then return end
                    addAliasAndLine(text)
                end,
                nil,
                Chatping:GetPhrase("OK"),
                Chatping:GetPhrase("Cancel"))
        end

    local resetAliases = buttons:Add("DButton")
        resetAliases:Dock(FILL)
        resetAliases:SetText(Chatping:GetPhrase("ButtonResetAliases"))
        function resetAliases:DoClick()
            Derma_Query(Chatping:GetPhrase("ResetQueryHelp"),
                    Chatping:GetPhrase("ResetQueryTitle"),
                    Chatping:GetPhrase("Reset"),
                    function()
                        Chatping:ResetAliases()
                        aliases:Clear()
                    end,
                    Chatping:GetPhrase("Cancel"))
        end

    function enableChatping:OnChange(val)
        caseSensitive:SetEnabled(val)
        selfPing:SetEnabled(val)
        alias:SetEnabled(val)
        soundChoice:SetEnabled(val)
        muting:SetEnabled(val)

        alias:OnChange(val and alias:GetChecked())
    end

    function alias:OnChange(val)
        addAlias:SetEnabled(val)
        resetAliases:SetEnabled(val)
        aliases:SetDisabled(not val)
    end

    if (ttt) then return pnl end
end

function Chatping:Menu()
    local frame = vgui.Create("DFrame")
    frame:SetSize(500,400)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle(Chatping:GetPhrase("ConfigTitle"):format(self.Version))
    frame:DockMargin(5,5,5,5)

    self:Panel(frame)
end

concommand.Add("chatping", function() Chatping:Menu() end, nil, Chatping:GetPhrase("ConCommandHelp"))

local pingIcon = Material("materials/chatping/bubble.png")

hook.Add("HUDPaint", "ChatpingHUDPaint", function()
    local w,h = 64, 64
    local x,y = 10, (ScrH() / 2) - h / 2

    if (Chatping.Pinging > 0) then
        draw.RoundedBox(6, x, y, w, h, Color(255,255,255, 100))

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial(pingIcon)
        surface.DrawTexturedRect(x + 2.5, y + 2.5, w - 5, h - 5)
    end
end)

----------------------------------------------------------
-- TTT ---------------------------------------------------

function Chatping:TerrorTab(dtabs)
    dtabs:AddSheet(self:Panel(dtabs, true))
end

-- Add hook
hook.Add("TTTSettingsTabs", "ChatpingTerrorHook", function(dtabs)
    dtabs:AddSheet("Chatping", Chatping:Panel(dtabs, true), "icon16/comments.png")
end)
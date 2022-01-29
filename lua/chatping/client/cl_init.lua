-- Aliases file and helper functions
local filedir = "chatping/aliases.json"

function Chatping:ReadAliases()
    Chatping.Aliases = util.JSONToTable(file.Read(filedir))
end

function Chatping:WriteAliases(tbl)
    local j = util.TableToJSON(tbl or Chatping.Aliases)

    file.Write(filedir, j)
end

function Chatping:GetAliases()
    return Chatping.Aliases
end

function Chatping:AddAlias(alias)
    Chatping.Aliases[alias] = true
    Chatping:WriteAliases()
end

function Chatping:RemoveAlias(alias)
    Chatping.Aliases[alias] = nil
    Chatping:WriteAliases()
end

function Chatping:ResetAliases()
    Chatping:WriteAliases({})
    Chatping.Aliases = {}
end

if (not file.Exists(filedir, "DATA")) then
    file.CreateDir("chatping")
    Chatping:WriteAliases({})
end

Chatping:ReadAliases()

-- Language
include("chatping/client/cl_lang.lua")

CreateClientConVar("chatping_language", "en", true, false, Chatping:GetPhrase("chatping_language"))

-- Client convars
local bools = {
    -- Table value indicates whether the
    -- ConVar is enabled by default
    ["enable"] = "1",
    ["casesensitive"] = "0",
    ["enable_alias"] = "0",
    ["muting"] = "1",
    ["selfping"] = "0",
    ["alias_only"] = "0",
    ["visual_ping"] = "0",
    ["no_sound"] = "0"
}

for bool, default in pairs(bools) do
    CreateClientConVar("chatping_" .. bool, default, true, false, Chatping:GetPhrase("chatping_" .. bool), 0, 1)

    Chatping[bool] = GetConVar("chatping_" .. bool):GetBool()
    if (not cvars.GetConVarCallbacks("chatping_" .. bool)) then
        cvars.AddChangeCallback("chatping_" .. bool, function(_, old, new)
            Chatping[bool] = math.floor(tonumber(new)) == 1 and true or false
        end)
    end
end

local clr_red = Color(200,30,30)

CreateClientConVar("chatping_sound", "default", true, false, Chatping:GetPhrase("chatping_sound"))

Chatping.Sound = GetConVar("chatping_sound"):GetString()
if (not cvars.GetConVarCallbacks("chatping_sound")) then
    cvars.AddChangeCallback("chatping_sound", function(cvar, old, new)
        if (not Chatping.Sounds[new] and new ~= "custom") then
            MsgC(clr_red, Chatping:GetPhrase("InvalidSound"):format(new))

            GetConVar(cvar):SetString(old)
            Chatping.Sound = old
        else
            Chatping.Sound = new
        end
    end)
end

if (not cvars.GetConVarCallbacks("chatping_language")) then
    cvars.AddChangeCallback("chatping_language", function(cvar, old, new)
        if (not Chatping.Languages[new]) then
            MsgC(clr_red, "[chatping] Invalid language!\n")

            GetConVar(cvar):SetString(old)
            Chatping:ChangeLanguage(old)
        else
            Chatping:ChangeLanguage(new)
        end
    end)
end

-- Load GUI
include("chatping/client/cl_gui.lua")

Chatping.Pinging = 0

timer.Create("ChatpingVisualPingTimer", 1, 0, function()
    Chatping.Pinging = Chatping.Pinging - 0.5
    Chatping.Pinging = math.Clamp(Chatping.Pinging, 0, 1.5)
end)

function Chatping:Ping(test)
    if (not (Chatping.visual_ping and Chatping.no_sound)) then
        sound.PlayFile("sound/chatping/" .. self.Sound .. ".wav", "mono", function(station, errCode, errStr)
            if (IsValid(station)) then
                station:Play()
            else
                if (errCode == 2 and self.Sound == "custom") then
                    ErrorNoHaltWithStack(Chatping:GetPhrase("NoCustomSoundFound"))
                else
                    ErrorNoHaltWithStack(Chatping:GetPhrase("ChatpingError"):format(self.Sound, errcode or "N/A", errStr or "N/A"))
                end
            end
        end)
    end

    if (Chatping.visual_ping) then Chatping.Pinging = math.Clamp(Chatping.Pinging + 1, 0, 1.5) end
end

do
    -- https://www.lua.org/pil/20.4.html
    local function nocase(s)
      s = string.gsub(s, "%a", function (c)
            return string.format("[%s%s]", string.lower(c), string.upper(c))
          end)
      return s
    end

    local function shouldMatchNick()
        local cond = table.IsEmpty(Chatping.Aliases) or not Chatping.enable_alias
        return not (Chatping.alias_only and not cond)
    end

    function Chatping:Match(text)
        local nick = LocalPlayer():Nick()

        if (shouldMatchNick() and text:find(self.casesensitive and nick or nocase(nick))) then return true
        elseif (Chatping.enable_alias) then
            for k,v in pairs(Chatping:GetAliases()) do
                if (text:find(self.casesensitive and k or nocase(k))) then return true end
            end
        end
    end
end

function Chatping:Main(ply, text)
    if (not self.enable) then return end
    if (ply == LocalPlayer() and not self.selfping) then return end
    if (self.muting and ply:IsMuted()) then return end

    if (self:Match(text)) then
        self:Ping()
    end
end

-- Add main hook
hook.Add("OnPlayerChat", "ChatpingMainHook", function(ply, text) Chatping:Main(ply, text) end)

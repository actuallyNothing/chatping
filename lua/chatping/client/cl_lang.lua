function Chatping:ChangeLanguage(lang)
    Chatping.Language = lang
    cookie.Set("chatping_language", lang)
end

local ck = cookie.GetString("chatping_language")
Chatping:ChangeLanguage(ck or "en")

function Chatping:GetPhrase(phrase, lang)
    if (not lang) then lang = self:GetLanguage() end

    if (not lang or not self.Languages[lang] or not self.Languages[lang][phrase]) then
        lang = "en"

        if (not self.Languages["en"][phrase]) then
            return "Invalid phrase\n"
        end
    end

    return self.Languages[lang][phrase]
end

function Chatping:GetLanguage()
    return GetConVar("chatping_language") and GetConVar("chatping_language"):GetString() or Chatping.Language
end
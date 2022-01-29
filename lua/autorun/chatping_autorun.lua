--[[

    Chatping v1.2.0, made by actuallyNothing
    https://steamcommunity.com/id/actuallyNothing/
    https://github.com/actuallyNothing/chatping/

    Sound credits:
        "Original" by Valve Corporation
        "Default" by Rob Marion (freesound.org)
        "Cowbell" by MATRIXXX_ (freesound.org)
        "Chatroom" by AndreWharn (freesound.org)
        "Droplet" by Porphyr (freesound.org)
        "Confirmation" by original_sound (freesound.org)
        "Pop" by elmasmalo1 (freesound.org)

    Speech bubble icon by apien from www.flaticon.com

--]]

Chatping = Chatping or {}
Chatping.Version = "1.2.0"

Chatping.Sounds = {
    ["original"] = {
        ["icon"] = "icon16/folder_wrench.png"
    },

    ["default"] = {
        ["icon"] = "icon16/arrow_refresh.png"
    },

    ["cowbell"] = {
        ["icon"] = "icon16/bell.png"
    },

    ["chatroom"] = {
        ["icon"] = "icon16/user_comment.png"
    },

    ["droplet"] = {
        ["icon"] = "icon16/cup.png"
    },

    ["confirmation"] = {
        ["icon"] = "icon16/accept.png"
    },

    ["pop"] = {
        ["icon"] = "icon16/heart.png"
    }

}

Chatping.Languages = Chatping.Languages or {}
local langFiles = file.Find("chatping/client/lang/*.lua", "LUA")

local func
if (CLIENT) then func = include else func = AddCSLuaFile end
for _, v in pairs(langFiles) do
    func("chatping/client/lang/" .. v)
end

if CLIENT then
    include("chatping/client/cl_init.lua")
else
    for k,v in pairs(Chatping.Sounds) do
        resource.AddSingleFile("sound/chatping/" .. k .. ".wav")
    end

    resource.AddSingleFile("materials/chatping/bubble.png")

    AddCSLuaFile()
    AddCSLuaFile("chatping/client/cl_init.lua")
    AddCSLuaFile("chatping/client/cl_lang.lua")
    AddCSLuaFile("chatping/client/cl_gui.lua")
end
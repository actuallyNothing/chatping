local L = {}

L.Language = "English"
L.Flag = "flags16/gb.png"

-- CVars
L.chatping_enable = "Enable chatpinging: play a sound when the player's nickname or one of their aliases is mentioned by another player in chat."
L.chatping_sound = "Defines a sound for chatpinging. You can set a default sound by setting this to \'custom\', or choose a default one. More information with the \'chatping\' command."
L.chatping_casesensitive = "Defines whether the addon is case-sensitive or not."
L.chatping_enable_alias = "Enables aliases. Set in the Chatping configuration menu. (open with command \"chatping\")"
L.chatping_muting = "If enabled, players muted through the gamemode's scoreboard or general muting means won't be able to ping you."
L.chatping_selfping = "Allow self-pinging."
L.chatping_alias_only = "Don't ping you when your nick is mentioned, only your aliases. Requires chatping_aliases to be enabled and at least 1 active alias"
L.chatping_visual_ping = "If enabled, a small and brief bright window will be shown when you're pinged."
L.chatping_no_sound = "Disables sound and shows only the visual notification. Requires chatping_visual_ping to be enabled"
L.chatping_language = "Determines Chatping language."

-- Errors
L.InvalidSound = "[chatping] %s is not a valid sound!\n"
L.NoCustomSoundFound = "[chatping error] Couldn't play custom sound! Make sure it's in .wav format, is in the \"sound/chatping\" folder and it's named \"custom.wav\".\n"
L.NoCustomSoundFoundShort = "[chatping] Couldn't play custom sound! Check the console for more details."
L.ChatpingError = "[chatping error] An error ocurred trying to chatping! Try re-joining your game, if the error persists contact the developer (actuallyNothing) with the following information:\n    SOUND: %s\n    CODE: %s\n    STRING: %s\n"
L.ChatpingErrorShort = "[chatping] An error ocurred trying to chatping! Check the console for more details."

-- GUI
L.ConCommandHelp = "Open the Chatping configuration menu."
L.ConfigTitle = "Chatping v%s"

L.OK = "OK"
L.Cancel = "Cancel"
L.Reset = "Reset"

L.CheckboxEnable = "Enable Chatping"
L.CustomSoundTip = "You can make your own custom sound and place it in your /garrysmod/sound/chatping/ folder to hear it every time you get chatpinged. It has to be named \"custom.wav\"."
L.UseCustomSound = "Use a custom sound"
L.CheckboxCaseSensitive = "Case-sensitive matching"
L.CaseSensitiveTooltip = "Whether capital letters matter or not when looking for your name"
L.CheckboxMuting = "Don't receive pings from muted players"
L.MutingTooltip = "If enabled, muting a player through the gamemode's scoreboard will prevent them from pinging you"
L.CheckboxSelfPing = "Allow self-pinging"
L.CheckboxEnableAlias = "Enable aliases"
L.CheckboxAliasOnly = "Only ping aliases"
L.CheckboxVisualPing = "Enable visual ping"
L.VisualPingTooltip = "Show a small window for a bit when you're pinged"
L.CheckboxNoSound = "Visual only"
L.Aliases = "Aliases"
L.RemoveAlias = "Remove alias"
L.ButtonAddAlias = "Add an alias"
L.AliasQueryTitle = "Adding a Chatping alias"
L.AliasQueryHelp = "Enter an alias. If someone sends a message containing this alias, you will be pinged."
L.ButtonResetAliases = "Reset aliases"
L.ResetQueryTitle = "Resetting Chatping aliases"
L.ResetQueryHelp = "Are you sure you want to reset all your aliases?"

Chatping.Languages["en"] = L
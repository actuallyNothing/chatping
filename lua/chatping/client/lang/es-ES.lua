local L = {}

L.Language = "Español"
L.Flag = "flags16/es.png"

-- CVars
L.chatping_enable = "Activa el Chatping: reproduce un sonido cuando el nombre del jugador o uno de sus alias es mencionado por otro en el chat."
L.chatping_sound = "Define un sonido para el Chatping. Puedes elegir uno personalizado, o uno de los que vienen instalados. Más información con el comando \"chatping\"."
L.chatping_casesensitive = "Define si el addon distingue las mayúsculas o no."
L.chatping_enable_alias = "Activa los alias. Configurados en el menú de configuración. (se abre con el comando \"chatping\")"
L.chatping_muting = "Cuando está activado, los jugadores silenciados a través de la tabla de puntuaciones no producen sonidos al mencionarte."
L.chatping_selfping = "Te notifica cuando te mencionas a tí mismo."
L.chatping_alias_only = "No te notifica por tu nick, solamente por tus alias. Requiere activar chatping_aliases y tener al menos 1 alias activo"
L.chatping_visual_ping = "Cuando está activado, muestra una breve y pequeña ventana clara cuando eres notificado."
L.chatping_no_sound = "Desactiva el sonido y solo muestra la notificacón visual. Requiere activar chatping_visual_ping"
L.chatping_language = "Determina el idioma del Chatping."

-- Errors
L.InvalidSound = "[chatping] ¡%s no es un sonido válido!\n"
L.NoCustomSoundFound = "¡No se pudo reproducir el sonido personalizado! Asegúrate de que esté en formato .wav, esté en la carpeta \"sound/chatping\" y tenga el nombre \"custom.wav\".+"
L.ChatpingError = "¡Ocurrió un error en el Chatping! Intenta salir y volver a entrar de la partida, si el error continúa contacta con el desarrollador (actuallyNothing) y dale la siguiente información:\n    SOUND: %s\n    CODE: %s\n    STRING: %s"

-- GUI
L.ConCommandHelp = "Abre la configuración de Chatping."
L.ConfigTitle = "Chatping v%s"

L.OK = "OK"
L.Cancel = "Cancelar"
L.Reset = "Resetear"

L.CheckboxEnable = "Activar Chatping"
L.CustomSoundTip = "Puedes hacer tu propio sonido personalizado y ponerlo en la carpeta /garrysmod/sound/chatping/ para escucharlo cuando seas notificado. Tiene que llamarse \"custom.wav\"."
L.UseCustomSound = "Usar un sonido personalizado"
L.CheckboxCaseSensitive = "Distinguir mayúsculas"
L.CaseSensitiveTooltip = "Determina si las mayúsculas importan al buscar tu nombre"
L.CheckboxMuting = "No ser notificado por jugadores silenciados"
L.MutingTooltip = "Si está activado, no puedes ser notificado por jugadores silenciados a través de la tabla de puntuaciones"
L.CheckboxSelfPing = "Auto-notificaciones"
L.CheckboxEnableAlias = "Activar los alias"
L.CheckboxAliasOnly = "Solo notificar por alias"
L.CheckboxVisualPing = "Activar notificación visual"
L.VisualPingTooltip = "Muestra una pequeña ventana por un momento cada vez que eres notificado"
L.CheckboxNoSound = "Solo notificación visual"
L.Aliases = "Alias"
L.RemoveAlias = "Eliminar este alias"
L.ButtonAddAlias = "Añadir un alias"
L.AliasQueryTitle = "Añadiendo un alias de Chatping"
L.AliasQueryHelp = "Introduce un alias. Si alguien escribe este alias en el chat, serás notificado."
L.ButtonResetAliases = "Limpiar alias"
L.ResetQueryTitle = "Limpiando alias de Chatping"
L.ResetQueryHelp = "¿Seguro que quieres limpiar todos tus alias?"

Chatping.Languages["es-ES"] = L
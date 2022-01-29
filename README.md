#  Chatping
An addon to give both visual and sound notifications to players when they are mentioned in chat by another player.
Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2251170323

![Chatping Interface](https://i.imgur.com/T45CdRY.jpeg)

## Usage

With the default configuration, the addon will play a sound every time the player's name is mentioned in chat (non case-sensitive). Config variables can be tweaked from the console or from the special menu that can be opened by simply typing "chatping" in console.

This menu also allows to add **an indefinite amount of aliases** to also get notified of other mentions or words. This can be userful for users who go by a lot of names, or those in Staff positions that would like to be notified if someone calls for a moderator/admin.

There's a variety of sounds that come installed with the addon, and there's a slot for a custom sound if a user wants to paste in his own notification sound.

Aliases are saved between servers in the garrysmod/data/chatping folder in JSON format.

## ConVars
The addon is almost completely client-side, so all ConVars are client-side too.

- **chatping_enable** (default: 1): Enables Chatping.
- **chatping_sound** (default: "default"): Determines the sound that will be played. Available sounds are "Original", "Default", "Cowbell", "Chatroom", "Droplet", "Confirmation" and "Pop". Setting this to custom will instead play the file garrysmod/sound/chatping/custom.wav.
- **chatping_casesensitive** (default: 0): Determines if name/alias matching is case-sensitive.
- **chatping_enable_alias** (default: 0): Enables the alias system. Aliases need to be set-up through the Chatping interface.
- **chatping_muting** (default: 1): When enabled, players who are muted through the scoreboard won't notify or ping the user.
- **chatping_selfping** (default: 0): Allows the user to ping themselves.
- **chatping_alias_only** (default: 0): Disables pinging for the user's nickname, and only works with aliases. This requires aliases to be enabled and at least 1 active alias.
- **chatping_visual_ping** (default: 0): Shows an icon in the left side of the screen when being pinged.
- **chatping_no_sound** (default: 0): Disables sound and only shows the visual ping. Requires visual pinging to be enabled.

## Translations

The addon is available in English and Spanish, any contributions to both of these languages are appreciated.
Language filenames and keys follow ISO-3166-1 standards, and have a "Flag" key to be shown in the language selector.

## Installation

Alongside the Workshop installation, you can download this repository's code as a ZIP file, and extract it inside your game or server's garrysmod/addons folder.
Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2251170323

## Credits

Sound credits:
    "Original" by Valve Corporation
    "Default" by Rob Marion (freesound.org)
    "Cowbell" by MATRIXXX_ (freesound.org)
    "Chatroom" by AndreWharn (freesound.org)
    "Droplet" by Porphyr (freesound.org)
    "Confirmation" by original_sound (freesound.org)
    "Pop" by elmasmalo1 (freesound.org)

Speech bubble icon by apien from www.flaticon.com

## License

    Chatping is a tool made to notify a player whenever they are mentioned by another player in Garry's Mod.
    Copyright (C) 2022 actuallyNothing

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

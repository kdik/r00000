# GodotSteam for GDNative
An open-source and fully functional Steamworks SDK / API module and plug-in for the Godot Game Engine (version 3.x). For the Windows, Linux, and Mac platforms. 

Additional flavors include:
- [Godot 2.x](https://github.com/Gramps/GodotSteam/tree/godot2)
- [Godot 3.x](https://github.com/Gramps/GodotSteam/tree/godot3)
- [Godot 4.x](https://github.com/Gramps/GodotSteam/tree/godot4)
- [GDExtension](https://github.com/Gramps/GodotSteam/tree/gdextension)
- [Server 3.x](https://github.com/CoaguCo-Industries/GodotSteam-Server/tree/godot3)
- [Server 4.x](https://github.com/CoaguCo-Industries/GodotSteam-Server/tree/godot4)
- [Server GDExtension](https://github.com/CoaguCo-Industries/GodotSteam-Server/tree/gdextension)
- [Server GDNative](https://github.com/CoaguCo-Industries/GodotSteam-Server/tree/gdnative)

Documentation
----------
[Documentation is available here](https://godotsteam.com/).

Feel free to chat with us about GodotSteam on the [CoaguCo Discord server](https://discord.gg/SJRSq6K).

Current Build
----------
You can [download pre-compiled versions _(currently v3.21.2)_ of this repo here](https://github.com/Gramps/GodotSteam/releases).

**Version 3.21.2 Changes**
- Fixed: `receiveMessagesOnChannel`, `receiveMessagesOnPollGroup`, and `receiveMessagesOnConnection` had overwriting dictionary keys

**Version 3.21.1 Changes**
- Removed: unneccesary steam.tscn and linked steam.gd directly

**Version 3.21 Changes**
- Added: new enums and constant related to new Steam initialization function
- Added: new enums for NetworkingConfigValue
- Added: new intialization function `steamInitEx` that is more verbose
- Added: new UGC function `getUserContentDescriptorPreferences`
- Added: new Remote Play function `startRemotePlayTogether`
- Changed: UGC function`setItemTags` to have new argument for admin tags
- Changed: compatible with Steamworks SDK 1.58

[You can read more change-logs here.](https://godotsteam.com/changelog/gdnative/)

Known Issues
----------
- The GDNative version does not allow for default arguments in functions, thus some functions may have odd behaviors.  If you are using this version of GodotSteam you are required to pass any argument that has a default in the module version. Also, there are no enums in the GDNative version due to how it is structured.
- The function `setRichPresence` when used on Windows will occasionally send the key as the value. This behavior does not happen on Linux nor OSX; it also doesn't exist in any versions of the module nor GDExtension.  In which case, please check your rich presence is set correctly by reading the rich presence back when using Windows and GDNative.

Quick How-To
----------
Obtain the plugin through one of two ways:
- Visit the Godot Asset Library either through the website or in the editor and search for GodotSteam.
- Download this repo and unzip it into the base of your game project.

Go into **Project > Settings > Plugins** and activate the plugin.

Tinker with Steamworks!

Donate
-------------
Pull-requests are the best way to help the project out but you can also donate through [Github Sponsors](https://github.com/sponsors/Gramps), [Ko-Fi](https://ko-fi.com/grampsgarcia), or [Paypal](https://www.paypal.me/sithlordkyle)!

License
-------------
MIT license

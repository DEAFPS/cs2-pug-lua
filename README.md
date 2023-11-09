# A Counter-Strike: 2 Server Pug & Prac plugin written in LUA

⚠ This Lua project will not receive any more features due to the limitations of the Lua API! Lua VScript is intentionally disabled by Valve! It is expected to be replaced by Pulse in the future, and will likely be completely removed from the game when that happens. Depend on Lua at your own risk.

![alt text](https://i.imgur.com/mblcbTI.jpeg)

### Dependencies

This plugin requires unlocking LUA VScript!

Lua Unlocker MetaMod Plugin: https://github.com/Source2ZE/LuaUnlocker

Lua Patcher (use if you are not using MetaMod, and make sure your server runs -insecure): https://github.com/bklol/vscriptPatch

### Installing

* Unzip into your servers `game/csgo` folder and
* Add `exec dea_pugplugin` to your servers gamemode cfg (e.g. `gamemode_competitive.cfg`)

### Configuration

* To configure the plugin head to `game/csgo/scripts/vscripts/pug_cfg.lua`

  Feel free to change the variables to what you desire! Make sure to read their --comments

  ⚠ Disable `autokickOnMapChange` if your server crashes after using `changemap` ⚠
  
* To whitelist players add their SteamID3 to the allowedPlayers table in whitelist.lua

* To add admins edit the `adminPlayers` table in `pug_cfg.lua`

* To add custom nade lineups for the Pracc mode navigate to `game/csgo/cfg/dea_pugplugin_praccnades.cfg` and follow the example given there

## Admin Commands
- `adminhelp`            --Prints these commands into chat
- `adminsay hello`       --Prints a message in chat with a admin nametag
- `startpug`             --Starts the pug
- `pausepug`             --Pauses the pug
- `unpausepug`           --Unpauses the pug
- `restartpug`           --Compleatly restarts the pug
- `scramble`             --Shuffles teams
- `rewarmup`             --Restarts warmup phase
- `pugkick id`           --Kicks the player (use `status` to get the player id you want to kick)
- `changemap de_dust2`   --Changes map

## Pracc Commands
- `pracc`            --Enables pracc mode
- `pracchelp`            --prints these commands in chat
- `savenade "mynade" "type" "description"`      --Saves a nade lineup with the given name, description and type. Valid types: smoke, he, falsh, molly
- `loadnade mynade`      --Loads a nade lineup
- `importnade` "code"    --Imports a nade from a nade code
- `allsmoke`             --Shows all saved smokes
- `allmolly`             --Shows all saved molotovs
- `allhe`                --Shows all saved HE nades
- `allflash`             --Shows all saved flashes

## Author
[@DEAFPS_](https://twitter.com/deafps_)

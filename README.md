# A Counter-Strike: 2 Server Pug plugin written in LUA

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

## Admin Commands
- `adminhelp`            --prints these commands into chat
- `adminsay hello`       --prints a message in chat with a admin nametag
- `startpug`             --starts the pug
- `pausepug`             --pauses the pug
- `unpausepug`           --unpauses the pug
- `restartpug`           --compleatly restarts the pug
- `scramble`             --shuffles teams
- `rewarmup`             --restarts warmup phase
- `pugkick id`           --kicks the player (use `status` to get the player id you want to kick)
- `changemap de_dust2`   --changes map

## Pracc Commands
- `savenade mynade`      --saves a nade lineup with a given name
- `loadnade mynade`      --loads a nade lineup
- `importnade` "mynade 200 2500 100 -25 -140 0.00" --imports a nade from a nade code
- `pracchelp`            --prints these commands in chat

# Some Nade Codes to import
- Nuke Outside Cross JT `"outside_jumpthrow -1349.97 -968.03 -399.97 -12.03 -27.06 0.00"`
- Nuke Solo Secret Cross JT `"secret_jumpthrow -1349.97 -968.03 -399.97 -28.23 -28.60 0.00"`
- Nuke A Heaven JT `"a_haven_jumpthrow -1180.03 -1263.97 -319.97 -14.76 23.13 0.00"`
- Inferno CT `"inferno_ct 371.23 1661.56 134.03 -32.74 64.58 0.00"`

## Author
[@DEAFPS_](https://twitter.com/deafps_)

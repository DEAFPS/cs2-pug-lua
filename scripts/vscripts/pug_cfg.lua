chatPrefix = "{red} [DEAFPS PUG] "      --appears before every plugin related chat msg
warmupEndless = true
warmupTime = "234124235"                --default is infinite
waitingForPlayerMsgInterval = 2		--how long the delay in seconds should be between sending "waiting for players" chat msgs

enableWhitelist = false                  --if whitelist shall be on or off
kzsettingsinwarmup = true               --whacky kz settings in warmup only
kzsettings = false                      --whacky kz settings globally
teamSize = 5                            --amount of players per team
votingEnabled = true                    --if players are able to vote to start the pug

autokickOnMapChange = true		--on map change the player isnt reconnecting to the server which means the player_connected event cannot fetch their usernames, ids or steamids
					--for the banlist/whitelist and the readyup feature. Leaving this on true will kick all players first whenever the "changemap" admin command is used
					--to ensure they reconnect.
					--Warning: LUA being LUA on servers with high traffic or low hardware it can cause a freeze, because players arent kicked fast enough.

timeoutsPerTeam = 3                     --amount of timeout votes allowed per team
timeoutDuration = 30                    --timeout duration


useCustomCFG = false 			-- if a custom cfg should be used

customCFG = "crazywhackysettings.cfg" 	-- place your custom cfg into the cfg folder and put name here.
					-- make sure to not use mp_restartgame since that is being handled by the plugin already


adminPlayers = {			--admins/constantly whitelisted, same as with the whitelist table use a SteamID3
	"[U:0:00000000]", --admin example
	"[U:0:00000000]", --admin example
}
